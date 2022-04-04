import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/AppComponent/router_outlet_controller.dart';

import '../Widgets/curved_navigation_bar.dart';

class RouterOutletWidget extends StatefulWidget {
  const RouterOutletWidget({Key? key}) : super(key: key);

  @override
  State<RouterOutletWidget> createState() => _RouterOutletWidgetState();
}

class _RouterOutletWidgetState extends State<RouterOutletWidget> {
  @override
  Widget build(BuildContext context) {
    RouterOutletController controller = context.watch<RouterOutletController>();

    return const Scaffold(
      body: RouterOutlet(),
    );
  }
}
