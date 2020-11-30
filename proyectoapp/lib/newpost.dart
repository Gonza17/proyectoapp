import 'dart:async';
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
  File _image;
  final picker = ImagePicker();
  Future getImageFromCam() async {
    var image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }
}
