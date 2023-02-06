import 'package:dermosolution_app/src/features/login/data/constants/conditions_constants.dart';
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';
import 'package:dermosolution_app/src/features/user_profile/service/service_profile.dart';
import 'package:flutter/material.dart';
import '../widgets/conditions_buttons.dart';
import '../widgets/header.dart';
import '../widgets/user_info_form.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() {
    return _CrearPaciente();
  }
}

class _CrearPaciente extends State<UserScreen> {

  Future<Paciente>? _futurePaciente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(title: 'Registro de usuario',),
          const UserInfoForm(),
          ConditionsButtons()
        ],
      ),
    );
  }

  FutureBuilder<Paciente> buildFutureBuilder() {
    return FutureBuilder<Paciente>(
      future: _futurePaciente,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text("Paciente creado exisomante");
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
