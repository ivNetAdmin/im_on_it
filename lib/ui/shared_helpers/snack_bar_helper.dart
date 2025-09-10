/*
void showFlashError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
*/

import 'package:flutter/material.dart';

class SnackBarHelper {
  static void showFlashError(BuildContext context, String message, String messageType) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: messageType=='error'? Colors.red : Colors.black,
        content: Text(message),
      ),
    );
  }
}