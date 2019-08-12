import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';

class UIHelper {
  static const double _VerticalSpaceMini = kSpaceMini;
  static const double _VerticalSpaceExtraSmall = kSpaceExtraSmall;
  static const double _VerticalSpaceSmall = kSpaceSmall;
  static const double _VerticalSpaceMedium = kSpaceMedium;
  static const double _VerticalSpaceLarge = kSpaceLarge;
  static const double _VerticalSpaceExtraLarge = kSpaceExtraLarge;

  static const double _HorizontalSpaceMini = kSpaceMini;
  static const double _HorizontalSpaceExtraSmall = _VerticalSpaceExtraSmall;
  static const double _HorizontalSpaceSmall = _VerticalSpaceSmall;
  static const double _HorizontalSpaceMedium = _VerticalSpaceMedium;
  static const double HorizontalSpaceLarge = _VerticalSpaceLarge;
  static const double HorizontalSpaceExtraLarge = _VerticalSpaceExtraLarge;

  static Widget verticalSpaceMini() {
    return verticalSpace(_VerticalSpaceMini);
  }

  static Widget verticalSpaceExtraSmall() {
    return verticalSpace(_VerticalSpaceExtraSmall);
  }

  static Widget verticalSpaceSmall() {
    return verticalSpace(_VerticalSpaceSmall);
  }

  static Widget verticalSpaceMedium() {
    return verticalSpace(_VerticalSpaceMedium);
  }

  static Widget verticalSpaceLarge() {
    return verticalSpace(_VerticalSpaceLarge);
  }

  static Widget verticalSpaceExtraLarge() {
    return verticalSpace(_VerticalSpaceExtraLarge);
  }

  static Widget verticalSpace(double height) {
    return SizedBox(height: height);
  }

  static Widget horizontalSpaceMini() {
    return horizontalSpace(_HorizontalSpaceMini);
  }

  static Widget horizontalSpaceExtraSmall() {
    return horizontalSpace(_HorizontalSpaceExtraSmall);
  }

  static Widget horizontalSpaceSmall() {
    return horizontalSpace(_HorizontalSpaceSmall);
  }

  static Widget horizontalSpaceMedium() {
    return horizontalSpace(_HorizontalSpaceMedium);
  }

  static Widget horizontalSpaceLarge() {
    return horizontalSpace(HorizontalSpaceLarge);
  }

  static Widget horizontalSpaceExtraLarge() {
    return horizontalSpace(HorizontalSpaceExtraLarge);
  }

  static Widget horizontalSpace(double width) {
    return SizedBox(width: width);
  }
}
