import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

enum SelectSource { camara, galeria }

class _PerfilState extends State<Perfil> {
  File _foto;
  String urlFoto="";
  String userID = "";
  String userEmail = "";
  String _itemCiudad;

  String nombre_user = "";
  String ciudad_user = "";
  String descripcion_user = "";
  String imagen_perfil_user = "";
  List<DropdownMenuItem<String>> _ciudadItems;
  //final AuthenticationService _auth = AuthenticationService();

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    //getUsuarioItems();
  }

  Future CaptureImagen(SelectSource opcion) async {
    File image;

    opcion == SelectSource.camara
        ? image = await ImagePicker.pickImage(source: ImageSource.camera)
        : image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _foto = image;
    });
  }

  Future getImagen() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione donde desea capturar la imagen'),
      title: Text('seleccione imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            CaptureImagen(SelectSource.camara);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camara'), Icon(Icons.camera)],
          ),
        ),
        FlatButton(
          onPressed: () {
            CaptureImagen(SelectSource.galeria);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    cambiar_imagen();
    showDialog(context: context, child: alerta);
    
  }

  fetchUserInfo() async {
    User getUser = FirebaseAuth.instance.currentUser;
    userID = getUser.uid; // ID DE LA PERSONA AUTENTIFICADA
    userEmail = getUser.email;
    DocumentSnapshot usuario_actual = await FirebaseFirestore.instance
        .collection('info_usuario')
        .doc(userID)
        .get(); //informacion de la persona autentificada
    nombre_user = usuario_actual['nombre'];
    ciudad_user = usuario_actual['ciudad'];
    imagen_perfil_user = usuario_actual['imagen_perfil'];
    descripcion_user = usuario_actual['descripcion'];
  }

/*
  getData() async {
    return await FirebaseFirestore.instance.collection('info_usuario').get();
  }

  //Dropdownlist from firestore
   List<DropdownMenuItem<String>> getUsuarioItems() {
    QuerySnapshot dataUsuario;
    getData().then((data) {
      
      dataUsuario = data;
      //print(dataCiudades.docs[0]['nombre']);
      dataUsuario.docs.forEach((obj) {
        if((obj.id)==userID){
          
          nombre_user = obj['nombre'];
          ciudad_user = obj['ciudad'];
          descripcion_user = obj['descripcion'];
          //print('Usuario encontrado!!! $nombre_user $ciudad_user'); 
        }
      });
    }).catchError((error) => print('hay un error.....' + error));
  }
  */

  cambiar_imagen() async {

    if (_foto != null) {
        final _storage = FirebaseStorage.instance;
        var fireStoreRef = await _storage
            .ref()
            .child('usuario')
            .child(userID)
            .child('perfil')
            .child('foto_perfil.jpg')
            .putFile(_foto);

        var downloadUrl = await fireStoreRef.ref.getDownloadURL();
        urlFoto = downloadUrl;
        print(urlFoto);
        updateImagen();
      }
  }

  Future updateImagen() async {
  CollectionReference perfil_usuario = FirebaseFirestore.instance.collection('info_usuario');
      return await perfil_usuario.doc(userID).update({
        'imagen_perfil': urlFoto,
       });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://s1.eestatic.com/2015/03/31/cocinillas/Cocinillas_22257914_116018278_1024x576.jpg"),
                    fit: BoxFit.cover)),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0, 2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage("$imagen_perfil_user"),
                  radius: 60.0,
                  child: GestureDetector(
                      onTap: getImagen,
                    )
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Text(
            nombre_user,
            style: TextStyle(
                fontSize: 25.0,
                color: Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            ciudad_user,
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            descripcion_user,
            style: TextStyle(
                fontSize: 15.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              elevation: 2.0,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                  child: Text(
                    "Texto",
                    style: TextStyle(
                        letterSpacing: 2.0, fontWeight: FontWeight.w300),
                  ))),
          SizedBox(
            height: 15,
          ),
          Text(
            "Texto || Texto",
            style: TextStyle(
                fontSize: 18.0,
                color: Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300),
          ),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Recetas",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "15",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Seguidores",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          "2000",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.pink, Colors.redAccent]),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 100.0,
                      maxHeight: 40.0,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Contact me",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Colors.pink, Colors.redAccent]),
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: 100.0,
                      maxHeight: 40.0,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Portfolio",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
