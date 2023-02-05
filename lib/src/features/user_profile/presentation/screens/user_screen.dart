import 'package:dermosolution_app/src/features/login/data/constants/conditions_constants.dart';
import 'package:flutter/material.dart';

import '../widgets/conditions_buttons.dart';
import '../widgets/header.dart';
import '../widgets/user_info_form.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(title: 'Registro de usuario',),
          const UserInfoForm(),
          const ConditionsButtons()
        ],
      ),
    );
  }
}
