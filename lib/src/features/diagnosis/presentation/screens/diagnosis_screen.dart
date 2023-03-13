import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class DiagnosisScreen extends StatelessWidget{
  const DiagnosisScreen({super.key});

  Future<http.Response> acceptDiagnosis(String title) {
    // todo. Diagnostico
    return http.post(
      Uri.parse('https://localhost:5000/caso'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }

  Future<String> getDiagnosis() async {
    // todo. obtener diagnostico
    const url =
        'https://dermosbkend.onrender.com/api/v1/pacientes/1/casos-medicos/';
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    return body;
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
            const ScreenHeader(title: 'Diagnostico'),
            const Text('Lorem ipsum dolor sit amet, consectetur adipiscing el'),
            ConditionsButtons(acceptCallback: (){}, rejectCallback: (){Navigator.pop(context);})
        ],
      ),
    );
  }
  
}