import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../domain/models/medical_case.dart';
import 'case_widget.dart';

class CasesList extends StatefulWidget {
  const CasesList({super.key});

  @override
  State<CasesList> createState() => _CasesListState();
}

class _CasesListState extends State<CasesList> {
  Future<List<MedicalCase>> casesFuture = getCases();

  static Future<List<MedicalCase>> getCases() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var pacientePreference =  prefs.getInt('pacienteId').toString();
    await pacientePreference;
    final url =
        'https://dermosbkend.onrender.com/api/v1/pacientes/${pacientePreference}/casos-medicos/';
    print(url);
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body.map<MedicalCase>(MedicalCase.fromJson).toList();
    const data = [
      {"description": "", "status": "", "diagnostic_type": "", "specialist": ""}
    ];
    return data.map<MedicalCase>(MedicalCase.fromJson).toList();
  }

  Widget buildCases(List<MedicalCase> cases) => ListView.builder(
      itemCount: cases.length,
      itemBuilder: (context, index) {
        final item = cases[index];
        return Case(
            description: item.description,
            specialist: item.specialist,
            status: item.status,
            diagnosticType: item.diagnosticType);
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        width: 500,
        child: FutureBuilder<List<MedicalCase>>(
          future: casesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final cases = snapshot.data!;
              return buildCases(cases);
            } else {
              return const Text('No cases data.');
            }
          },
        ));
  }
}
