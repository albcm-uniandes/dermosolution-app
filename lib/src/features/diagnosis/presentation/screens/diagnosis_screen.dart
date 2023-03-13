import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/constants.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key, required this.casoMedico});

  final String casoMedico;


  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  bool loading = true;
  late Future<String> _futureDiagnosis;

  Future<http.Response> acceptDiagnosis(String CasoMedico) {
    final url = '$baseUrl/casos-medicos/$CasoMedico';
    return http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'caso': CasoMedico,
      }),
    );
  }

  Future<String> getDiagnosis(String caso) async {
    final url = '$baseUrl/casos-medicos/$caso';
    print(url);
    final response = await http.get(Uri.parse(url));
    final body = json.decode(response.body);
    setState(() {
      loading=false;
    });
    return body['diagnosticos'][0];
  }

  void initState(){
    super.initState();
    loading=true;
  }

  @override
  Widget build(BuildContext context) {
    print("Este es el caso medico " + widget.casoMedico);
    _futureDiagnosis = getDiagnosis(widget.casoMedico);
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Diagnostico'),
              FutureBuilder<String>(builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Text(snapshot.toString());
                  }else{
                    if (snapshot==null){
                      return Text('No hay diagnositco');
                    }else{
                      return const CircularProgressIndicator();
                    }
                  }
              }),
          ConditionsButtons(
              acceptCallback: () {
                Navigator.pop(context);
              },
              rejectCallback: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
