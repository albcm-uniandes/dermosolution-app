import 'package:flutter/material.dart';

import 'field_picker.dart';

class CaseInfoForm extends StatelessWidget {
  const CaseInfoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Column(
        children: const [
          FieldCreateCaseWidget(
            dropList: ['Fisura'],
            fieldName: 'Tipo de lesión',
          ),
          FieldCreateCaseWidget(
            dropList: ['Anillo'],
            fieldName: 'Forma',
          ),
          FieldCreateCaseWidget(
            dropList: ['1', '2'],
            fieldName: 'Numero de lesiones',
          ),
          FieldCreateCaseWidget(
            dropList: ['Asimetrica'],
            fieldName: 'Distribución',
          ),
          FieldCreateCaseWidget(
            dropList: ['Palido'],
            fieldName: 'Color',
          ),
          FieldCreateCaseWidget(
            dropList: ['Diagnostico por especialista', 'Automatico'],
            fieldName: 'Tipo de diagnostico',
          ),
        ],
      ),
    );
  }
}
