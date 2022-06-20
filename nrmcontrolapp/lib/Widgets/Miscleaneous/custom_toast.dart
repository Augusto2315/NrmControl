import 'package:flutter/material.dart';

class CustomToast {
  static showSucess(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 10),
      content: Text(message),
    ));
  }

  static showError(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 10),
      content: Text(message),
    ));
  }

  static showWarning(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.yellow,
      duration: const Duration(seconds: 10),
      content: Text(message),
    ));
  }
}
