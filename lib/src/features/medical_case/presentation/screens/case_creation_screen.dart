import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:flutter/material.dart';

import '../../../conditions/presentation/widgets/header.dart';
import '../widgets/case_info_form.dart';

class CaseCreationScreen extends StatelessWidget {
  const CaseCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(
            title: 'Creación de consulta',
          ),
          const CaseInfoForm(),
          const Text('Anexar Evicencia',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              )),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 100,
                ),
                Icon(
                  Icons.image,
                  size: 100,
                )
              ]),
          const ConditionsButtons()
        ],
      ),
    );
  }
}
