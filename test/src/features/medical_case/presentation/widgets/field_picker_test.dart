import 'package:dermosolution_app/src/features/medical_case/presentation/widgets/field_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Field form generator for create case should return same name',
      (tester) async {
    Widget x = MaterialApp(
        home: Material(
            child: FieldCreateCaseWidget(
      dropList: ['Test1', 'Test2'],
      fieldName: 'Test field',
      onChanges: () {},
    )));
    await tester.pumpWidget(x);
    expect(find.text('Test field'), findsOneWidget);
    expect(find.text('Test2'), findsOneWidget);
  });
}
