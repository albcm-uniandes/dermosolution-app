import 'package:flutter/material.dart';

Widget buttonGenerator(String buttonLabel) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0.0, 20, 0.0, 10),
    child: SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(buttonLabel),
      ),
    ),
  );
}
