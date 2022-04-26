import 'package:flutter/material.dart';
import 'package:nrmcontrolapp/Widgets/curved_navigation_bar.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      bottomNavigationBar: CurvedNavgationBarWidget(PageIndexes.homePageIndex),
      body: const Center(
        child: Text('HOME'),
      ),
    );
  }
}
