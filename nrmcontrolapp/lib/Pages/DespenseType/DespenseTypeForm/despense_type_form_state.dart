import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Models/DespenseType/despense_type.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';

import '../../../Shared/Colors/icons_colors.dart';

class DespenseTypeFormState extends ChangeNotifier {
  DespenseType _despense = DespenseType(0, "", "", false, null, null, null);

  DespenseType get getDespense {
    return _despense;
  }

  void alterDespense(DespenseType despense) {
    _despense = despense;
    notifyListeners();
  }

  void setIconCodePoint(int codePoint) {
    _despense.iconData = codePoint;
    notifyListeners();
  }

  void alterMonthFixed(bool monthFixed) {
    _despense.monthFixed = monthFixed;
    notifyListeners();
  }

  Widget getIcon() {
    if (_despense.iconData != null) {
      return Icon(
        IconData(
          _despense.iconData!,
          fontFamily: FlutterIcons.familyPackage,
        ),
        color: IconsColors.pickIconColor,
      );
    }
    return Container();
  }

  bool getDespenseTypeMonthFixed() {
    return _despense.monthFixed;
  }

  void clearDespense() {
    _despense = DespenseType(0, "", "", false, null, null, null);
    notifyListeners();
  }
}
