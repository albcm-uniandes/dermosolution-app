import 'package:flutter/material.dart';

final Widget header = Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    const Text("Terminos y condiciones",
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold,
        )),
    Image.asset('lib/assets/images/logo.png', width: 80),
  ],
);
