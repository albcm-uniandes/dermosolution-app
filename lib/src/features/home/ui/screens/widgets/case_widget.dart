import 'package:flutter/material.dart';

class Case extends StatelessWidget {
  final String description;
  final String diagnosticType;
  final String specialist;
  final String status;

  const Case({super.key, required this.description, required this.specialist, required this.status, required this.diagnosticType});



  static const TextStyle boldStyle =  TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Comfortaa',
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 250,
        width: double.maxFinite,
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Descripción',
                    style: boldStyle),
                Text(description ?? '' ),
                const Text('Tipo de diagnostico',
                    style: boldStyle),
                Text(diagnosticType ?? '' ),
                const Text('Especialista',
                    style: boldStyle),
                Text(specialist ?? '' ),
                const Text('Estado',
                    style: boldStyle),
                Text(status ?? '' ),

              ],
            ),
          ),
        ));
  }
}
