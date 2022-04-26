import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_widget.dart';

class DespenseTypeFormModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const DespenseTypeFormWidget(),
        ),
      ];
}
