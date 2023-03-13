import 'dart:async';
import 'dart:convert';
import 'package:dermosolution_app/src/features/info_case/domain/models/case.dart';
import 'package:dermosolution_app/src/shared/constants.dart';
import 'package:http/http.dart' as http;

Future<CaseInformation> obtenerInformacionCaso(caseNumber) async {
  String urlGet = "$baseUrl/casos-medicos/0";
  urlGet = urlGet.substring(0,urlGet.length-1) + caseNumber;
  print("URL casos " + urlGet);

  final caseInformationGet = await http.get(Uri.parse(urlGet));

  if (caseInformationGet.statusCode == 200) {
    return CaseInformation.fromJson(jsonDecode(caseInformationGet.body));
  }else {
    throw Exception('Error en la busqueda del caso');
  }
}