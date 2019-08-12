import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';

buildTextTheme(TextTheme base) {
  base = base.copyWith(
    display4: base.display4.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay4FontSize,
      letterSpacing: kLetterSpacing,
    ),
    display3: base.display3.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay3FontSize,
      letterSpacing: kLetterSpacing,
    ),
    display2: base.display2.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay2FontSize,
      letterSpacing: kLetterSpacing,
    ),
    display1: base.display1.copyWith(
      fontWeight: FontWeight.w600,
      fontSize: kDisplay1FontSize,
      letterSpacing: kLetterSpacing,
    ),
    headline: base.headline.copyWith(
      fontSize: kHeadlineFontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: kLetterSpacing,
    ),
    subhead: base.subhead.copyWith(
      fontSize: kSubheadFontSize,
      letterSpacing: kLetterSpacing,
    ),
    title: base.title.copyWith(
      fontSize: kTitleFontSize,
      letterSpacing: kLetterSpacing,
      fontWeight: FontWeight.w600,
      color: kBrandRedColor,
    ),
    subtitle: base.subtitle.copyWith(
      letterSpacing: kLetterSpacing,
      color: Colors.grey.shade600,
      fontWeight: FontWeight.w400,
    ),
    body1: base.body1.copyWith(
      fontSize: kBody1FontSize,
      letterSpacing: kLetterSpacing,
    ),
    body2: base.body2.copyWith(
      fontSize: kBody2FontSize,
      letterSpacing: kLetterSpacing,
    ),
    button: base.button.copyWith(
      fontSize: kButtonFontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: kLetterSpacing,
    ),
    caption: base.caption.copyWith(
      fontSize: kCaptionFontSize,
      letterSpacing: kLetterSpacing,
    ),
    overline: base.overline.copyWith(
      fontSize: kOverlineFontSize,
      letterSpacing: kLetterSpacing,
      fontWeight: FontWeight.w600,
      color: kBrandRedColor,
    ),
  );

  return base.apply(
    fontFamily: 'JosefinSans',
    displayColor: kBrandRedColor,
  );
}
