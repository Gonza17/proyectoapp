import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Newpost extends StatefulWidget {
  @override
  _NewpostState createState() => _NewpostState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _NewPostState extends State<Newpost> {
  AppState state;
  File imageFile;
}
