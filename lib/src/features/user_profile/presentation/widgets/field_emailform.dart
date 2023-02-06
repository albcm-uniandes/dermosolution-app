import 'package:flutter/material.dart';

class FieldUserEmailWidget extends StatelessWidget {
  const FieldUserEmailWidget(
  {super.key, required this.fieldName});

  final String fieldName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fieldName,
              ),

              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              validator: (value) {
                return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              },
            ),
          )
        ],
        ),
    );
  }
}
