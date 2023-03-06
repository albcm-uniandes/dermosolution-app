import 'dart:async';
import 'dart:convert';
import 'package:dermosolution_app/src/features/automatic/domain/models/case_profile.dart';
import 'package:dermosolution_app/src/shared/constants.dart';
import 'package:http/http.dart' as http;

String url = "$baseUrl/pacientes/";
String urlGet = "$baseUrl/diagnosticoexterno/2";
String urlPut = "$baseUrl/pacientes/1/";

Future<Automatico> obtenerAutomatico() async {

  final automaticoGet = await http.get(Uri.parse(urlGet));

  if (automaticoGet.statusCode == 200) {
    return Automatico.fromJson(jsonDecode(automaticoGet.body));
  }else {
    throw Exception('Error en la busqueda del paciente');
  }
}