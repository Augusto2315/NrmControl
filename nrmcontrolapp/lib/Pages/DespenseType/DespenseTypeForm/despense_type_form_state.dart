import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Models/DespenseType/despense_type.dart';

class DespenseTypeFormState extends ChangeNotifier {
  DespenseType _despense = DespenseType(0, "", "", false, null, null);
  void alterDespense(DespenseType despense) {
    _despense = despense;
    notifyListeners();
  }

  DespenseType getDespense() {
    return _despense;
  }

  void alterMonthFixed(bool monthFixed) {
    _despense.monthFixed = monthFixed;
    notifyListeners();
  }

  bool getDespenseTypeMonthFixed() {
    return _despense.monthFixed;
  }

  void clearDespense() {
    _despense = DespenseType(0, "", "", false, null, null);
  }
}
