import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeAgo;

final String kDefaultImagePath = 'images/default-pet-large.png';

final Function kInputDecoration = (String label) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
  );
};

String capitalize(String string) {
  if (string != null && string.isNotEmpty) {
    return string[0].toUpperCase() + string.substring(1);
  }
  return string;
}

String getEmailPrefix(String string) {
  if (string != null && string.isNotEmpty) {
    return string.split('@')[0];
  }
  return string;
}

String getTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  return timeAgo.format(now.subtract(difference), locale: 'en');
}

void showSnackBarUsingKey(
    {@required GlobalKey<ScaffoldState> scaffoldKey,
    String message,
    Color color}) {
  scaffoldKey.currentState
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: Duration(milliseconds: 1500),
        action: SnackBarAction(
          textColor: Colors.white,
          label: 'Close',
          onPressed: () {
            scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
}
