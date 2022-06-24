import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';

import '../../Icons/flutter_icon_model.dart';

class IconPickerState extends ChangeNotifier {
  IconPickerState() {
    _listIcons = FlutterIcons.iconList;
  }
  List<FlutterIconModel> _listIcons = [];

  List<FlutterIconModel> get getIcons {
    return _listIcons;
  }

  void getIconsByFilterLike(String? str) {
    if (str == null || str.isEmpty) {
      _listIcons = FlutterIcons.iconList;
    } else {
      _listIcons = FlutterIcons.iconList
          .where((x) => x.name.toLowerCase().contains(str.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
