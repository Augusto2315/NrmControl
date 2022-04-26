import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/AppComponent/router_outlet_controller.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RouterOutletController())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'NRM Control',
        theme: ThemeData(primarySwatch: Colors.blue),
        color: Colors.blue,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    );
  }
}
