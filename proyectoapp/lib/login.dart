import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectoapp/editar_perfil.dart';
import 'package:proyectoapp/home.dart';
import 'package:proyectoapp/registro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* RUTAS */
    return MaterialApp(home: Login(), initialRoute: '/', routes: {
      //'/': (context) => Login(),
      '/home': (context) => Home(),
      '/editar_perfil':(context)=>Editar_Perfil(),
      '/registro': (context) => RegistrationScreen(),

    });
  }
}

class Login extends StatelessWidget {
  final _key = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
  /* Controladores */
  TextEditingController _correoController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    /* Envia correo y contraseña para conectarse */
    void iniciarSesion() async {
      dynamic authResult = await _auth.loginUser(
          _correoController.text, _passwordController.text);
      if (authResult == null) {
        print('Error, no ha sido posible iniciar sesion');
      } else {
        _correoController.clear();
        _passwordController.clear();
        print("Inicio de sesion exitoso");
        Navigator.pushNamed(context, '/home');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
          key: _key,
          child: Column(children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background4.png'),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text("Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold)),
                          )))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(239, 127, 26, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[100]))),
                                child: new TextFormField(
                                  controller: _correoController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Correo necesario';
                                    } else
                                      return null;
                                  },
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Correo",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                )),

                            Container(
                                padding: EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Correo necesario';
                                    } else
                                      return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Contraseña",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                ))
                          ],
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 50,
                        child: Center(
                          child: RaisedButton(
                            child: Text("Ingresar",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                iniciarSesion();
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(255, 114, 21, 1))),
                            padding: EdgeInsets.all(10.0),
                            color: Color.fromRGBO(255, 114, 21, 1),
                          ),
                        )),

                    SizedBox(
                      height: 50,
                    ),
                    new InkWell(
                      child: Text("Registrarse",
                          style: TextStyle(
                              color: Color.fromRGBO(218, 122, 59, 1),
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.pushNamed(context, '/registro');
                      },
                    ),
                  ],
                ))
          ])),
    );
  }
}
