import 'package:flutter/material.dart';

import '../../../home/screens/home.dart';

class ConditionsButtons extends StatefulWidget {
  const ConditionsButtons(
      {super.key, required this.acceptCallback, required this.rejectCallback});

  final VoidCallback acceptCallback;
  final VoidCallback rejectCallback;

  @override
  State<ConditionsButtons> createState() => _ConditionsButtonsState();
}

class _ConditionsButtonsState extends State<ConditionsButtons> {
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
              onPressed: (){
                //widget.acceptCallback,
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyHomePage(title: 'Dermosolution',)));;
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
              onPressed: widget.rejectCallback,
              child: const Text("Rechazar"),
            ),
          ),
        ],
      ),
    );
  }
}
