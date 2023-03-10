
import 'package:flutter/material.dart';

import '../../../login/data/constants/conditions_constants.dart';
import '../../../user_profile/formulario.dart';
import '../../../user_profile/presentation/screens/user_screen.dart';
import '../widgets/conditions_buttons.dart';
import '../widgets/header.dart';

class ConditionsScreen extends StatelessWidget {
  const ConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(title: 'Terminos y condiciones'),
          const Padding(
            padding: EdgeInsets.all(30),
            child: Text(conditions),
          ),
          ConditionsButtons(acceptCallback: (){
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterPage()),
              );
            }
          }, rejectCallback: (){Navigator.pop(context);})
        ],
      ),
    );
  }
}
