import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/font_theme.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';
import 'package:lost_found_pet_prototype/theme/widget_theme.dart';

ThemeData get kBrandTheme {
  final base = ThemeData.light();

  return base.copyWith(
//    brightness: Brightness.light,
    textTheme: buildTextTheme(base.textTheme),
    iconTheme: buildIconTheme(base.iconTheme),
    /**/
    primaryColor: kBrandRedColor,
    primaryColorBrightness: Brightness.dark,
    primaryTextTheme: buildTextTheme(base.primaryTextTheme),
    primaryIconTheme: buildIconTheme(base.accentIconTheme),
    /**/
    accentColor: kBrandYellowColor,
    accentColorBrightness: Brightness.dark,
    accentTextTheme: buildTextTheme(base.accentTextTheme),
    accentIconTheme: buildIconTheme(base.accentIconTheme),
    /**/
    scaffoldBackgroundColor: kBackgroundColor,
//    backgroundColor: Colors.white,
//    canvasColor: Colors.white,
//    cardColor: Colors.white,
//    buttonColor: Colors.greenAccent,
//    bottomAppBarColor: Colors.white,
//    dividerColor: Colors.white,
//    highlightColor: Colors.white,
//    splashColor: Colors.white,
//    selectedRowColor: Colors.white,
//    unselectedWidgetColor: Colors.white,
//    secondaryHeaderColor: Colors.white,
//    textSelectionColor: Colors.white,
//    cursorColor: Colors.white,
//    focusColor: Colors.white,
//    hoverColor: Colors.white,
//    disabledColor: Colors.white,
//    textSelectionHandleColor: Colors.white,
//    dialogBackgroundColor: Colors.white,
//    indicatorColor: Colors.white,
//    hintColor: Colors.white,
//    errorColor: Colors.white,
//    toggleableActiveColor: Colors.white,
    /**/
    appBarTheme: buildAppBarTheme(base.appBarTheme),
    buttonTheme: buildButtonTheme(base.buttonTheme),
    floatingActionButtonTheme: buildFabTheme(base.floatingActionButtonTheme),
    bottomAppBarTheme: buildBottomAppBarTheme(base.bottomAppBarTheme),
    tabBarTheme: buildTabBarTheme(base.tabBarTheme),
    cardTheme: buildCardTheme(base.cardTheme),
    inputDecorationTheme: buildInputDecorationTheme(base),
    colorScheme: buildColorScheme(),
//    chipTheme: Colors.white,
//    splashFactory: Colors.white,
//    sliderTheme: Colors.white,
//    materialTapTargetSize: Colors.white,
//    pageTransitionsTheme: Colors.white,
//    dialogTheme: Colors.white,
//    typography: Colors.white,
//    snackBarTheme: Colors.white,
//    bottomSheetTheme: Colors.white,
  );
}
