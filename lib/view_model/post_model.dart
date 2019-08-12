import 'package:flutter/foundation.dart';
import 'package:lost_found_pet_prototype/api/abstract_post_api.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/service_locator.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class SelectedPostModel extends ChangeNotifier {
  Post _selectedPost;

  Post get selectedPost => _selectedPost;

  setSelectedPost(Post post) {
    _selectedPost = post;
    notifyListeners();
  }
}

class CreatePostModel extends ChangeNotifier {
  final postApi = locator<AbstractPostApi>();

  CreatePostModel();

  Future<void> createPost(
    Post post,
    List<Asset> images,
    TypedPostListModel postListNotifier,
  ) async {
    await postApi.create(post, images);
    postListNotifier.refresh();
  }
}
