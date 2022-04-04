import 'package:flutter/cupertino.dart';

class RouterOutletController extends ChangeNotifier {
  bool isInLogin = false;
  void validateIsInLogin(bool isLoggin) {
    isInLogin = isLoggin;
    notifyListeners();
  }
}
