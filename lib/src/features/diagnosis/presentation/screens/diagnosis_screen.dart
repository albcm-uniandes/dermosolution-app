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

  Future<String> getDiagnosis(String caso) async {
    String result = '';
    final url = '$baseUrl/casos-medicos/$caso';
    final url2 = '$baseUrl/diagnosticoExterno/$caso';
    print(url);
    var response = await http.get(Uri.parse(url));
    var body = json.decode(response.body);
    try {
      if (body['diagnosticos'] == []) {
        print('No encontrado en manuales');
        response = await http.get(Uri.parse(url2));
        body = json.decode(response.body);
        if (body['diagnostico']!=null) {
          print('Encontrado en automatico');
          result = body['diagnostico'];
        }
        else{
          print('No encontrado ');

          throw 'No encontrado';
        }
      }
      else{
        result = body['diagnosticos'][0];
      }
    }
    on Exception catch (e){
      result = 'No existe diagnostico';
    }
    setState(() {
      loading = false;
    });
    print('Result:'+result);
    return result;
  }

  void initState() {
    super.initState();
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    _futureDiagnosis = getDiagnosis(widget.casoMedico);
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Diagnostico'),
          FutureBuilder<String>(future: _futureDiagnosis, builder: (context, snapshot){
            if (snapshot.hasData) {
              return Text(snapshot.toString());
            } else {
              return const CircularProgressIndicator();
            }
          }),
          ConditionsButtons(acceptCallback: () {
            Navigator.pop(context);
          }, rejectCallback: () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}
