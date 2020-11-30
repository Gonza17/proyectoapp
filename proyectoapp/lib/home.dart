import 'package:flutter/material.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [
    Center(child: Text('home')),
    Center(child: Text('buscar')),
    Center(child: Text('new post')),
    Center(child: Text('mensajes')),
    Center(child: Text('perfil')),
  ];
  final AuthenticationService _auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('King´s Food'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar Sesión',
            onPressed: () async{
              await _auth.cerrarSesion().then((result){
                print('cerrar sesion exitoso');
                Navigator.of(context).pop(true);
              }
              );
              //scaffoldKey.currentState.showSnackBar(snackBar);
            },
          )
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'inicio',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'buscar',
              backgroundColor: Colors.red),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'nuevo post',
              backgroundColor: Colors.orange),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Mensajes',
              backgroundColor: Colors.yellow),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'perfil',
              backgroundColor: Colors.green),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
