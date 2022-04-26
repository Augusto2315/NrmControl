import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Services/route_service.dart';

class PageIndexes {
  static const homePageIndex = 0;
  static const despenseTypePageIndex = 1;
}

class CurvedNavgationBarWidget extends StatelessWidget {
  final int index;
  CurvedNavgationBarWidget(this.index, {Key? key}) : super(key: key);
  final RouteService routeService = RouteService();
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: index,
      backgroundColor: Colors.lightBlue,
      color: Colors.white,
      items: const <Widget>[
        Icon(Icons.home, size: 25),
        Icon(Icons.money, size: 25),
        Icon(Icons.settings, size: 25),
        Icon(Icons.login, size: 25),
      ],
      onTap: (index) {
        if (index == PageIndexes.homePageIndex) {
          RouteService routeService = RouteService();
          routeService.home();
        } else if (index == PageIndexes.despenseTypePageIndex) {
          RouteService routeService = RouteService();
          routeService.despenseType();
        } else if (index == 3) {
          routeService.logout();
        }
      },
    );
  }
}
