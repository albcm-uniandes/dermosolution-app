import 'package:dermosolution_app/src/features/login/presentation/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Input generator should return same name', (tester) async {
    const x = MaterialApp(home: Material(child: InputGenerator(text: 'test')));
    await tester.pumpWidget(x);
    expect(find.text('test'), findsOneWidget);
  });
}
