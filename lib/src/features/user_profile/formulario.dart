import 'dart:ffi';

import 'package:flutter/material.dart';
import '../user_profile/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';
import 'package:dermosolution_app/src/features/user_profile/service/service_profile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Future<Paciente> _futurePaciente;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController  nombreCtrl = TextEditingController();
  TextEditingController  apellidoCtrl = TextEditingController();
  TextEditingController  fechaNacimientoCtrl = TextEditingController();
  TextEditingController  lugarNacimientoCtrl = TextEditingController();
  TextEditingController  lugarResidenciaCtrl = TextEditingController();
  TextEditingController  edadCtrl = TextEditingController();
  TextEditingController  sexoCtrl = TextEditingController();
  TextEditingController  celularCtrl = TextEditingController();
  TextEditingController  emailCtrl = TextEditingController();
  TextEditingController  passwordCtrl = TextEditingController();
  TextEditingController  repeatPasswordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(3, 35, 3, 25),
          child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScreenHeader(title: 'Registro de usuario',),
                  formUI(),
                ],
              ),
            ),
          )
      ),
    );
  }

  itemsFormNumber(fieldName, controller){
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: fieldName,
              ),
            ),
          )
        ],
      ),
    );
  }

  itemsFormText(fieldName, controller){
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: fieldName,
              ),
            ),
          )
        ],
      ),
    );
  }

  itemsFormPassword(fieldName, controller){
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: fieldName,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget formUI() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      child: Scrollbar(
        isAlwaysShown: false, //always show scrollbar
        thickness: 10, //width of scrollbar
        radius: Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.left, //which side to show scrollbar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            itemsFormText("Nombre", nombreCtrl),
            itemsFormText("Apellido(s)", apellidoCtrl),
            itemsFormText("Fecha de nacimiento (aaaa-mm-dd", fechaNacimientoCtrl),
            itemsFormText("Lugar de nacimiento", lugarNacimientoCtrl),
            itemsFormText("Lugar de residencia", lugarResidenciaCtrl),
            itemsFormNumber("Edad", edadCtrl),
            itemsFormText("Sexo (HOMBRE, MUJER)", sexoCtrl),
            itemsFormText("Número de celular", celularCtrl),
            itemsFormText("Correo electrónico", emailCtrl),
            itemsFormPassword("Contraseña", passwordCtrl),
            itemsFormPassword("Confirmar contraseña", repeatPasswordCtrl),
            controlButtons(),
          ],
        ),
      ),
    );
  }

  controlButtons(){
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: const EdgeInsets.fromLTRB(3, 25, 3, 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    save();
                  },
                  child: const Text("Aceptar"),
                )
            ),
            SizedBox(
              width: 100,
              height: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(239, 92, 92, 1.0)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Rechazar"),
              ),
            ),
          ],
        ),
      );
  }

  String validatePassword(String value) {
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    } else {
      return "";
    }
  }

  String validateText(String campo, String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "El $campo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El $campo debe de ser a-z y A-Z";
    }
    return "";
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "El telefono es necesariod";
    } else if (value.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return "";
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return "";
    }
  }

  String validateDate(String value) {
    String pattern =
        r'^\d{4}([\-/.])(0?[1-9]|1[1-2])\1(3[01]|[12][0-9]|0?[1-9])$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "La fecha es necesaria";
    }else if (!regExp.hasMatch(value)) {
      return "Fecha invalida (aaaa-mm-dd)";
    } else {
      return "";
    }
  }

  String validateSex(String campo, String value) {

    if (value.isEmpty) {
      return "El $campo es necesario";
    } else if (value == "HOMBRE" || value == "MUJER") {
      return "";
    }
    return "El $campo debe de ser HOMBRE o MUJER";
  }



  void save() {
    String salida = "";
    salida = "${validateText("nombre", nombreCtrl.text)}\n";
    salida = "$salida${validateText("apellido", nombreCtrl.text)}\n";
    salida = "$salida${validateDate(fechaNacimientoCtrl.text)}\n";
    salida = "$salida${validateText("lugar de nacimiento", lugarNacimientoCtrl.text)}\n";
    salida = "$salida${validateText("lugar de residencia", lugarResidenciaCtrl.text)}\n";
    salida = "$salida${validateSex("sexo", sexoCtrl.text)}\n";
    salida = "$salida${validateEmail(emailCtrl.text)}\n";
    salida = salida + validatePassword(repeatPasswordCtrl.text);
    print(url);
    _futurePaciente = createPaciente(
        nombreCtrl.text,
        apellidoCtrl.text,
        fechaNacimientoCtrl.text,
        lugarNacimientoCtrl.text,
        lugarResidenciaCtrl.text,
        edadCtrl.text,
        sexoCtrl.text,
        celularCtrl.text,
        emailCtrl.text,
        passwordCtrl.text
    );


    if (_futurePaciente != null) {
      if (salida.length<11){
        _showAlertDialog("Registrar usuario", "Usuario registrado exitosamente", true);
        nombreCtrl.clear();
        apellidoCtrl.clear();
        fechaNacimientoCtrl.clear();
        lugarNacimientoCtrl.clear();
        lugarResidenciaCtrl.clear();
        edadCtrl.clear();
        sexoCtrl.clear();
        celularCtrl.clear();
        emailCtrl.clear();
        passwordCtrl.clear();
        repeatPasswordCtrl.clear();
      } else {
        _showAlertDialog("Registrar usuario", salida, false );
      }

    }
  }

  FutureBuilder<Paciente> buildFutureBuilder() {
    return FutureBuilder<Paciente>(
      future: _futurePaciente,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text("Paciente creado exisomante");
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void _showAlertDialog(titulo, mensaje, estado) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: <Widget>[
              ElevatedButton(
                child: Text("CERRAR", style: TextStyle(color: Colors.white),),
                onPressed: (){
                  if (estado == true) {
                    Navigator.pushNamed(context, 'perfil_dermatologico');
                  } else {
                    Navigator.pop(context);
                  }
                  },
              )
            ],
          );
        }
    );
  }
}
