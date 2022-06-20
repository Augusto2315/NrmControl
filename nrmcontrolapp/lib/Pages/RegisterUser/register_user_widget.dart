import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';
import 'package:nrmcontrolapp/Widgets/ButtonsWIdget/custom_button_widget.dart';
import 'package:nrmcontrolapp/Widgets/ClickableLabel/clickable_label_widget.dart';
import 'package:nrmcontrolapp/Widgets/Miscleaneous/custom_toast.dart';

import '../../Services/user_service.dart';
import '../../Shared/Icons/svg_icons.dart';
import '../../Widgets/TextFormWidgets/string_form_field.dart';

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
            SizedBox(
              height: 100,
              width: 100,
              child: SvgPicture.asset(
                SvgIcons.loginLogo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: StringFormField(
                prefixIcon: FlutterIcons.peopleIcon,
                controller: _userNameController,
                onFieldSubmitted: (String str) => {
                  focusUsuarioParaSenha.requestFocus(),
                },
                labelText: "Usuário",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: StringFormField(
                controller: _passwordController,
                focusNode: focusUsuarioParaSenha,
                labelText: "Senha",
                isPassword: true,
                onFieldSubmitted: (String str) => registrar(context),
              ),
            ),
            CustomButtonWidget(
              onPressed: () => {
                registrar(context),
              },
              labelText: "Registrar",
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
              child: ClickableLabelWidget(
                labelText: "Entrar",
                onTap: () => {
                  goToLogin(),
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToLogin() {
    RouteService().login();
  }

  void registrar(BuildContext context) {
    User user =
        User(_userNameController.value.text, _passwordController.value.text);
    if (user.userId.isEmpty) {
      CustomToast.showError("Informe o usuário!", context);
    } else if (user.password.isEmpty) {
      CustomToast.showError("Informe a senha!", context);
    } else {
      UserService _userService = UserService();
      try {
        _userService.createUser(user).then((value) {
          goToLogin();
        });
      } on Exception catch (error) {
        CustomToast.showError(error.toString(), context);
      }
    }
  }
}
