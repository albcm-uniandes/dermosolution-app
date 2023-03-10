import 'dart:io';
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../body_part_selector/presentation/screens/body_part_selector_screen.dart';
import '../../../conditions/presentation/widgets/header.dart';
import '../widgets/case_info_form.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:simple_s3/simple_s3.dart';

import 'cases_list_screen.dart';

class CaseCreationScreen extends StatefulWidget {
  const CaseCreationScreen({super.key});

  @override
  State<CaseCreationScreen> createState() => _CaseCreationScreenState();
}

class _CaseCreationScreenState extends State<CaseCreationScreen> {
  final List<File?> images = [];

  late bool loading = false;
  late dynamic body = '';
  late dynamic formInfo = '';

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => images.add(imageTemp));
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void initState() {
    super.initState();
  }

  Future<http.Response> createCase(String title) {
    return http.post(
      Uri.parse('https://localhost:5000/caso'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }

  Future<void> uploadPhotos() async {
    SimpleS3 _simpleS3 = SimpleS3();
    setState(() {
      loading = true;
    });
    images.forEach((element) async {
      await _simpleS3.uploadFile(element!, 'dermosolutionsweb',
          'us-east-1:cfc6da9c-7723-4c6b-8111-05721308c8a6', AWSRegions.usEast1,
          debugLog: true, s3FolderPath: "evidencias-casos");
    });
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                        const Text('Anexar Evicencia',
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
                                enableInfiniteScroll: false
                              ),
                              items: images.isNotEmpty
                                  ? images.map((e) => Container(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: const BoxDecoration(
                                      color: Colors.black),
                                  child: Image.file(e!, width: 1000, height: 100,))).toList()
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
                        // Todo: show feedback about parts selected
                        ConditionsButtons(
                            acceptCallback: () async {
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
                                await uploadPhotos();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CasesScreen()),
                                );
                              }
                            },
                            rejectCallback: () {})
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
