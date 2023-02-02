import 'package:dermosolution_app/src/features/login/data/constants/conditions_constants.dart';
import 'package:flutter/material.dart';

import '../widgets/conditions_buttons.dart';
import '../widgets/header.dart';

class ConditionsScreen extends StatelessWidget {
  const ConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          ScreenHeader(title: 'Terminos y condiciones'),
          Padding(
            padding: EdgeInsets.all(30),
            child: Text(conditions),
          ),
          ConditionsButtons()
        ],
      ),
    );
  }
}
