import 'package:flutter/material.dart';

class FieldCreateCaseWidget extends StatelessWidget {
  const FieldCreateCaseWidget(
      {super.key, required this.dropList, required this.fieldName});

  final List<String> dropList;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          fieldName,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 150,
          child: DropdownButton(
              isExpanded: true,
              value: dropList.first,
              icon: const Icon(Icons.arrow_drop_down),
              elevation: 16,
              style: const TextStyle(
                  fontSize: 12, fontFamily: 'Comfortaa', color: Colors.black),
              onChanged: (String? value) {},
              items: dropList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList()),
        )
      ],
    );
  }
}
