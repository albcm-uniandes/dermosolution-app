import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/medical_case_provider.dart';

class FieldCreateCaseWidget extends StatelessWidget {
  const FieldCreateCaseWidget(
      {super.key, required this.dropList, required this.fieldName});

  final List<String> dropList;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    Provider.of<LesionTypeModel>(context,listen: false).addItem(dropList.first);
    String dropdownValue =  Provider.of<LesionTypeModel>(context,listen: false).item;

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        fieldName,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: 'Comfortaa',
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
          width: 120,
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: const TextStyle(
                fontSize: 12, fontFamily: 'Comfortaa', color: Colors.black),
            onChanged: (String? value) {
              Provider.of<LesionTypeModel>(context, listen: false).addItem(value!);
            },
            items: dropList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ))
    ]);
  }
}
