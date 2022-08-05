import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../States/user_state.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<UserState>(context, listen: false)
        .validateUserIsLogged(context);
    return const Center(
      child: Text('HOME'),
    );
  }
}
