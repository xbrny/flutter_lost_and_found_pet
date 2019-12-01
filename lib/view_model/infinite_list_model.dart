import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

typedef Future<List<DocumentSnapshot>> FetchApiCallback();

typedef T FromDocumentSnapshotCallback<T>(DocumentSnapshot jsonMap);

enum ListState {
  uninitialized,
  initializing,
  fetched,
  fetchingMore,
  hasReachedEnd,
  refreshing,
  empty,
}

abstract class InfiniteListModel<T> extends ChangeNotifier {
  ListState listState = ListState.uninitialized;

  DocumentSnapshot lastDocument;

  List<T> list = [];

  bool isDeleting = false;

  @protected
  Future<void> initializeUsingApi(
    FetchApiCallback fetchApi,
    FromDocumentSnapshotCallback<T> fromDocumentSnapshotCallback,
  ) async {
    listState = ListState.initializing;

    lastDocument = null;

    List<DocumentSnapshot> rawList = await fetchApi();

    if (rawList.length == 0) {
      listState = ListState.empty;
      notifyListeners();
      return;
    }

    lastDocument = rawList.last;

    List<T> typedList = rawList
        .map((document) => fromDocumentSnapshotCallback(document))
        .toList();

    list = typedList;
    listState = ListState.fetched;
    notifyListeners();
  }

  @protected
  Future<void> fetchMoreUsingApi(
    FetchApiCallback fetchApi,
    FromDocumentSnapshotCallback<T> fromDocumentSnapshotCallback,
  ) async {
    if (listState == ListState.fetchingMore ||
        listState == ListState.hasReachedEnd) {
      return;
    }

    listState = ListState.fetchingMore;
    notifyListeners();

    List<DocumentSnapshot> rawList = await fetchApi();

    if (rawList.length == 0) {
      listState = ListState.hasReachedEnd;
      notifyListeners();
      return;
    }

    lastDocument = rawList.last;

    List<T> typedList = rawList
        .map((document) => fromDocumentSnapshotCallback(document))
        .toList();

    list.addAll(typedList);
    listState = ListState.fetched;
    notifyListeners();
  }

  @protected
  Future<void> refreshUsingApi(
    FetchApiCallback fetchApi,
    FromDocumentSnapshotCallback<T> fromDocumentSnapshotCallback,
  ) async {
    listState = ListState.refreshing;
    notifyListeners();

    lastDocument = null;

    List<DocumentSnapshot> rawList = await fetchApi();

    if (rawList.length == 0) {
      listState = ListState.empty;
      notifyListeners();
      return;
    }

    lastDocument = rawList.last;

    List<T> typedList = rawList
        .map((document) => fromDocumentSnapshotCallback(document))
        .toList();

    list = typedList;
    listState = ListState.fetched;
    notifyListeners();
  }

  void prependList(T item) {
    list = <T>[]
      ..add(item)
      ..addAll(list);
    notifyListeners();
  }

  void updateListItem(T item);

  void deleteListItem(String id);

  Future<void> initialize();

  Future<void> fetchMore();

  Future<void> refresh();
}
