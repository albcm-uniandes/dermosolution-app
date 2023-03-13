import 'dart:io';
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:dermosolution_app/src/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../body_part_selector/presentation/screens/body_part_selector_screen.dart';
import '../../../conditions/presentation/widgets/header.dart';
import '../widgets/case_info_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:simple_s3/simple_s3.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';

import 'cases_list_screen.dart';

class CaseCreationScreen extends StatefulWidget {
  const CaseCreationScreen({super.key});

  @override
  State<CaseCreationScreen> createState() => _CaseCreationScreenState();
}

class _CaseCreationScreenState extends State<CaseCreationScreen> {
  final List<File?> images = [];
  String baseUrl = dotenv.get('baseUrl',
      fallback: 'https://dermosbkend.onrender.com/api/v1');
  late int medicalCaseId;

  late bool loading = false;
  late Map<String, dynamic> body = {};

  late dynamic formInfo = ['Mácula', 'Anillo', 'Solitaria', 'Confluente', 'Palido',' Diagnostico por especialista'];

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

  Future<http.Response> createCase(List<String> formInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var pacientePreference =  prefs.getInt('pacienteId').toString();
    String paciente = pacientePreference;
    DateTime now = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(now);
    print(date);
    http.Response medicalCaseRequest = await http.post(
      Uri.parse('$baseUrl/casos-medicos/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'descripcion': 'Descripción caso base',
        "estado": "CREADO",
        "fecha_creacion": date.toString(),
        "paciente": paciente,
        "medico": null,
        "tipo": formInfo[0],
        "forma":formInfo[1],
        "numero": formInfo[2],
        "distribucion": formInfo[3],
        "color": formInfo[4],
        "diagnosticos": [],
        "imagenes": []
      }),
    );
    print(medicalCaseRequest.body);
    print('Crear caso' + medicalCaseRequest.statusCode.toString()) ;
    String caseId = jsonDecode(medicalCaseRequest.body)['id'].toString();
    var upload = uploadPhotos(caseId);
    await upload;
    return medicalCaseRequest;
  }

  Future<void> uploadPhotos(String caseId) async {
    SimpleS3 _simpleS3 = SimpleS3();
    final String s3_url ='https://dermosolutionsweb.s3.amazonaws.com/evidencias-casos/';
    var wait;
    images.forEach((element) async {
      wait = await _simpleS3.uploadFile(element!, 'dermosolutionsweb',
          'us-east-1:cfc6da9c-7723-4c6b-8111-05721308c8a6', AWSRegions.usEast1,
          debugLog: false, s3FolderPath: "evidencias-casos");
      await wait;
      final wait_parsed = wait.substring(wait.toString().lastIndexOf('/') + 1);
      print(s3_url + wait_parsed);
      print('Ver datos' +wait);
      final response= await http.post(
        Uri.parse('$baseUrl/casos-medicos/$caseId/imagenes/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "caso": "$caseId",
          "url": s3_url + wait_parsed
        }),
      );
      await response;
      print(caseId);
      print(response.body);
      print('Subir foto'+response.statusCode.toString());
    });
  }

  List<Widget> activeParts(Map<String, dynamic> json) {
    List<Widget> widgets = [];
    if (json == null) {
      widgets.add(Text('Ninguna parte seleccionada '));
    } else {
      for (var element in json.entries) {
        if (element.value == true) {
          widgets.add(Text(element.key));
        }
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    print(formInfo);
    return Scaffold(
      body: !loading
          ? SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ScreenHeader(
                          title: 'Creación de consulta',
                        ),
                        CaseInfoForm(callable: (value) {
                          setState(() {
                            formInfo = value;
                          });
                        }),
                        const Text('Anexar Evidencia',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.bold,
                            )),
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
                        Column(
                          children: <Widget>[
                            CarouselSlider(
                              options: CarouselOptions(
                                  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height,
                                  enableInfiniteScroll: false),
                              items: images.isNotEmpty
                                  ? images
                                      .map((e) => Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: const BoxDecoration(
                                              color: Colors.black),
                                          child: Image.file(
                                            e!,
                                            width: 1000,
                                            height: 100,
                                          )))
                                      .toList()
                                  : [
                                      Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png',
                                        fit: BoxFit.cover,
                                        width: 1000,
                                      )
                                    ],
                            )
                          ],
                        ),
                        Column(
                          children: activeParts(body!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 150,
                            height: 30,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black),
                              onPressed: () async {
                                final bodyParts = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BodyPartSelectorScreen()),
                                );
                                setState(() {
                                  body = bodyParts;
                                });
                              },
                              child: const Text("Seleccionar partes"),
                            ),
                          ),
                        ),
                        ConditionsButtons(
                            acceptCallback: () async {
                              setState(() {
                                loading = true;
                              });
                              if (images.isEmpty || body == null) {
                                Fluttertoast.showToast(
                                  msg: "No se puede agregar sin foto",
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.black,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              } else {
                                var x= createCase(formInfo);
                                await x;
                                setState(() {
                                  loading = false;
                                });
                                if (!loading) {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CasesScreen()),
                                  );
                                }
                              }
                            },
                            rejectCallback: () {
                              Navigator.pushNamed(context, '/');
                            })
                      ],
                    ),
                  )
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
