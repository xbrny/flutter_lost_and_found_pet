import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CloseIconButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final bool back;

  const CloseIconButton({
    Key key,
    this.iconData = LineIcons.close,
    this.color,
    this.back = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color ?? Theme.of(context).textTheme.body1.color,
      icon: Icon(
        back ? LineIcons.arrow_left : iconData,
      ),
      onPressed: () {
        Navigator.maybePop(context);
      },
    );
  }
}
