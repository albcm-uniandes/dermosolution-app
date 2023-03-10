import 'dart:async';
import 'dart:convert';
import 'package:dermosolution_app/src/shared/constants.dart';
import 'package:http/http.dart' as http;
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';

String url = "$baseUrl/pacientes/";

Future<Paciente> createPaciente(String nombres, String apellidos, String fechaNacimiento,
    String lugarNacimiento, String lugarResidencia,  String edad, String sexo,
    String numeroCelular, String correo, String clave) async {

  final paciente = await http.post(
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

  if (paciente.statusCode == 201) {
    var jsonString =
        '{"nombres": "400"}';
    //return Paciente.fromJson(jsonDecode(jsonString));
    return Paciente.fromJson(jsonDecode(paciente.body));
  }else {
    throw Exception('Error en la creación del paciente');
  }
}

