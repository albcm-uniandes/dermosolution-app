import 'dart:async';
import 'dart:convert';
import 'package:dermosolution_app/src/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';

String url = "$baseUrl/pacientes/";
String urlGet = "$baseUrl/pacientes/2";

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

  final pacienteGet = await http.get(Uri.parse(urlGet));


  if (pacienteGet.statusCode == 200) {
    return Paciente.fromJson(jsonDecode(pacienteGet.body));
  }else {
    throw Exception('Error en la busqueda del paciente');
  }
}

