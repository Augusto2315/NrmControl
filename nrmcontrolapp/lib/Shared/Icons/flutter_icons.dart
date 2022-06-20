import 'package:flutter/material.dart';

import '../Colors/icons_colors.dart';

class FlutterIcons {
  static Widget getPasswordIcon(isPassword) {
    return Icon(isPassword ? Icons.remove_red_eye : Icons.lock_open_outlined,
        color: IconsColors.stringTextFieldIconColor);
  }

  static Widget getLockerIcon() {
    return const Icon(Icons.lock, color: IconsColors.stringTextFieldIconColor);
  }

  static Icon peopleIcon = const Icon(Icons.people);
}
