import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_widget.dart';

import 'DespenseTypeForm/despense_type_form_module.dart';
import 'despense_type_widget.dart';

class DespenseTypeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [DespenseTypeFormModule()];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => DespenseTypeWidget(),
        ),
      ];
}
