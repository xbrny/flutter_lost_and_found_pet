import 'package:flutter/material.dart';

class TextWithTap extends StatelessWidget {
  final Text text;
  final VoidCallback onTap;

  const TextWithTap({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      constraints: BoxConstraints(),
      onPressed: onTap,
      child: text,
    );
  }
}
