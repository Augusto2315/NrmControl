import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/AppComponent/router_outlet_controller.dart';
import 'package:nrmcontrolapp/Pages/Home/home_module.dart';
import 'package:nrmcontrolapp/AppComponent/router_outlet_widget.dart';
import 'package:nrmcontrolapp/Pages/Login/login_module.dart';
import 'package:nrmcontrolapp/Pages/RegisterUser/register_user_module.dart';

import '../Pages/DespenseType/DespenseTypeForm/despense_type_form_module.dart';
import '../Pages/DespenseType/despense_type_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => RouterOutletController(), export: true),
      ];

  @override
  List<Module> get imports => [
        HomeModule(),
        LoginModule(),
        RegisterUserModule(),
        DespenseTypeModule(),
        DespenseTypeFormModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const RouterOutletWidget(),
          children: [
            ModuleRoute('/home', module: HomeModule()),
            ModuleRoute('/login', module: LoginModule()),
            ModuleRoute('/register-user', module: RegisterUserModule()),
            ModuleRoute('/despense-type', module: DespenseTypeModule()),
            ModuleRoute('/edit-despense-type', module: DespenseTypeFormModule())
          ],
        ),
      ];
}
