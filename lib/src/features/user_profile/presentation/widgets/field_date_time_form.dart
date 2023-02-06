import 'package:flutter/material.dart';

class FieldUserFormDateWidget extends StatelessWidget {
  const FieldUserFormDateWidget(
  {super.key, required this.fieldName});

  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fieldName,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 150,
          child: TextFormField(
              onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
            validator: (String? value) {
              return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
            },
          ),
        )
      ],
    );
  }
}
