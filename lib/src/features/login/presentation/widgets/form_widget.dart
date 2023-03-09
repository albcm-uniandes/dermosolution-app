import 'package:flutter/material.dart';

import '../../../conditions/presentation/screens/conditions_screen.dart';
import '../../../home/ui/screens/home.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      child: Column(
        children: [
          const InputGenerator(text: "Correo electronico"),
          const InputGenerator(text: "Contraseña"),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20, 0.0, 10),
            child: SizedBox(
              width: screenWidth * 0.75,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage(title: 'Dermosolution APP')));
                },
                child: const Text("Ingresar"),
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.75,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConditionsScreen()));
              },
              child: const Text('Crear cuenta'),
            ),
          ),
        ],
      ),
    );
  }
}

class InputGenerator extends StatelessWidget {
  const InputGenerator({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
