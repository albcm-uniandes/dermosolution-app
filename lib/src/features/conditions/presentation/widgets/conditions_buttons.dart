import 'package:dermosolution_app/src/features/user_profile/presentation/screens/user_screen.dart';
import 'package:flutter/material.dart';

class ConditionsButtons extends StatelessWidget {
  const ConditionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 100,
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserScreen()),
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
                  backgroundColor: const Color.fromRGBO(239, 92, 92, 1)),
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
