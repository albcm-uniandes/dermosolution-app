import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/constants.dart';
import '../../../conditions/presentation/screens/conditions_screen.dart';
import '../../../configuration/domain/models/patient_profile.dart';
import '../../../home/screens/home.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return "";
    }
  }

  Future<int> loginRequest(String email, String clave) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final pacientePost = await http.post(
      Uri.parse(endpoint + '/api-user-login/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{'username': email, 'password': clave}),
    );
    if (pacientePost.statusCode == 200) {
      setState(() {
        logged = true;
      });
      prefs.setInt('pacienteId', jsonDecode(pacientePost.body)['id']);
      prefs.setString('token', jsonDecode(pacientePost.body)['token']);

    } else {
      setState(() {
        logged = false;
      });
    }

    await pacientePost;
    return pacientePost.statusCode;
  }

  void initState() {
    super.initState();
    logged = false;
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? email = '';
  String? password = '';
  bool logged = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextFormField(
              controller: emailController,
              obscureText: false,
              validator: (val){
                if(val == null)
                  print('Enter valid input');
                else
                  print(val);
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Correo electronico",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20, 0.0, 10),
            child: SizedBox(
              width: screenWidth * 0.75,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    email = emailController.text;
                    password = passwordController.text;
                  });
                  print(email);
                  var response = loginRequest(
                      emailController.text, passwordController.text);
                  await response;
                  if (logged == true) {
                    print('navegando');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                  title: 'Dermosolution',
                                )));
                  } else {
                    Fluttertoast.showToast(
                      msg: "Usuario o contraseña incorrectos",
                      toastLength: Toast.LENGTH_SHORT,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }
                },
                child: const Text("Ingresar"),
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.75,
            height: 40,
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConditionsScreen()));
              },
              child: const Text('Crear cuenta'),
            ),
          ),
        ],
      ),
    );
  }
}
