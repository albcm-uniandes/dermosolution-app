import 'package:flutter/material.dart';

final Widget loginForm = Form(
  child: Column(
    children: [
      const InputGenerator(text: "Correo electronico"),
      const InputGenerator(text: "Contraseña"),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 20, 0.0, 10),
        child: SizedBox(
          width: 200,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Ingresar"),
          ),
        ),
      ),
      SizedBox(
        width: 200,
        height: 50,
        child: OutlinedButton(
          onPressed: () {},
          child: const Text('Crear cuenta'),
        ),
      ),
    ],
  ),
);

class InputGenerator extends StatelessWidget {
  const InputGenerator({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
