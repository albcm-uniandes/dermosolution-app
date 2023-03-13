import 'package:flutter/material.dart';

import '../../../info_case/presentation/screens/case_screen.dart';


class Todo {
  final String idCase;
  final String descriptionCase;

  Todo(this.idCase, this.descriptionCase);
}


class Case extends StatelessWidget {
  final String id;
  final String description;
  final String diagnosticType;
  final String specialist;
  final String status;

  const Case({super.key, required this.id, required this.description,
  required this.specialist, required this.status, required this.diagnosticType});

  static const TextStyle boldStyle =  TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Comfortaa',
      fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CaseScreen(caseId: id),
            )
          );
        },
        /*print(id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(id)));*/
      child: Container(
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
                const Text('Caso número',
                    style: boldStyle),
                Text(id ?? '' ),

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
        )
      )
    );
  }
}
