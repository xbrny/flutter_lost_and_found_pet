import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/view_model/infinite_list_model.dart';
import 'package:provider/provider.dart';

class InfiniteList<T extends InfiniteListModel> extends StatefulWidget {
  final Function builder;
  final int scrollThreshold;

  InfiniteList({
    @required this.builder,
    this.scrollThreshold = 200,
  });

  @override
  _InfiniteListState createState() => _InfiniteListState<T>();
}

class _InfiniteListState<T extends InfiniteListModel>
    extends State<InfiniteList> {
  final _scrollController = ScrollController();
  InfiniteListModel _infiniteListNotifier;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if ((maxScroll - currentScroll) <= widget.scrollThreshold) {
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
    final listState = _infiniteListNotifier.listState;
    final list = _infiniteListNotifier.list;
    final refresh = _infiniteListNotifier.refresh;

    return new RawInfiniteList(
      list: list,
      listState: listState,
      scrollController: _scrollController,
      builder: widget.builder,
      onRefresh: refresh,
    );
  }
}

class RawInfiniteList extends StatelessWidget {
  final ScrollController scrollController;
  final ListState listState;
  final List list;
  final Function builder;
  final RefreshCallback onRefresh;

  RawInfiniteList({
    this.scrollController,
    @required this.listState,
    @required this.list,
    @required this.builder,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    switch (listState) {
      case ListState.uninitialized:
      case ListState.initializing:
        return Center(
          child: CircularProgressIndicator(),
        );
      case ListState.empty:
        return Center(
          child: Text('There\'s no item in the list '),
        );
      case ListState.fetched:
      case ListState.refreshing:
        return _buildListView();
      case ListState.fetchingMore:
        return _buildListView(listState);
      case ListState.hasReachedEnd:
      default:
        return _buildListView(listState);
    }
  }

  Widget _buildListView([ListState listState]) {
    int itemCount = (listState == ListState.fetchingMore ||
            listState == ListState.hasReachedEnd)
        ? list.length + 1
        : list.length;

    Widget _listView = ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: (_, index) {
        if (index >= list.length && listState == ListState.fetchingMore) {
          return Container(
            alignment: Alignment.center,
            height: kBottomNavigationBarHeight,
            child: CircularProgressIndicator(),
          );
        }

        if (index >= list.length && listState == ListState.hasReachedEnd) {
          return Container(
            alignment: Alignment.center,
            height: kBottomNavigationBarHeight,
            child: Text('You have reached the end of the list'),
          );
        }

        return builder(list[index]);
      },
    );

    if (onRefresh == null) {
      return _listView;
    }

    return RefreshIndicator(child: _listView, onRefresh: onRefresh);
  }
}
