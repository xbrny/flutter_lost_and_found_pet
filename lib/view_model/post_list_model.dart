import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:lost_found_pet_prototype/api/abstract_post_api.dart';
import 'package:lost_found_pet_prototype/api/abstract_user_api.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/service_locator.dart';
import 'package:lost_found_pet_prototype/view_model/infinite_list_model.dart';

/*----------------------------*/
abstract class TypedPostListModel extends InfiniteListModel<Post> {
  final AbstractPostApi postApi = locator<AbstractPostApi>();

  @protected
  Future<void> initializeByPostType(PostType postType) async {
    initializeUsingApi(
      () async {
        return await postApi.fetchByTypeRaw(postType, lastDocument);
      },
      Post.fromDocumentSnapshot,
    );
  }

  @protected
  Future<void> fetchMoreByPostType(PostType postType) async {
    await fetchMoreUsingApi(
      () async {
        return await postApi.fetchByTypeRaw(postType, lastDocument);
      },
      Post.fromDocumentSnapshot,
    );
  }

  @protected
  Future<void> refreshByPostType(PostType postType) async {
    await refreshUsingApi(
      () async {
        return await postApi.fetchByTypeRaw(postType, lastDocument);
      },
      Post.fromDocumentSnapshot,
    );
  }

  @override
  void deleteListItem(String id) {
    list = list.where((listItem) => listItem.id != id).toList();
    notifyListeners();
  }

  @override
  void updateListItem(Post item) {
    list = list
        .map((listItem) => listItem.id == item.id ? item : listItem)
        .toList();

    notifyListeners();
  }

  Future<void> delete(String id) async {
    try {
      await postApi.delete(id);
      deleteListItem(id);
    } catch (e) {
      throw e;
    }
  }
}

/*----------------------------*/
class LostPostListModel extends TypedPostListModel {
  PostType postType = PostType.lost;

  @override
  Future<void> initialize() async {
    await initializeByPostType(postType);
  }

  @override
  Future<void> fetchMore() async {
    await fetchMoreByPostType(postType);
  }

  @override
  Future<void> refresh() async {
    await refreshByPostType(postType);
  }
}

/*----------------------------*/
class FoundPostListModel extends TypedPostListModel {
  PostType postType = PostType.found;

  @override
  Future<void> initialize() async {
    await initializeByPostType(postType);
  }

  @override
  Future<void> fetchMore() async {
    await fetchMoreByPostType(postType);
  }

  @override
  Future<void> refresh() async {
    await refreshByPostType(postType);
  }
}

/*----------------------------*/
class UserPostListModel extends InfiniteListModel<Post> {
  final userApi = locator<AbstractUserApi>();
  final postApi = locator<AbstractPostApi>();

  @override
  Future<void> initialize() async {
    FirebaseUser user = await userApi.getAuthUser();
    if (user == null) {
      listState = ListState.empty;
      notifyListeners();
      return;
    }

    await initializeUsingApi(
      () async {
        return await postApi.fetchByUidRaw(user.uid, lastDocument);
      },
      Post.fromDocumentSnapshot,
    );
  }

  @override
  Future<void> fetchMore() async {
    FirebaseUser user = await userApi.getAuthUser();
    if (user == null) {
      listState = ListState.empty;
      notifyListeners();
      return;
    }

    await fetchMoreUsingApi(
      () async {
        return await postApi.fetchByUidRaw(user.uid, lastDocument);
      },
      Post.fromDocumentSnapshot,
    );
  }

  @override
  Future<void> refresh() async {
    FirebaseUser user = await userApi.getAuthUser();
    if (user == null) {
      listState = ListState.empty;
      notifyListeners();
      return;
    }

    await refreshUsingApi(
      () async {
        return await postApi.fetchByUidRaw(user.uid, lastDocument);
      },
      Post.fromDocumentSnapshot,
    );
  }

  Future<void> delete(String id) async {
    try {
      isDeleting = true;
      notifyListeners();
      await postApi.delete(id);
      await refresh();
    } catch (e) {
      throw e;
    } finally {
      isDeleting = false;
      notifyListeners();
    }
  }

  @override
  void deleteListItem(String id) {
    list = list.where((listItem) => listItem.id != id).toList();
    notifyListeners();
  }

  @override
  void updateListItem(Post item) {
    list = list
        .map((listItem) => listItem.id == item.id ? item : listItem)
        .toList();

    notifyListeners();
  }

  void cleanupList() {
    list = [];
    lastDocument = null;
  }
}
