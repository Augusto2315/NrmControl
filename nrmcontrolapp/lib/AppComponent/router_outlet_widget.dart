import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nrmcontrolapp/States/user_state.dart';
import 'package:provider/provider.dart';

import '../Shared/Colors/screen_colors.dart';
import '../Widgets/Miscleaneous/curved_navigation_bar.dart';

class RouterOutletWidget extends StatefulWidget {
  const RouterOutletWidget({Key? key}) : super(key: key);

  @override
  State<RouterOutletWidget> createState() => _RouterOutletWidgetState();
}

class _RouterOutletWidgetState extends State<RouterOutletWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ScreenColors.backgroundScreenColor,
      bottomNavigationBar: Provider.of<UserState>(context).isInLogin
          ? CurvedNavgationBarWidget()
          : null,
      body: const RouterOutlet(),
    );
  }
}
