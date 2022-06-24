import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Repository/login_repository.dart';

class LoginService {
  Future<User?> login(User user, BuildContext context) {
    LoginRepository loginRepository = LoginRepository();
    return loginRepository.login(user, context);
  }
}
