import 'package:flutter/material.dart';

class FieldCreateCaseWidget extends StatefulWidget {
  const FieldCreateCaseWidget(
      {super.key, required this.dropList, required this.fieldName, required this.onChanges});

  final Function onChanges;
  final List<String> dropList;
  final String fieldName;

  @override
  State<FieldCreateCaseWidget> createState() => _FieldCreateCaseWidgetState();
}

class _FieldCreateCaseWidgetState extends State<FieldCreateCaseWidget> {
  late String dropdownValue = widget.dropList.first;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        widget.fieldName,
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
              setState(() {
                dropdownValue = value!;
              });
              widget.onChanges(dropdownValue);
            },
            items: widget.dropList.map<DropdownMenuItem<String>>((
                String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ))
    ]);
  }
}
