import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DisplayPhotoScreen extends StatelessWidget{
  final XFile photo;

  const DisplayPhotoScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.file(File(photo.path), fit:BoxFit.cover, width: 250,),
    );
  }
}