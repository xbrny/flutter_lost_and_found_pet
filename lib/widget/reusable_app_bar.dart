import 'package:flutter/material.dart';

class ReusableAppBar extends AppBar {
  final Widget title;
  final bool automaticallyImplyLeading;
  final List<Widget> actions;

  ReusableAppBar({
    Key key,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
  }) : super(
          key: key,
          title: title,
          actions: actions,
          automaticallyImplyLeading: automaticallyImplyLeading,
          iconTheme: IconThemeData.fallback(),
        );
}
