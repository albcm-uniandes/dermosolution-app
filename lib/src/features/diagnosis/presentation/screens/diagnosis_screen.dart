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
    setState(() {
      loading=false;
    });
    if (body['diagnosticos'].length == 0){
      print("No hay diagnostico manual");
      response = await http.get(Uri.parse(url2));
      body = json.decode(response.body);
      if (body['diagnostico']!=null){
        return body['diagnostico'];
      }else{
        return "Sin diagnostico automatico y manual";
      }
    } else{
      return body['diagnosticos'][0];
    }

  }

  void initState(){
    super.initState();
    loading = true;
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
                  print("Este es el return " + snapshot.hasData.toString());
                  if(snapshot.hasData){
                    return Text(snapshot.toString());
                  }else{
                    if (snapshot.hasData == false){
                      return Text('No hay diagnostico');
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
