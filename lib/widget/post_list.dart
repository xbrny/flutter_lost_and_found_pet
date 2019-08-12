import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/view_model/infinite_list_model.dart';
import 'package:provider/provider.dart';

class PostList<T extends InfiniteListModel> extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState<T>();
}

class _PostListState<T extends InfiniteListModel> extends State<PostList> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 150;
  InfiniteListModel _infiniteListNotifier;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if ((maxScroll - currentScroll) <= _scrollThreshold) {
      _infiniteListNotifier.fetchMore();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _infiniteListNotifier = Provider.of<T>(context);
    return Container();

//    return InfiniteList(
//      items: _infiniteListNotifier.list,
//      isLoadingMore: _infiniteListNotifier.isLoadingMore,
//      hasReachedEnd: _infiniteListNotifier.hasReachedEnd,
//      onLoadMore: _infiniteListNotifier.fetch,
//      builder: (post) => PostItemCard(post: post),
//    );
  }
}
