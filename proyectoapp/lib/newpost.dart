import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Commonthings {
  static Size size;
}

class Newpost extends StatefulWidget {
  final String id;
  const Newpost({this.id});
  @override
  _NewpostState createState() => _NewpostState();
}

enum SelectSource { camara, galeria }

class _NewpostState extends State<Newpost> {
  File _foto;
  String urlFoto;
  bool _isInAsyncCall = false;
  String recetas;
  String userID = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    User getUser = FirebaseAuth.instance.currentUser;
    userID = getUser.uid;
    userEmail = getUser.email;
  }

  TextEditingController recetaInputController;
  TextEditingController nombreInputController;
  TextEditingController imageInputController;

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String nombre;
  String uid;
  String receta;
  String usuario;

  Future CaptureIamgen(SelectSource opcion) async {
    File image;

    opcion == SelectSource.camara
        ? image = await ImagePicker.pickImage(source: ImageSource.camera)
        : image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _foto = image;
    });
  }

  Future getImage() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione donde desea capturar la imagen'),
      title: Text('seleccione imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            CaptureIamgen(SelectSource.camara);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camcara'), Icon(Icons.camera)],
          ),
        ),
        FlatButton(
          onPressed: () {
            CaptureIamgen(SelectSource.galeria);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    showDialog(context: context, child: alerta);
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.orange,
      ),
    );
  }

  bool _validarlo() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void enviar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
