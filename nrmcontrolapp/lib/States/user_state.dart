import 'package:flutter/widgets.dart';
import 'package:nrmcontrolapp/Services/jwt_service.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';

import '../Models/User/user.dart';

class UserState extends ChangeNotifier {
  bool isInLogin = false;

  User loggedUser = User("", "");
  void setUser(User user) {
    loggedUser = user;
  }

  bool userIsLogged() {
    debugPrint(isInLogin.toString());
    return isInLogin;
  }

  Future validateUserIsLogged(BuildContext context) async {
    isInLogin = await JwtService.validateToken();
    if (!isInLogin) {
      RouteService().logout(context);
    }
    notifyListeners();
  }
}
