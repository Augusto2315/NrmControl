import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Services/login_service.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Widgets/custom_toast.dart';

import '../../Services/user_service.dart';

class RegisterUserWidget extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode focusUsuarioParaSenha = FocusNode();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 24));
  RegisterUserWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: _userNameController,
                onFieldSubmitted: (String str) =>
                    focusUsuarioParaSenha.requestFocus(),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Usuário',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                focusNode: focusUsuarioParaSenha,
                onFieldSubmitted: (String str) => registrar(),
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
                registrar();
              },
              child: const Text('Registrar'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: RichText(
                text: TextSpan(
                    text: "Entrar",
                    style: const TextStyle(color: Colors.black),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        goToLogin();
                      }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToLogin() {
    Modular.to.navigate('/login/');
  }

  void registrar() {
    User user =
        User(_userNameController.value.text, _passwordController.value.text);
    if (user.userId.isEmpty) {
      CustomToast.showError("Informe o usuário!");
    } else if (user.password.isEmpty) {
      CustomToast.showError("Informe a senha!");
    } else {
      UserService _userService = UserService();
      try {
        _userService.createUser(user).then((value) {
          RouteService routeService = RouteService();
          routeService.home();
        });
      } on Exception catch (error) {
        CustomToast.showError(error.toString());
      }
    }
  }
}
