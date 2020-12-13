import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class Newpost extends StatelessWidget {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    var PickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        _image = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
      ),
      body: new Center(
        child: _image == null
            ? new Text('no image selected')
            : new Image.file(_image),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
