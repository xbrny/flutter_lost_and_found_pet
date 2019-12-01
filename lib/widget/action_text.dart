import 'package:flutter/material.dart';

class ActionText extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const ActionText(this.text, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
