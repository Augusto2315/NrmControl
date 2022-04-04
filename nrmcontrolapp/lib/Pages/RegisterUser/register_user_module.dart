import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/RegisterUser/register_user_widget.dart';

class RegisterModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => RegisterUserWidget()),
      ];
}
