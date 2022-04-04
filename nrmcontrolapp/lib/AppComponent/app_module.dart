import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/AppComponent/router_outlet_controller.dart';
import 'package:nrmcontrolapp/Pages/Home/home_module.dart';
import 'package:nrmcontrolapp/AppComponent/router_outlet_widget.dart';
import 'package:nrmcontrolapp/Pages/Login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => RouterOutletController(), export: true),
      ];

  @override
  List<Module> get imports => [
        HomeModule(),
        LoginModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const RouterOutletWidget(),
        ),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/login', module: LoginModule())
      ];
}
