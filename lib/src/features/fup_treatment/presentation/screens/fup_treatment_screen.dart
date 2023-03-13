import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_s3/simple_s3.dart';

import '../../../../shared/constants.dart';

import '../../../home/screens/home.dart';

class FupTreatmentScreen extends StatefulWidget{
  const FupTreatmentScreen({super.key});

  @override
  State<FupTreatmentScreen> createState() => _FupTreatmentScreenState();
}

class _FupTreatmentScreenState extends State<FupTreatmentScreen> {
  final List<File?> images = [];
  late bool loading = false;


  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => images.add(imageTemp));
    } on PlatformException catch (e) {}
  }

  void initState() {
    super.initState();
  }

  Future<http.Response> crearSeguimiento(String tratamiento) async{
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);

    var response = await http.post(
      Uri.parse('$baseUrl/seguimientos/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
      "tratamiento": tratamiento,
      "mensaje_paciente": "Prueba",
      "fecha_msg_paciente": date.toString(),
      "mensaje_medico": "Prueba",
      "fecha_msg_medico": date.toString(),
      "detalle": "Test",
      }),
    );
    String seguimientoId = jsonDecode(response.body)['id'].toString();
    var upload = uploadPhotos(seguimientoId);
    await upload;
    return response;
  }

  Future<void> uploadPhotos(String seguimiento) async {
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);
    final String s3_url ='https://dermosolutionsweb.s3.amazonaws.com/seguimientos/';
    SimpleS3 _simpleS3 = SimpleS3();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var wait;
    setState(() {
      loading = true;
    });
    images.forEach((element) async {
      wait = _simpleS3.uploadFile(element!, 'dermosolutionsweb',
          'us-east-1:cfc6da9c-7723-4c6b-8111-05721308c8a6', AWSRegions.usEast1,
          debugLog: true, s3FolderPath: "seguimientos");
      await wait;
      final wait_parsed = wait.substring(wait.toString().lastIndexOf('/') + 1);
      await http.post(
        Uri.parse('$baseUrl/imagenesdiagnostica/$seguimiento'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "seguimiento": seguimiento,
          "url": s3_url + wait_parsed,
          "fecha_creacion": date.toString(),
          "descripcion": "Test",
        }),
      );
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Seguimiento'),
          const Text('Agrega el seguimiento de tu caso con nuevas evidencias'),
          const Center(child: Text('Anexar evidencias'),),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  iconSize: 70,
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt_outlined)),
              IconButton(
                iconSize: 70,
                onPressed: () {
                  pickImage(ImageSource.gallery);
                },
                icon: const Icon(Icons.image),
              )
            ]),
          controlButtons(),
        ],
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
                onPressed: () async {
                  crearSeguimiento('1');
                      },
                child:  const Text("Anexar evidencia"),
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
              child: const Text("Regresar"),
            ),
          ),
        ],
      ),
    );
  }
}