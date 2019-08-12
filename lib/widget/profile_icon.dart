import 'package:flutter/material.dart';
import 'package:lost_found_pet_prototype/theme/theme_constant.dart';

class ProfileIcon extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileIcon({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(kSpaceMini),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: theme.primaryColor,
        ),
        child: ClipOval(
          child: Image.asset(
            'images/egg-profile.png',
            height: 32,
          ),
        ),
      ),
    );
  }
}
