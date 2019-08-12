import 'package:flutter/material.dart';

class ButtonWithLoading extends StatelessWidget {
  final bool isLoading;
  final String label;
  final VoidCallback onPressed;

  const ButtonWithLoading({Key key, this.isLoading, this.onPressed, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      textColor: Colors.white,
      onPressed: onPressed,
      child: isLoading
          ? SizedBox(
              height: 14,
              width: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Text(label),
      shape: StadiumBorder(),
    );
  }
}
