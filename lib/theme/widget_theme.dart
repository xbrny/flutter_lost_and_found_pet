import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';

buildColorScheme() {
  return ColorScheme.light(
    primary: kBrandRedColor,
    secondary: kBrandYellowColor,
    onBackground: kBrandSmokeColor,
  );
}

buildInputDecorationTheme(ThemeData base) {
  return InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
        color: kBrandRedColor,
      ),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: 2,
      ),
    ),
  );
}

buildIconTheme(IconThemeData base) {
  return base.copyWith();
}

buildCardTheme(CardTheme cardTheme) {
  return cardTheme.copyWith(
    elevation: 2,
  );
}

buildTabBarTheme(TabBarTheme base) {
  return base.copyWith(
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: kBrandYellowColor,
        width: 4,
      ),
    ),
    labelColor: Colors.white,
  );
}

buildAppBarTheme(AppBarTheme base) {
  return base.copyWith(
    elevation: 0,
    color: Colors.transparent,
    iconTheme: IconThemeData(
      color: kBrandRedColor,
    ),
  );
}

buildBottomAppBarTheme(BottomAppBarTheme bottomAppBarTheme) {
  return bottomAppBarTheme.copyWith();
}

buildButtonTheme(ButtonThemeData base) {
  return base.copyWith(
    disabledColor: kBrandRed300Color,
    buttonColor: kBrandRedColor,
    shape: StadiumBorder(),
    height: kButtonHeight,
  );
}

buildFabTheme(FloatingActionButtonThemeData base) {
  return base.copyWith(
    backgroundColor: kBrandRedColor,
  );
}
