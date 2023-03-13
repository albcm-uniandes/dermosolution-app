import 'dart:async';
import 'dart:convert';
import 'package:dermosolution_app/src/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

String url = "$baseUrl/pacientes/";

Future<Paciente> createPacienteForm(String nombres, String apellidos, String fechaNacimiento,
    String lugarNacimiento, String lugarResidencia,  String edad, String sexo,
    String numeroCelular, String correo, String clave) async {

  final pacientePost = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
          'nombres': nombres,
          'apellidos': apellidos,
          'fecha_nacimiento': fechaNacimiento,
          'lugar_nacimiento': lugarNacimiento,
          'lugar_residencia': lugarResidencia,
          'numero_celular': numeroCelular,
          'correo': correo,
          'clave': clave,
          'edad': edad,
          'sexo': sexo,
          'casos_medicos': []
      }),
    );

  if (pacientePost.statusCode == 201) {
    return Paciente.fromJson(jsonDecode(pacientePost.body));
  }else {
    throw Exception('Error en la creación del paciente');
  }
}

Future<Paciente> obtenerPaciente() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var pacientePreference =  prefs.getInt('pacienteId').toString();
  String urlGet = "$baseUrl/pacientes/$pacientePreference";
  await pacientePreference;
  final pacienteGet = await http.get(Uri.parse(urlGet));

  if (pacienteGet.statusCode == 200) {
    return Paciente.fromJson(jsonDecode(pacienteGet.body));
  }else {
    throw Exception('Error en la busqueda del paciente');
  }
}

Future<Paciente> updatePacienteForm(String nombres, String apellidos, String fechaNacimiento,
    String lugarNacimiento, String lugarResidencia,  String edad, String sexo,
    String numeroCelular, String correo, String clave) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var pacientePreference =  prefs.getInt('pacienteId').toString();
  String urlPut = "$baseUrl/pacientes/$pacientePreference/";

  final pacientePut = await http.patch(
      Uri.parse(urlPut),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, Object>{
      'nombres': nombres,
      'apellidos': apellidos,
      'fecha_nacimiento': fechaNacimiento,
      'lugar_nacimiento': lugarNacimiento,
      'lugar_residencia': lugarResidencia,
      'numero_celular': numeroCelular,
      'correo': correo,
      'clave': clave,
      'edad': edad,
      'sexo': sexo
    }),
  );

  if (pacientePut.statusCode == 200) {
    return Paciente.fromJson(jsonDecode(pacientePut.body));
  }else {
    throw Exception('Error en la actualización del paciente');
  }
}