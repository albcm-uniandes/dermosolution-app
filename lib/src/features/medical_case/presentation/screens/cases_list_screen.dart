import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/features/medical_case/presentation/widgets/cases_list_widget.dart';
import 'package:dermosolution_app/src/features/medical_case/presentation/widgets/control_buttons_case.dart';
import 'package:flutter/material.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen

  ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(3, 35, 3, 25),
          child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScreenHeader(title: 'Listado de casos',),
                  CasesList(),
                  CaseButtons(),
                ],
              ),
            ),
          )
      ),
    );
  }
}