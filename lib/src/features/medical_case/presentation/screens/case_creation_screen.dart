import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:dermosolution_app/src/features/take_photos/presentation/screens/take_photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../conditions/presentation/widgets/header.dart';
import '../widgets/case_info_form.dart';

class CaseCreationScreen extends StatefulWidget {
  const CaseCreationScreen({super.key});

  @override
  State<CaseCreationScreen> createState() => _CaseCreationScreenState();
}

class _CaseCreationScreenState extends State<CaseCreationScreen> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const ScreenHeader(
            title: 'Creación de consulta',
          ),
          const CaseInfoForm(),
          const Text('Anexar Evicencia',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              )),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              iconSize: 70,
              onPressed: () {
                pickImage(ImageSource.camera);
              },
              icon: const Icon(
                Icons.camera_alt_outlined,
              ),
            ),
            IconButton(
              iconSize: 70,
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
              icon: const Icon(Icons.image),
            ),
          ]),
          ConditionsButtons(acceptCallback: () {}, rejectCallback: () {})
        ],
      ),
    );
  }
}
