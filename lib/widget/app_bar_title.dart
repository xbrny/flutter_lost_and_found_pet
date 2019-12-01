import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  final String data;
  final TextStyle style;

  AppBarTitle(this.data, {this.style});

  @override
  Widget build(BuildContext context) {
//    final kColor = Colors.black87;

    return Text(
      data,
      style: (style != null)
          ? style
          : TextStyle(
//              color: kColor,
              ),
    );
  }
}
