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
            label: Text(''),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: Text('buscar'),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: Text('nuevo post'),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: Text('Mensajes'),
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: Text('perfil'),
            backgroundColor: Colors.red),
      ]),
    );
  }
}
