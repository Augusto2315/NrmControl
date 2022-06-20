import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/AppComponent/app_module.dart';
import 'package:nrmcontrolapp/AppComponent/app_widget.dart';

void main() {
  Modular.setInitialRoute('/login/');
  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
