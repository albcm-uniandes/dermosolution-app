import 'package:dermosolution_app/src/features/shared/widgets/submit_buttom.dart';
import 'package:flutter/material.dart';

final Widget loginForm = Form(
  child: Column(
    children: [
      inputGenerator("Correo electronico"),
      inputGenerator("Contraseña"),
      buttonGenerator("Ingresar"),
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

Widget inputGenerator(text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: text,
      ),
    ),
  );
}
