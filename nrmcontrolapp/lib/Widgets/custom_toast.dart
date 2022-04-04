import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static Future<bool?> showSucess(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.lightGreen,
      textColor: Colors.white,
      fontSize: 24,
      timeInSecForIosWeb: 10,
    );
  }

  static Future<bool?> showError(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        webBgColor: "linear-gradient(to right, #F03801, #EB1C01)",
        backgroundColor: Colors.red,
        webPosition: "right",
        textColor: Colors.white,
        fontSize: 24,
        timeInSecForIosWeb: 10,
        webShowClose: true);
  }

  static Future<bool?> showWarning(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        webBgColor: "linear-gradient(to right, #F5E9A1, #EFC538)",
        backgroundColor: Colors.yellowAccent,
        webPosition: "right",
        textColor: Colors.white,
        fontSize: 24,
        timeInSecForIosWeb: 10,
        webShowClose: true);
  }
}
