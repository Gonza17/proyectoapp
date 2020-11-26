import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('King´s Food'),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(''),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('buscar'),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('nuevo post'),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Mensajes'),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('perfil'),
            backgroundColor: Colors.red),
      ]),
    );
  }
}
