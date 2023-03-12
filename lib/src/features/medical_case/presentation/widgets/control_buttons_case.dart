import 'package:dermosolution_app/main.dart';
import 'package:flutter/material.dart';


class CaseButtons extends StatelessWidget {
  CaseButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 35, 3, 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Regresar"),
            ),
          ),
        ],
      ),
    );
  }
}
