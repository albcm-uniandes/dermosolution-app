import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import '../user_profile/presentation/widgets/header.dart';
import 'package:dermosolution_app/src/features/user_profile/domain/models/patient_profile.dart';
import 'package:dermosolution_app/src/features/user_profile/service/service_profile.dart';

import 'data/constants/profile_constants.dart';

class DermatologicalProfile extends StatefulWidget {
  const DermatologicalProfile({super.key});

  @override
  _DermatologicalProfile createState() => _DermatologicalProfile();
}

class _DermatologicalProfile extends State<DermatologicalProfile> {
  late Future<Paciente> _futurePaciente;
  GlobalKey<FormState> keyForm = GlobalKey();
  GroupController controller = GroupController();

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
                  ScreenHeader(title: 'Perfil dermatológico',),
                  formUI(),
                ],
              ),
            ),
          )
      ),
    );
  }

  itemCheckbox(textCheckbox){
    double screenWidth = MediaQuery.of(context).size.width;
    bool isChecked = false;
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.04,
            child: Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
                print(value);
              },
            ),
          ),
          SizedBox(
            width: screenWidth * 0.81,
            child: Text(
              textCheckbox,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
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
            /*itemCheckbox(profile1),
            itemCheckbox(profile2),
            itemCheckbox(profile3),
            itemCheckbox(profile4),
            itemCheckbox(profile5),
            itemCheckbox(profile6),*/

            SimpleGroupedCheckbox<int>(
              controller: controller,
              itemsTitle: [profile1, profile2, profile3, profile4, profile5, profile6],
              values: [1,2,3,4,5,6],
              groupStyle: GroupStyle(
                  activeColor: Colors.red,
                  itemTitleStyle: TextStyle(
                      fontSize: 13
                  )
              ),
              checkFirstElement: false,
            ),
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

  void save() {
    print(controller.selectedItem);
    print(url);
    /*_futurePaciente = createPaciente(
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
    }*/
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
