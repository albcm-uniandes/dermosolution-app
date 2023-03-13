import 'package:flutter/material.dart';
import '../home/screens/home.dart';
import '../user_profile/presentation/widgets/header.dart';

class Treatment extends StatefulWidget {
  const Treatment({super.key});

  @override
  _Treatment createState() => _Treatment();
}

class _Treatment extends State<Treatment> {
  //late Future<Paciente> _futurePaciente;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController  comentariosCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //_futurePaciente = obtenerPaciente();
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.fromLTRB(3, 35, 3, 25),
          child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScreenHeader(title: 'Tratamiento',),
                  formUI(),
                ],
              ),
            ),
          )
      ),
    );
  }

  itemsFormText(fieldName, controller){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: screenWidth * 0.85,
            child: TextFormField(
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.top,
              maxLines: 15,
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
            itemsFormText("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris sed purus at augue pulvinar efficitur vel sed turpis.", comentariosCtrl),

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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage(title: 'Dermosolution',)));;

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
    /*_futurePaciente = updatePacienteForm(
        comentariosCtrl.text;
    );

    if (_futurePaciente != null) {
      _showAlertDialog("Agregar comentario", "Comentario agregado con exito");
      print(comentariosCtrl.text);
    }*/
    _showAlertDialog("Agregar comentario", "Comentario agregado con exito");
  }

  /*FutureBuilder<Paciente> buildFutureBuilder() {
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
  }*/

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
