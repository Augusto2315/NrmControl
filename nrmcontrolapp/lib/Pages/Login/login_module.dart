import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/RegisterUser/register_user_module.dart';

import 'login_widget.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        RegisterUserModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => LoginWidget()),
      ];
}
