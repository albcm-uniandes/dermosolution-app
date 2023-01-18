import 'package:flutter/material.dart';

Widget rowButtons = Padding(
  padding: const EdgeInsets.only(top: 30),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SizedBox(
        width: 100,
        height: 30,
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Aceptar"),
        ),
      ),
      SizedBox(
        width: 100,
        height: 30,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(239, 92, 92, 1)),
          onPressed: () {},
          child: const Text("Rechazar"),
        ),
      ),
    ],
  ),
);
