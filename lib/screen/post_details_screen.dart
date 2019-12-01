import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lost_found_pet_prototype/model/post.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/util/ui_helpers.dart';
import 'package:lost_found_pet_prototype/util/util.dart';
import 'package:lost_found_pet_prototype/view_model/post_model.dart';
import 'package:lost_found_pet_prototype/widget/app_bar_title.dart';
import 'package:lost_found_pet_prototype/widget/horizontal_line.dart';
import 'package:lost_found_pet_prototype/widget/reusable_app_bar.dart';
import 'package:provider/provider.dart';

class PostDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _selectedPostNotifier = Provider.of<SelectedPostModel>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final post = _selectedPostNotifier.selectedPost;
    final postType = Post.postTypeToJson(post.postType);
    final isAdditionalDetailEmpty =
        post.additionalDetails.isEmpty || post.additionalDetails == null;
    final isBreedEmpty = post.breed.isEmpty || post.breed == null;

    Widget _buildSwiper() {
      bool hasImage = post.imageUrl != null && post.imageUrl.length > 0;

      return Hero(
        tag: 'post-image-${post.id}',
        child: Container(
          margin: EdgeInsets.all(kSpaceMedium),
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
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
            child: Swiper(
              itemCount: hasImage ? post.imageUrl.length : 1,
              itemBuilder: (_, index) {
                if (hasImage) {
                  return Image.network(
                    post.imageUrl[index],
                    fit: BoxFit.cover,
                  );
                }

                return Image.asset('images/default-pet-large.png');
              },
              loop: false,
              pagination:
                  (post.imageUrl.length > 1) ? SwiperPagination() : null,
            ),
          ),
        ),
      );
    }

    Widget _buildContentContainer() {
      return Container(
        padding: EdgeInsets.fromLTRB(
          kScreenPadding,
          kScreenPadding,
          kScreenPadding,
          kSpaceExtraLarge,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: kSpaceMedium),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: theme.primaryColor,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: kScreenPadding,
                      vertical: kSpaceMini,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kSpaceLarge),
                      color: theme.primaryColor,
                    ),
                    child: Text(
                      postType.toUpperCase(),
                      style: textTheme.overline.copyWith(color: Colors.white),
                    ),
                  ),
                  UIHelper.verticalSpaceExtraSmall(),
                  Text(
                    post.name,
                    style: textTheme.headline,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Text(
                      '${capitalize(postType)} ${getTimeAgo(post.dateTimeLost)}'),
                  HorizontalLine(),
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    children: <Widget>[
                      Icon(
                        LineIcons.map_marker,
                        size: 18,
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      Text(post.location),
                    ],
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Row(
                    children: <Widget>[
                      Icon(
                        LineIcons.phone,
                        size: 18,
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      Text(post.phoneNumber),
                    ],
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Row(
                    children: <Widget>[
                      Icon(
                        LineIcons.calendar,
                        size: 18,
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      Text('Posted ${getTimeAgo(post.createdAt)}'),
                    ],
                  ),
                  UIHelper.verticalSpaceLarge(),
                  Row(
                    children: <Widget>[
                      Icon(
                        LineIcons.paw,
                        size: 18,
                      ),
                      UIHelper.horizontalSpaceSmall(),
                      Text(
                          '${isBreedEmpty ? 'Unspecified' : post.breed} Breed'),
                    ],
                  ),
                  UIHelper.verticalSpaceExtraLarge(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Additional Details'.toUpperCase(),
                        style: textTheme.overline,
                      ),
                      UIHelper.verticalSpaceExtraSmall(),
                      Text(isAdditionalDetailEmpty
                          ? 'No additional detail'
                          : post.additionalDetails),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: ReusableAppBar(
          title:
              AppBarTitle('${toBeginningOfSentenceCase(postType)} pet details'),
        ),
        body: ListView(
          children: <Widget>[
            _buildSwiper(),
            _buildContentContainer(),
          ],
        ));
  }
}
