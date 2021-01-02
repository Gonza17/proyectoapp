import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Editar_Perfil extends StatefulWidget {
  @override
  _EditarPerfil createState() => _EditarPerfil();
}

enum SelectSource { camara, galeria }

class _EditarPerfil extends State<Editar_Perfil>{
  final _key = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
   String _itemCiudad;
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _edadController = TextEditingController();
  TextEditingController _ciudadController = TextEditingController();
  List<DropdownMenuItem<String>> _ciudadItems;
  @override
  void initState() {
    super.initState();
    setState(() {
      _ciudadItems = getCiudadItems();
      _itemCiudad = _ciudadItems[0].value;
    });
  }
  getData() async {
    return await FirebaseFirestore.instance.collection('ciudades').get();
  }

  //Dropdownlist from firestore
   List<DropdownMenuItem<String>> getCiudadItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataCiudades;
    getData().then((data) {
      
      dataCiudades = data;
      dataCiudades.docs.forEach((obj) {
        print('${obj.id} ${obj['nombre']}');
        items.add(DropdownMenuItem(
          value: obj.id,
          
          child: Text(obj['nombre'],style: TextStyle(color: Colors.black)),
        ));
      });
    }).catchError((error) => print('hay un error.....' + error));

    items.add(DropdownMenuItem(
      value: '0',
      child: Text('- Seleccione -', style: TextStyle(color: Colors.white),) ,
    ));

    return items;
  }
   Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
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
                      DropdownButtonFormField(
                        
                        validator: (value) =>
                        value == '0' ? 'Debe seleccionar una ciudad' : null,
                        decoration: InputDecoration(
                            labelText: 'Ciudad', icon: Icon(FontAwesomeIcons.city,color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white)),
                            
                        value: _itemCiudad,
                        items: _ciudadItems,
                        onChanged: (value) {
                          setState(() {
                            _itemCiudad = value;
                          });
                        }, //seleccionarCiudadItem,
                        
                        onSaved: (value) => _itemCiudad = value,
                      ),
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
                            child: Text('Guardar cambios',style: TextStyle(color: Colors.white,)),
                            onPressed: () {
                              Navigator.pop(context);
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
      )
    );
  }
}