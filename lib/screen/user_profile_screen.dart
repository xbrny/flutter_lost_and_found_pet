import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/util.dart';
import 'package:lost_found_pet_prototype/view_model/auth_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:lost_found_pet_prototype/widget/close_icon_button.dart';
import 'package:lost_found_pet_prototype/widget/infinite_list.dart';
import 'package:lost_found_pet_prototype/widget/post_item_card.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  ScrollController _scrollController;
  UserPostListModel model;
  FirebaseUser _user;

  final _scrollThreshold = 150;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    Provider.of<UserPostListModel>(context, listen: false).initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    model.cleanupList();
  }

  Future<void> _signOut() async {
    await Provider.of<AuthModel>(context).signOut();
    Navigator.maybePop(context);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if ((maxScroll - currentScroll) <= _scrollThreshold) {
      model.fetchMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<FirebaseUser>(context);
    model = Provider.of<UserPostListModel>(context);
    final systemTrayHeight = MediaQuery.of(context).padding.top;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final profileIcon = Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: theme.primaryColor,
      ),
      child: Icon(
        LineIcons.user,
        color: Colors.white,
      ),
    );

    final signOutButton = Theme(
      data: theme.copyWith(
        buttonTheme: theme.buttonTheme.copyWith(
          height: 36,
          minWidth: 0,
          padding: EdgeInsets.symmetric(horizontal: kSpaceMedium),
        ),
      ),
      child: RaisedButton(
        onPressed: _signOut,
        child: Text(
          'Sign Out',
          style: textTheme.button.copyWith(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );

    Widget buildHeader() {
      return Container(
        padding: EdgeInsets.only(top: systemTrayHeight),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CloseIconButton(
                  back: true,
                ),
              ],
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: profileIcon,
                    title: Text(
                      getEmailPrefix(_user?.email) ?? '',
                      style: textTheme.headline,
                    ),
                    subtitle: Text(_user?.email ?? ''),
                    trailing: signOutButton,
                  ),
                  Divider(
                    indent: kScreenPadding,
                    endIndent: kScreenPadding,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: kScreenPadding,
                      left: kScreenPadding,
                      right: kScreenPadding,
                    ),
                    child: Text(
                      'My Post',
                      style: textTheme.title.copyWith(
                        color: textTheme.body1.color,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget buildPostList() {
      return RawInfiniteList(
        list: model.list,
        listState: model.listState,
        builder: (Post post) {
          return PostListItem(post: post);
        },
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await model.refresh();
        },
        child: ListView(
          padding: EdgeInsets.all(0),
          controller: _scrollController,
          children: [
            buildHeader(),
            buildPostList(),
          ],
        ),
      ),
    );
  }
}
