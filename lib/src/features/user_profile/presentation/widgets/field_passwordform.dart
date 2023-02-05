import 'package:flutter/material.dart';

class FieldUserPasswordWidget extends StatelessWidget {
  const FieldUserPasswordWidget(
  {super.key, required this.fieldName});

  final String fieldName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /*Text(
          fieldName,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
          ),
        ),*/
        SizedBox(
          width: screenWidth * 0.85,
          height: 40,
          child: TextFormField(
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
            ),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: fieldName,
            ),

            onSaved: (String? value) {
              // This optional block of code can be used to run
              // code when the user saves the form.
            },
          ),
        )
      ],
    );
  }
}
