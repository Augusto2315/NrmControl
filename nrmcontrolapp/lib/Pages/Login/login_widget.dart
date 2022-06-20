import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nrmcontrolapp/Models/User/user.dart';
import 'package:nrmcontrolapp/Services/jwt_service.dart';
import 'package:nrmcontrolapp/Services/login_service.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Shared/Icons/flutter_icons.dart';
import 'package:nrmcontrolapp/States/user_state.dart';
import 'package:nrmcontrolapp/Widgets/ButtonsWIdget/custom_button_widget.dart';
import 'package:nrmcontrolapp/Widgets/Miscleaneous/custom_toast.dart';
import 'package:provider/provider.dart';

import '../../Shared/Icons/svg_icons.dart';
import '../../Widgets/ClickableLabel/clickable_label_widget.dart';
import '../../Widgets/TextFormWidgets/string_form_field.dart';

class LoginWidget extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode focusUsuarioParaSenha = FocusNode();
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 24));
  LoginWidget({Key? key}) : super(key: key);
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: StringFormField(
                  controller: _userNameController,
                  prefixIcon: FlutterIcons.peopleIcon,
                  labelText: "Usuário",
                  onFieldSubmitted: (String str) =>
                      focusUsuarioParaSenha.requestFocus(),
                )),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: StringFormField(
                  controller: _passwordController,
                  focusNode: focusUsuarioParaSenha,
                  isPassword: true,
                  labelText: "Senha",
                  onFieldSubmitted: (String str) => logar(context),
                )),
            SizedBox(
              child: CustomButtonWidget(
                onPressed: () => logar(context),
                labelText: 'Logar',
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 16.0, 0.0, 0.0),
                child: ClickableLabelWidget(
                  labelText: "Cadastre-se",
                  onTap: () => {goToRegister()},
                )),
          ],
        ),
      ),
    );
  }

  void goToRegister() {
    RouteService().registerUser();
  }

  void logar(BuildContext context) {
    User user =
        User(_userNameController.value.text, _passwordController.value.text);
    if (user.userId.isEmpty) {
      CustomToast.showError("Informe o usuário!", context);
    } else if (user.password.isEmpty) {
      CustomToast.showError("Informe a senha!", context);
    } else {
      LoginService _loginService = LoginService();
      _loginService.login(user).then((value) {
        if (value != null) {
          Provider.of<UserState>(context, listen: false).alterLoginState(true);
          JwtService().getToken().then((jwtToken) {
            if (jwtToken != null) {
              Map<String, dynamic> decodedToken = JwtDecoder.decode(jwtToken);
              User tokenUser = User(decodedToken["UserId"], "");
              Provider.of<UserState>(context, listen: false).setUser(tokenUser);
            }
          });

          RouteService().home();
        }
      }).catchError((error) {
        CustomToast.showError(error.toString(), context);
      });
    }
  }
}
