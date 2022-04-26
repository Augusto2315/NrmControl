import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Services/jwt_service.dart';
import 'package:nrmcontrolapp/Services/shared_preferences_utils.dart';

class RouteService {
  void logout() {
    JwtService jwtService = JwtService();
    jwtService.removeToken();

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
