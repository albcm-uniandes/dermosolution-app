import 'package:flutter/material.dart';


class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              )),
          Image.asset('lib/assets/images/logo.png', width: 65),
        ],
      ),
    );
  }
}