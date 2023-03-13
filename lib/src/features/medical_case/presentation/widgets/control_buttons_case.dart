import 'package:flutter/material.dart';


class CaseButtons extends StatelessWidget {
  CaseButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(239, 92, 92, 1.0)),
              onPressed: () {
                //Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
              child: Text("Salir"),
            ),
          ),
        ],
      ),
    );
  }
}
