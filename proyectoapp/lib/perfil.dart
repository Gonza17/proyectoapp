import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoapp/editar_perfil.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

enum SelectSource { camara, galeria }

class _PerfilState extends State<Perfil> {
  /* Inicializar datos*/
  String userID = "";
  String userEmail = "";
  String nombre_user = "";
  String ciudad_user = "";
  String pais_user = "";
  String descripcion_user = "";
  String imagen_perfil_user = "";
  List<DropdownMenuItem<String>> _ciudadItems;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

//informacion de la persona autentificada
  fetchUserInfo() async {
    User getUser = FirebaseAuth.instance.currentUser;
    userID = getUser.uid; // ID DE LA PERSONA AUTENTIFICADA
    userEmail = getUser.email;
    DocumentSnapshot usuario_actual = await FirebaseFirestore.instance
        .collection('info_usuario')
        .doc(userID)
        .get(); 
    nombre_user = usuario_actual['nombre'];
    ciudad_user = usuario_actual['ciudad'];
    pais_user = usuario_actual['pais'];
    imagen_perfil_user = usuario_actual['imagen_perfil'];
    descripcion_user = usuario_actual['descripcion'];
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
            "$ciudad_user,$pais_user",
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

          RaisedButton(
            child: Text("Editar perfil",
                style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w300)),
            color: Colors.white,
            onPressed: () {

                Navigator.pushNamed(context, '/editar_perfil');
              }
          ),
          SizedBox(
            height: 15,
          ),
          
        ],
      ),
    ));
  }
}
