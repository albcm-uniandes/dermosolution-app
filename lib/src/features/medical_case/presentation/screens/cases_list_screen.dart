import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/features/medical_case/presentation/widgets/cases_list_widget.dart';
import 'package:dermosolution_app/src/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class CasesScreen extends StatelessWidget {
  const CasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: const [
        ScreenHeader(title: 'Listado de casos'),
        CasesList()
      ]),
    );
  }
}
