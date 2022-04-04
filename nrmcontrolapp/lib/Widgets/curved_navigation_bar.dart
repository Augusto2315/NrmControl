import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';

class CurvedNavgationBarWidget extends StatelessWidget {
  CurvedNavgationBarWidget({Key? key}) : super(key: key);
  final RouteService routeService = RouteService();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.money, size: 30),
        Icon(Icons.login, size: 30),
      ],
      onTap: (index) {
        if (index == 0) {
          Modular.to.navigate("/home/");
        } else if (index == 1) {
          Modular.to.navigate("/despenseType/");
        } else if (index == 2) {
          routeService.logout();
        }
      },
    );
  }
}
