import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/features/medical_case/presentation/widgets/cases_list_widget.dart';
import 'package:dermosolution_app/src/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

import '../../../configuration/form_configuration.dart';
import '../../../login/presentation/screens/login_screen.dart';
import '../../../medical_case/presentation/screens/case_creation_screen.dart';
import '../../../medical_case/presentation/screens/cases_list_screen.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    CasesScreen(),
    CaseCreationScreen(),
    Configuration(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined), label: "Crear caso"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications_outlined),
              label: "Configuración"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
