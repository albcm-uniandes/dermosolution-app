import 'package:dermosolution_app/src/features/automatic/service/service_automatic.dart';
import 'package:flutter/material.dart';
import '../user_profile/presentation/widgets/header.dart';
import 'domain/models/case_profile.dart';

class AutomaticDiagnostic extends StatefulWidget {
  const AutomaticDiagnostic({super.key});

  @override
  _AutomaticDiagnostic createState() => _AutomaticDiagnostic();
}

class _AutomaticDiagnostic extends State<AutomaticDiagnostic> {
  late Future<Automatico> _futureAutomatico;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController  casoCtrl = TextEditingController();
  TextEditingController  fechaDiagnosticoCtrl = TextEditingController();
  TextEditingController  diagnosticoCtrl = TextEditingController();
  TextEditingController  nombreMedicoCtrl = TextEditingController();
  TextEditingController  correoCtrl = TextEditingController();
  TextEditingController  recomendacionesCtrl = TextEditingController();
  TextEditingController  ciudadCitaCtrl = TextEditingController();
  TextEditingController  fechaCitaPresencialCtrl = TextEditingController();
  TextEditingController  urlCitaRemotaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _futureAutomatico = obtenerAutomatico();
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
                  ScreenHeader(title: 'Diagnostico Automatico',),
                  FutureBuilder<Automatico>(
                    future: _futureAutomatico,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        casoCtrl.text = snapshot.data!.id.toString();
                        fechaDiagnosticoCtrl.text = snapshot.data!.fecha_diagnostico;
                        diagnosticoCtrl.text = snapshot.data!.diagnostico;
                        nombreMedicoCtrl.text = snapshot.data!.nombre_medico;
                        correoCtrl.text = snapshot.data!.correo;
                        recomendacionesCtrl.text = snapshot.data!.recomendaciones;
                        ciudadCitaCtrl.text = snapshot.data!.ciudadcita;
                        fechaCitaPresencialCtrl.text = snapshot.data!.fechacitapresencial;
                        urlCitaRemotaCtrl.text = snapshot.data!.urlCitaremota;
                        return formUI();
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                  //formUI(),
                ],
              ),
            ),
          )
      ),
    );
  }

  itemsFormText(fieldName, controller){
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 3, 2, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.22,
            height: 35,
            child:Text(
              fieldName,
              //overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.63,
            height: 35,
            child: TextFormField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              readOnly: true,
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

  itemsFormTextLarge(fieldName, controller){
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 3, 2, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.22,
            height:35,
            child:Text(
              fieldName,
              //overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: screenWidth * 0.63,
            height: 80,
            child: TextField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              readOnly: true,
              maxLines: 10,

              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: fieldName,
                isDense: true,
              ),
            ),
          )
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
            itemsFormText("Caso", casoCtrl),
            itemsFormText("Fecha Diagnostico", fechaDiagnosticoCtrl),
            itemsFormTextLarge("Diagnostico", diagnosticoCtrl),
            itemsFormText("Nombre Medico", nombreMedicoCtrl),
            itemsFormText("Correo Electrónico", correoCtrl),
            itemsFormTextLarge("Recomendaciones", recomendacionesCtrl),
            itemsFormText("Ciudad Cita", ciudadCitaCtrl),
            itemsFormText("Fecha Cita Presencial", fechaCitaPresencialCtrl),
            itemsFormText("URL Cita Remota", urlCitaRemotaCtrl),
            controlButtons(),
          ],
        ),
      ),
    );
  }

  controlButtons(){
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
                    //save();
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
                  Navigator.pushNamed(context, '/');
                },
                child: const Text("Rechazar"),
              ),
            ),
          ],
        ),
      );
  }



  void save() {
      print("consultado");
  }

  FutureBuilder<Automatico> buildFutureBuilder() {
    return FutureBuilder<Automatico>(
      future: _futureAutomatico,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text("Diagnostico automatico creado exisomante");
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
                onPressed: (){
                  Navigator.pushNamed(context, '/');
                },
              )
            ],
          );
        }
    );
  }
}
