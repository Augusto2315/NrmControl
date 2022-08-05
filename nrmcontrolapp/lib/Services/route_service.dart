import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Services/jwt_service.dart';
import 'package:nrmcontrolapp/States/user_state.dart';
import 'package:provider/provider.dart';

class RouteService {
  void logout(BuildContext context) {
    JwtService jwtService = JwtService();
    jwtService.removeToken();
    Provider.of<UserState>(context, listen: false)
        .validateUserIsLogged(context);

    Modular.to.navigate('/login/');
  }

  void login() {
    Modular.to.navigate('/login/');
  }

  void registerUser() {
    Modular.to.navigate('/register-user/');
  }

  void home() {
    Modular.to.navigate('/home/');
  }

  void despenseType() {
    Modular.to.navigate('/despense-type/');
  }

  void editDespenseType() {
    Modular.to.navigate('/edit-despense-type/');
  }
}
