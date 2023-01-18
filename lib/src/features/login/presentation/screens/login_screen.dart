import 'package:dermosolution_app/src/features/login/presentation/widgets/description_widget.dart';
import 'package:dermosolution_app/src/features/login/presentation/widgets/form_widget.dart';
import 'package:dermosolution_app/src/features/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.05, 0, w * 0.05, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [widgetLogo, loginDescription, loginForm],
      ),
    );
  }
}
