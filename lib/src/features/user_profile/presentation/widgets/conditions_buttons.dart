import 'package:dermosolution_app/main.dart';
import 'package:dermosolution_app/src/features/home/ui/screens/home.dart';
import 'package:dermosolution_app/src/features/user_profile/service/service_profile.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../../domain/models/patient_profile.dart';


class ConditionsButtons extends StatelessWidget {
  ConditionsButtons({super.key});

  Future<Paciente>? _futurePaciente;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage(title: "title")),
                );*/
                    context: context;
                    print(url);
                    _futurePaciente = createPaciente(
                      'Juan', 'Acevedo', "2023-01-01", 'Medellín', 'Rionegro',
                      '3103842142', 'j.acevedob@uniandes.edu.co','abcd1234', '42','HOMBRE'
                    );

              },
              child: const Text("Aceptar"),
            ),
          ),
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(239, 92, 92, 1.0)),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Rechazar"),
            ),
          ),
        ],
      ),
    );
  }
}
