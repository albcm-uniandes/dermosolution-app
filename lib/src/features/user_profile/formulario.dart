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
    double screenWidth = MediaQuery.of(context).size.width;
    /*return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(title: 'Registro de usuario',),
          formUI(),
        ],
      ),
    );*/
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(3, 35, 3, 25),
          child: SizedBox(
            //child: const ScreenHeader(title: 'Registro de usuario',),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              keyboardType: TextInputType.number,
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fieldName,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fieldName,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            height: 35,
            child: TextFormField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fieldName,
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
      return "Ok";
    }
  }

  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return "null";
  }

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
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
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return "";
    }
  }

  void save() {
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
      _showAlertDialog("Registrar usuario", "Usuario registrado con exito");
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

  void _showAlertDialog(titulo, mensaje) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text(titulo),
            content: Text(mensaje),
            actions: <Widget>[
              ElevatedButton(
                child: Text("CERRAR", style: TextStyle(color: Colors.white),),
                onPressed: (){ Navigator.of(context).pop(); },
              )
            ],
          );
        }
    );
  }
}
