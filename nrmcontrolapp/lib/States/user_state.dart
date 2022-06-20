import 'package:flutter/widgets.dart';

import '../Models/User/user.dart';

class UserState extends ChangeNotifier {
  bool isInLogin = false;
  void alterLoginState(bool isLoggin) {
    isInLogin = isLoggin;
    notifyListeners();
  }

  User loggedUser = User("", "");
  void setUser(User user) {
    loggedUser = user;
  }
}
