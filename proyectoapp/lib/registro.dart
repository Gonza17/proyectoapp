import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectoapp/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();



  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _edadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("Usuarios");
    void registrar() async {
      await FirebaseFirestore.instance.collection("Usuarios").add({"nombre":_nombreController.text, "correo":_emailContoller.text,"contraseña":_passwordController.text,"edad":_edadController.text}).then((value) => print(value.id));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      
      body: Container(
        //height: 400,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background4.png'),
            fit: BoxFit.cover
          )
        ),
        //color: Colors.deepPurpleAccent,
        
        child: Center(
          
          child: Form(
            key: _key,
            
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Registro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nombreController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nombre no puede estar vacio';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailContoller,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Correo no puede estar vacio';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Correo',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Contraseña no puede estar vacia';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Contraseña',
                            labelStyle: TextStyle(color: Colors.white)),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _edadController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Edad';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Edad',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            )),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 180),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            textTheme: ButtonTextTheme.accent ,
                            child: Text('Registrarse',style: TextStyle(color: Colors.white,)),
                            onPressed: () {
                              if (_key.currentState.validate()) {
                                registrar();
                              }
                            },
                            color: Color(0xffff914d),
                          ),
                          FlatButton(
                            textTheme: ButtonTextTheme.accent ,
                            child: Text('Volver' ,style: TextStyle(color: Colors.white,)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Color(0xffff914d),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}