import 'package:flutter/material.dart';

final Widget widgetLogo = Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: <Widget>[
    Image.asset('lib/assets/images/logo.png', width: 100),
    const Text(
      'DermoSolutions',
      style: TextStyle(
          color: Color.fromRGBO(45, 96, 172, 1),
          fontSize: 26,
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold),
    ),
  ],
);
