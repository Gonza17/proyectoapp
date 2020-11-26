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
      bottomNavigationBar: BottomNavigationBar(currentIndex: 0, items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'inicio',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'buscar',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'nuevo post',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'perfil',
            backgroundColor: Colors.red),
      ]),
    );
  }
}
