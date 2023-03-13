import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_s3/simple_s3.dart';

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

  Future<http.Response> anexarEvidencia(String seguimiento, String url) {
    var response = http.post(
      Uri.parse('https://localhost:5000/caso'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'seguimiento': seguimiento,
        'url': url
      }),
    );
    return response;
  }

  Future<void> uploadPhotos() async {
    // todo: Crear folder y subir archivos
    SimpleS3 _simpleS3 = SimpleS3();
    var wait;
    setState(() {
      loading = true;
    });
    images.forEach((element) {
      wait = _simpleS3.uploadFile(element!, 'dermosolutionsweb',
          'us-east-1:cfc6da9c-7723-4c6b-8111-05721308c8a6', AWSRegions.usEast1,
          debugLog: true, s3FolderPath: "seguimientos");
    });
    await wait;
    setState(() {
      loading = false;
    });
    anexarEvidencia('title','');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const ScreenHeader(title: 'Seguimiento'),
          const Text('Texto..'),
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
          SizedBox(
            width: 150,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black),
              onPressed: () async {
                uploadPhotos();
              },
              child: const Text("Seleccionar partes"),
            ),
          ),
        ],
      ),
    );
  }
}