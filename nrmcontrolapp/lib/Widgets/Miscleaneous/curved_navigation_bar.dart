import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';
import 'package:nrmcontrolapp/Shared/Colors/screen_colors.dart';

class PageIndexes {
  static const homePageIndex = 0;
  static const despenseTypePageIndex = 2;
  static const logoutPageIndex = 4;
}

class CurvedNavgationBarWidget extends StatelessWidget {
  CurvedNavgationBarWidget({Key? key}) : super(key: key);
  final RouteService routeService = RouteService();

  @override
  Widget build(BuildContext context) {
    Widget cancelarSaidaWidget = TextButton(
      child: const Text("Não"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget confirmarSaidaWidget = TextButton(
      child: const Text("Sim"),
      onPressed: () {
        routeService.logout(context);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Saindo..."),
      content: const Text("Gostaria de sair do sistema?"),
      actions: [
        cancelarSaidaWidget,
        confirmarSaidaWidget,
      ],
    );

    return CurvedNavigationBar(
      backgroundColor: ScreenColors.backgroundScreenColor,
      color: Colors.white,
      items: const <Widget>[
        Icon(Icons.home, size: 25),
        Icon(Icons.attach_money, size: 25),
        Icon(Icons.money, size: 25),
        Icon(Icons.settings, size: 25),
        Icon(Icons.login, size: 25),
      ],
      onTap: (index) {
        if (index == PageIndexes.homePageIndex) {
          routeService.home();
        } else if (index == PageIndexes.despenseTypePageIndex) {
          routeService.despenseType();
        } else if (index == PageIndexes.logoutPageIndex) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return alert;
            },
          );
        }
      },
    );
  }
}
