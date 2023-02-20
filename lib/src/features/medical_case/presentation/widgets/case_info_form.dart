import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';

import 'field_picker.dart';

class CaseInfoForm extends StatefulWidget {
  const CaseInfoForm({super.key, required this.callable});

  final Function callable;

  @override
  State<CaseInfoForm> createState() => _CaseInfoFormState();
}

class _CaseInfoFormState extends State<CaseInfoForm> {
  // Todo add i18n
  static final List<String> lesionList = [
    'Mácula',
    'Pápula',
    'Parche',
    'Placa',
    'Módulo',
    'Ampolla',
    'Ulcera',
    'Vesicula'
  ];
  static final List<String> shapeList = [
    'Anillo',
    'Domo',
    'Ovalada',
    'Redonda',
    'Indefinida',
    ' Enrollada'
  ];
  static final List<String> quantityList = [
    'Solitaria',
    'Multiple',
    'Recurrente',
    'Diseminada'
  ];
  static final List<String> distributionList = [
    'Asimetricca',
    'Confluente',
    ' Simétrica',
    'Esparcida'
  ];
  static final List<String> colorList = [
    'Palido',
    'Rojo',
    'Oscuro',
    'Negro',
    'Verde'
  ];

  static final List<String> diagnosticTypes = [
    'Diagnostico por especialista',
    'Automatico'
  ];

  String lession = lesionList.first;
  String shape = shapeList.first;
  String quantity = quantityList.first;
  String distribition = distributionList.first;
  String colorLession = colorList.first;
  String diagnosticType = diagnosticTypes.first;

  void initState(){
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    setState(() {
      widget.callable([
        lession,
        shape,
        quantity,
        distribition,
        colorLession,
        diagnosticType
      ]);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
      child: Column(
        children: [
          FieldCreateCaseWidget(
            dropList: lesionList,
            onChanges: (value) {
              setState(() {
                lession = value;
              });
              _updateData();
            },
            fieldName: 'Tipo de lesión',
          ),
          FieldCreateCaseWidget(
            dropList: shapeList,
            onChanges: (value) {
              setState(() {
                shape = value;
              });
              _updateData();
            },
            fieldName: 'Forma',
          ),
          FieldCreateCaseWidget(
            dropList: quantityList,
            onChanges: (value) {
              setState(() {
                quantity = value;
              });
              _updateData();

            },
            fieldName: 'Numero de lesiones',
          ),
          FieldCreateCaseWidget(
            dropList: distributionList,
            onChanges: (value) {
              setState(() {
                distribition = value;
              });
              _updateData();
            },
            fieldName: 'Distribución',
          ),
          FieldCreateCaseWidget(
            dropList: colorList,
            onChanges: (value) {
              setState(() {
                colorLession = value;
              });
              _updateData();
            },
            fieldName: 'Color',
          ),
          FieldCreateCaseWidget(
            dropList: diagnosticTypes,
            onChanges: (value) {
              setState(() {
                diagnosticType = value;
              });
              _updateData();
            },
            fieldName: 'Tipo de diagnostico',
          ),
        ],
      ),
    );
  }
}
