/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Newpost extends StatefulWidget {
  @override
  _Newpost createState() => _Newpost();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _Newpost extends State<Newpost> {
  // File _image;
  final picker = ImagePicker();
  Future getImageFromCam() async {
    var image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      //_image = image;
    });
  }

  Future getImageFromGal() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      ////_image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: ('esta es una prueba'),
          ),
      // body: ListView{
      // children: <Widget>
      //},
    );
  }
}*/
