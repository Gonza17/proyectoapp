import 'package:flutter/material.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectoapp/inicio.dart';
import 'package:proyectoapp/busqueda.dart';
import 'package:proyectoapp/mensajes.dart';
import 'package:proyectoapp/newpost.dart';
import 'package:proyectoapp/perfil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController controlador;

  String userID = "";
  String userEmail = "";

  final AuthenticationService _auth = AuthenticationService();
  List userProfilesList = [];

  @override
  void initState() {
    super.initState();
    controlador = new TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
            title: new Text("King´s food"),
            bottom: new TabBar(
              tabs: <Widget>[
                new Tab(icon: new Icon(Icons.home)),
                new Tab(icon: new Icon(Icons.search)),
                new Tab(icon: new Icon(Icons.post_add)),
                new Tab(icon: new Icon(Icons.message)),
                new Tab(icon: new Icon(Icons.contacts)),
              ],
              controller: controlador,
            )),
        body: new TabBarView(
          children: <Widget>[
            new Inicio(),
            new Busqueda(),
            new Newpost(),
            new Mensajes(),
            new Perfil(),
          ],
          controller: controlador,
        ));
  }
}
