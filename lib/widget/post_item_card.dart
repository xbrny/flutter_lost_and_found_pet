import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/router.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/ui_helpers.dart';
import 'package:lost_found_pet_prototype/util/util.dart';
import 'package:lost_found_pet_prototype/view_model/post_list_model.dart';
import 'package:lost_found_pet_prototype/view_model/post_model.dart';
import 'package:lost_found_pet_prototype/widget/horizontal_line.dart';
import 'package:provider/provider.dart';

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({Key key, this.post}) : super(key: key);

  Widget _getImage() {
    if (post.imageUrl != null && post.imageUrl.length > 0) {
      return Image.network(
        post.imageUrl.first,
        fit: BoxFit.cover,
        height: 150,
        width: 170,
      );
    } else {
      return Image.asset(
        'images/default-pet-large.png',
        fit: BoxFit.cover,
        height: 150,
        width: 170,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authUser = Provider.of<FirebaseUser>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final dateTimeLost = getTimeAgo(post.dateTimeLost);
    final userPostListModel = Provider.of<UserPostListModel>(context);

    Widget _buildThumbnail() {
      return Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(kSpaceSmall),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(kSpaceSmall),
          child: _getImage(),
        ),
      );
    }

    Widget _buildContentContainer() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: 150,
          top: kSpaceExtraSmall,
          bottom: kSpaceExtraSmall,
        ),
        padding: EdgeInsets.fromLTRB(
          kSpaceMedium + 20,
          kSpaceMedium,
          kSpaceMedium,
          kSpaceMedium,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kSpaceExtraSmall),
          border: Border.all(
            color: Colors.grey.shade100,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    post.name,
                    style: textTheme.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                UIHelper.horizontalSpaceMini(),
                (authUser?.uid != post.uid)
                    ? Container()
                    : GestureDetector(
                        child: userPostListModel.isDeleting
                            ? SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              )
                            : Icon(
                                LineIcons.trash,
                                color: theme.colorScheme.error,
                              ),
                        onTap: () async {
                          await userPostListModel.delete(post.id);
                          Provider.of<LostPostListModel>(context, listen: false)
                              .deleteListItem(post.id);
                          Provider.of<FoundPostListModel>(context,
                                  listen: false)
                              .deleteListItem(post.id);
                        },
                      ),
              ],
            ),
            HorizontalLine(),
            Row(
              children: <Widget>[
                Icon(
                  LineIcons.map_marker,
                  size: 18,
                  color: textTheme.subtitle.color,
                ),
                UIHelper.horizontalSpaceMini(),
                Flexible(
                  child: Text(
                    post.location,
                    style: textTheme.subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceExtraSmall(),
            Row(
              children: <Widget>[
                Icon(
                  LineIcons.calendar,
                  size: 18,
                  color: textTheme.subtitle.color,
                ),
                UIHelper.horizontalSpaceMini(),
                Flexible(
                  child: Text(
                    dateTimeLost,
                    style: textTheme.subtitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    void _selectAndNavigateToPost() {
      Provider.of<SelectedPostModel>(context).setSelectedPost(post);
      Navigator.pushNamed(context, Router.postDetails);
    }

    return Container(
      height: 150,
      margin: EdgeInsets.all(kScreenPadding),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: _buildContentContainer(),
            onTap: _selectAndNavigateToPost,
          ),
          GestureDetector(
            child: _buildThumbnail(),
            onTap: _selectAndNavigateToPost,
          ),
        ],
      ),
    );
  }
}
