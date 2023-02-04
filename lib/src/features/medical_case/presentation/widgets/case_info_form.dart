import 'package:flutter/material.dart';

import 'field_picker.dart';

class CaseInfoForm extends StatefulWidget {
  const CaseInfoForm({super.key});

  @override
  State<CaseInfoForm> createState() => _CaseInfoFormState();
}

class _CaseInfoFormState extends State<CaseInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Column(
        children: const [
          FieldCreateCaseWidget(
            dropList: ['Fisura', 'asd'],
            fieldName: 'Tipo de lesión',
          ),
          FieldCreateCaseWidget(
            dropList: ['Anillo','asd'],
            fieldName: 'Forma',
          ),
          FieldCreateCaseWidget(
            dropList: ['1', '2'],
            fieldName: 'Numero de lesiones',
          ),
          FieldCreateCaseWidget(
            dropList: ['Asimetrica','0as'],
            fieldName: 'Distribución',
          ),
          FieldCreateCaseWidget(
            dropList: ['Palido','asd'],
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
