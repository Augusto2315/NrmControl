import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void setString(String key, String object) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(key, object);
  }

  static void removeString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
  }
}
