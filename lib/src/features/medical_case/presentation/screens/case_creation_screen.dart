import 'dart:io';
import 'package:dermosolution_app/src/features/conditions/presentation/widgets/conditions_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../body_part_selector/presentation/screens/body_part_selector_screen.dart';
import '../../../conditions/presentation/widgets/header.dart';
import '../widgets/case_info_form.dart';

class CaseCreationScreen extends StatefulWidget {
  const CaseCreationScreen({super.key});

  @override
  State<CaseCreationScreen> createState() => _CaseCreationScreenState();
}

class _CaseCreationScreenState extends State<CaseCreationScreen> {
  File? image;

  late dynamic body = '';
  late dynamic formInfo = '';

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
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                SizedBox(
                  width: 150,
                  height: 30,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
                ConditionsButtons(
                    acceptCallback: () {
                      {}
                    },
                    rejectCallback: () {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
