import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  TextEditingController ingredientesInputController;

  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String nombre;
  String uid;
  String receta;
  String usuario;
  String ingredientes;

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

  enviar() async {
    if (_validarlo()) {
      setState(() {
        _isInAsyncCall = true;
      });
      if (_foto != null) {
        final _storage = FirebaseStorage.instance;
        var fireStoreRef = await _storage
            .ref()
            .child('usuario')
            .child(userID)
            .child('recetas')
            .child('$nombre.jpg')
            .putFile(_foto);

        var downloadUrl = await fireStoreRef.ref.getDownloadURL();

        setState(() {
          urlFoto = downloadUrl;
          Firestore.instance.collection('recetas').add({
            'uid': userID,
            'nombre': nombre,
            'image': urlFoto,
            'receta': receta
          });
          /* .then((value) => Navigator.of(context).pop())
              .catchError((onError) =>
                  print('error en registrar la receta del usuario'));*/
          _isInAsyncCall = false;
        });
      } else {
        Firestore.instance.collection('recetas').add({
          'uid': userID,
          'nombre': nombre,
          'image': urlFoto,
          'receta': receta
        });
        /*.then((value) => Navigator.pushNamed(context, '/home')
            .catchError(
                (onError) => print('error al registrar la receta de usuario')));*/
        _isInAsyncCall = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Commonthings.size = MediaQuery.of(context).size;

    return Scaffold(
        body: ModalProgressHUD(
      inAsyncCall: _isInAsyncCall,
      opacity: 0.5,
      dismissible: false,
      progressIndicator: CircularProgressIndicator(),
      color: Colors.blueGrey,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 10, right: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    child: GestureDetector(
                      onTap: getImage,
                    ),
                    margin: EdgeInsets.only(top: 20),
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.black),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: _foto == null
                                ? AssetImage('assets/images/azucar.gif')
                                : FileImage(_foto))),
                  )
                ],
              ),
              Text('click para cambiar foto'),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'titulo de la receta',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'porfavor ingrese algún titulo aquí';
                  }
                },
                onSaved: (value) => nombre = value.trim(),
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'ingredientes de la receta',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'porfavor ingrese algún ingrediente aquí';
                  }
                },
                onSaved: (value) => ingredientes = value.trim(),
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'receta',
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'porfavor ingrese alguna receta aquí';
                  }
                },
                onSaved: (value) => receta = value,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Crear Receta',
                          style: TextStyle(color: Colors.white)),
                      color: Colors.green,
                      onPressed: () {
                        enviar();
                        Navigator.pushNamed(context, '/home');
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
