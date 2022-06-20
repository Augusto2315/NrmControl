import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Services/jwt_service.dart';
import 'package:provider/provider.dart';

import '../States/user_state.dart';

class RouteService {
  void logout(BuildContext context) {
    JwtService jwtService = JwtService();
    jwtService.removeToken();
    Provider.of<UserState>(context, listen: false).alterLoginState(false);

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
