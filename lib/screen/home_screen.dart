import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/router.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/ui_helpers.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:lost_found_pet_prototype/view_model/tab_model.dart';
import 'package:lost_found_pet_prototype/widget/infinite_list.dart';
import 'package:lost_found_pet_prototype/widget/new_post_fab.dart';
import 'package:lost_found_pet_prototype/widget/post_item_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LostPostListModel>(context, listen: false).initialize();
    Provider.of<FoundPostListModel>(context, listen: false).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final tabModel = Provider.of<TabModel>(context);
    final authUser = Provider.of<FirebaseUser>(context);
    final currentTab = tabModel.currentTab;
    final theme = Theme.of(context);

    Widget _buildProfileIcon() {
      return Padding(
        padding: const EdgeInsets.only(left: kSpaceSmall),
        child: Icon(
          LineIcons.paw,
          size: 32,
        ),
      );
    }

    Widget _buildPostTypeButtons() {
      return Theme(
        data: theme.copyWith(
          buttonTheme: theme.buttonTheme.copyWith(
            height: 32,
            minWidth: 0,
            padding: EdgeInsets.symmetric(horizontal: kSpaceMedium),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton(
                  textColor: (currentTab == 0) ? theme.primaryColor : null,
                  onPressed: () {
                    tabModel.setTab(0);
                  },
                  child: Text('Lost'),
                ),
                UIHelper.horizontalSpaceSmall(),
                FlatButton(
                  textColor: (currentTab == 1) ? theme.primaryColor : null,
                  onPressed: () {
                    tabModel.setTab(1);
                  },
                  child: Text('Found'),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildFilterRow() {
      return Consumer2<LostPostListModel, FoundPostListModel>(
          builder: (context, lostModel, foundModel, _) {
        final lostCount = lostModel.list.length?.toString();
        final foundCount = foundModel.list.length?.toString();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Total: ${(tabModel.currentTab == 0) ? lostCount : foundCount}',
              style: theme.textTheme.body1.copyWith(
                color: theme.primaryColor,
              ),
            ),
            IconButton(
              icon: Icon(LineIcons.sliders),
              onPressed: () {},
            ),
          ],
        );
      });
    }

    Widget _buildLostPostList() {
      return InfiniteList<LostPostListModel>(
        builder: (Post post) {
          return PostListItem(post: post);
        },
      );
    }

    Widget _buildFoundPostList() {
      return InfiniteList<FoundPostListModel>(
        builder: (Post post) {
          return PostListItem(post: post);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _buildProfileIcon(),
        title: _buildPostTypeButtons(),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              if (authUser == null) {
                Navigator.pushNamed(context, Router.userLogin);
              } else {
                Navigator.pushNamed(context, Router.userProfile);
              }
            },
            child: Container(
              width: 35,
              margin: EdgeInsets.only(right: kSpaceMedium),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.primaryColor,
              ),
              child: Icon(
                LineIcons.user,
                color: Colors.white,
              ),
            ),
          )
        ],
        bottom: AppBar(
          automaticallyImplyLeading: false,
          title: _buildFilterRow(),
        ),
      ),
      body: IndexedStack(
        index: currentTab,
        children: <Widget>[
          _buildLostPostList(),
          _buildFoundPostList(),
        ],
      ),
      floatingActionButton: NewPostFloatingActionButton(),
    );
  }
}
