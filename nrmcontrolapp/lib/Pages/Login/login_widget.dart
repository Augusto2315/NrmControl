import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Models/CustomException/custom_exception.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Services/login_service.dart';
import 'package:nrmcontrolapp/Widgets/custom_toast.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 24));
  LoginWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Usuário',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Senha',
                  ),
                ),
              ),
              ElevatedButton(
                style: style,
                onPressed: () {
                  logar();
                },
                child: const Text('Logar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logar() {
    User user =
        User(_userNameController.value.text, _passwordController.value.text);
    if (user.userId.isEmpty) {
      CustomToast.showError("Informe o usuário!");
    } else if (user.password.isEmpty) {
      CustomToast.showError("Informe a senha!");
    } else {
      LoginService _loginService = LoginService();
      _loginService.login(user).then((value) {
        if (value != null) {
          Modular.to.navigate('/home/');
        }
      }).catchError((error) {
        CustomToast.showError(error.toString());
      });
    }
  }
}
