import 'package:flutter/material.dart';
import '../conditions/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';
import 'package:dermosolution_app/src/features/user_profile/service/service_profile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Future<Paciente> _futurePaciente;
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController  nombreCtrl = new TextEditingController();
  TextEditingController  apellidoCtrl = new TextEditingController();
  TextEditingController  fechaNacimientoCtrl = new TextEditingController();
  TextEditingController  lugarNacimientoCtrl = new TextEditingController();
  TextEditingController  lugarResidenciaCtrl = new TextEditingController();
  TextEditingController  edadCtrl = new TextEditingController();
  TextEditingController  sexoCtrl = new TextEditingController();
  TextEditingController  celularCtrl = new TextEditingController();
  TextEditingController  emailCtrl = new TextEditingController();
  TextEditingController  passwordCtrl = new TextEditingController();
  TextEditingController  repeatPasswordCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(title: 'Registro de usuario',),
          formUI(),
        ],
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
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
          )
        ],
      ),
    );
  }

  String gender = 'hombre';

  Widget formUI() {
    return  Column(
      children: <Widget>[

        itemsFormText("Nombre", nombreCtrl),
        itemsFormText("Apellido(s)", apellidoCtrl),
        itemsFormText("Fecha de nacimiento (dd/mm/aaaa", fechaNacimientoCtrl),
        itemsFormText("Lugar de nacimiento", lugarNacimientoCtrl),
        itemsFormText("Lugar de residencia", lugarResidenciaCtrl),
        itemsFormNumber("Edad", edadCtrl),
        itemsFormText("Sexo (HOMBRE, MUJER)", sexoCtrl),
        itemsFormText("Número de celular", celularCtrl),
        itemsFormText("Correo electrónico", emailCtrl),
        itemsFormPassword("Contraseña", passwordCtrl),
        itemsFormPassword("Confirmar contraseña", repeatPasswordCtrl),

      SizedBox(
        width: 100,
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            context: context;
            save();
        },
        child: const Text("Aceptar"),
      )),
      ],
    );
  }



  String validatePassword(String value) {
    print("valorrr $value passsword ${passwordCtrl.text}");
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    return "";
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

  save() {
    print("Guardando formulario");
    print("Nombre " + nombreCtrl.text);
    print("Apellido(s) " + apellidoCtrl.text);
    print("Fecha nacimiento " + fechaNacimientoCtrl.text);
    print("Lugar nacimiento " + lugarNacimientoCtrl.text);
    print("Lugar residencia " + lugarResidenciaCtrl.text);
    print("Edad " + edadCtrl.text);
    print("Sexo " + sexoCtrl.text);
    print("Celular " + celularCtrl.text);
    print("Correo " + emailCtrl.text);
    print("Password " + passwordCtrl.text);
    print("Repassword " + repeatPasswordCtrl.text);
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
}
