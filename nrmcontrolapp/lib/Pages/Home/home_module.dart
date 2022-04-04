import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/Login/login_module.dart';

import 'home_widget.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeWidget()),
        ModuleRoute('/login', module: LoginModule()),
      ];
}
