import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: kSpaceSmall),
      width: 35,
      height: 2,
      color: Theme.of(context).primaryColor,
    );
  }
}
