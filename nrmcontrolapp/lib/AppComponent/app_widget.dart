import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Pages/DespenseType/DespenseTypeForm/despense_type_form_state.dart';
import 'package:nrmcontrolapp/Shared/Functions/IconPicker/icon_picker_state.dart';
import 'package:nrmcontrolapp/States/user_state.dart';
import 'package:provider/provider.dart';

import '../Shared/Colors/screen_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (_) => DespenseTypeFormState(),
        ),
        ChangeNotifierProvider(
          create: (_) => IconPickerState(),
        )
      ],
      child: getMaterialApp(),
    );
  }

  MaterialApp getMaterialApp() {
    final MaterialApp mateApp = MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'NRM Control',
      theme: ThemeData(primarySwatch: ScreenColors.lightBackgroundScreenColor),
      color: ScreenColors.backgroundScreenColor,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );

    return mateApp;
  }
}
