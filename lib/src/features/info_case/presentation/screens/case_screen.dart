import 'package:carousel_slider/carousel_slider.dart';
import 'package:dermosolution_app/src/features/info_case/service/service_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../conditions/presentation/widgets/header.dart';
import '../../domain/models/case.dart';

class CaseScreen extends StatefulWidget {
  const CaseScreen({super.key,  required this.caseId});

  final String caseId;

  @override
  State<CaseScreen> createState() => _CaseScreenState();
}

class _CaseScreenState extends State<CaseScreen> {
  late Future<CaseInformation> _futureCaseInformation;
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController  casoNumeroCtrl = TextEditingController();
  TextEditingController  tipoCtrl = TextEditingController();
  TextEditingController  formaCtrl = TextEditingController();
  TextEditingController  numeroCtrl = TextEditingController();
  TextEditingController  distribucionCtrl = TextEditingController();
  TextEditingController  colorCtrl = TextEditingController();

  final List<dynamic?> images = [];
  late bool loading = false;
  late Map<String, dynamic> body = {};

  @override
  Widget build(BuildContext context) {
    _futureCaseInformation = obtenerInformacionCaso(widget.caseId);
    print(widget.caseId);
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(3, 35, 3, 25),
          child: SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ScreenHeader(title: 'Caso Medico'),
                  FutureBuilder<CaseInformation>(
                    future: _futureCaseInformation,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final caseInfo = snapshot.data!;
                        casoNumeroCtrl.text = caseInfo.idCase.toString();
                        tipoCtrl.text = caseInfo.lesion;
                        formaCtrl.text = caseInfo.shape;
                        numeroCtrl.text = caseInfo.quantity;
                        distribucionCtrl.text = caseInfo.distribution;
                        colorCtrl.text = caseInfo.color;
                        return formUI(caseInfo.images);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }

  carrusel(List<dynamic> images){
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          enlargeStrategy:
          CenterPageEnlargeStrategy.height,
          enableInfiniteScroll: false
      ),
      items: images.isNotEmpty
          ? images.map((e) =>
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.black),
                child: Image.network(
                  e,
                  fit: BoxFit.cover,
                  width: 1000,
                )
              )
            ).toList():[
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png',
              fit: BoxFit.cover,
              //fit:BoxFit.fill,
              width: 320,
              height: 192,
            )
            ],
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
            child: TextField(
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
              controller: controller,
              enabled: false,
              decoration: InputDecoration(
                hintText: fieldName,
                  hintStyle: const TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                  ),

              ),
            ),
          )
        ],
      ),
    );
  }
  
  itemsTitle (title) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 35, bottom: 10),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 20,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }

  Widget formUI(List<dynamic> images) {
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
            itemsFormText("Caso número", casoNumeroCtrl),
            itemsFormText("Tipo de lesión", tipoCtrl),
            itemsFormText("Forma", formaCtrl),
            itemsFormText("Número de lesiones", numeroCtrl),
            itemsFormText("Distribución", distribucionCtrl),
            itemsFormText("Color", colorCtrl),
            itemsTitle("Evidencias"),
            carrusel(images),
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