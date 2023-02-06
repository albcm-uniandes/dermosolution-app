import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          ScreenHeader(title: 'Listado de casos'),
        ],
      ),
    );
  }
}
