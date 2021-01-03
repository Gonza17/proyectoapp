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
import 'package:proyectoapp/model/user_model.dart';
class Editar_Perfil extends StatefulWidget {
  @override
  _EditarPerfil createState() => _EditarPerfil();
}

enum SelectSource { camara, galeria }

class _EditarPerfil extends State<Editar_Perfil>{
  final _key = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _PaisController = TextEditingController();
  TextEditingController _ciudadController = TextEditingController();

  File _foto;
  String urlFoto="";
  String userID = "";
  String userEmail = "";
  String _itemCiudad;
  dynamic usuario;
  String nombre_user = "";
  String ciudad_user = "";
  String descripcion_user = "";
  String imagen_perfil_user = "";

  String ciudad_usuario="";
  List<DropdownMenuItem<String>> _ciudadItems;
  //DocumentSnapshot usuario_actual;
  @override
  void initState() {
    super.initState();
     
      User getUser = FirebaseAuth.instance.currentUser;
      userID = getUser.uid; // ID DE LA PERSONA AUTENTIFICADA
      userEmail = getUser.email;
      fetchUserInfo() ;
      //ciudad_usuario=usuario.ciudad;
      _ciudadItems = getCiudadItems();
      _itemCiudad = _ciudadItems[0].value;
  }
  fetchUserInfo() async {
     usuario =  await DatabaseManager().getInfoUsuario(userID);
    
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
      child: Text('- Seleccione -', style: TextStyle(color: Colors.black),) ,
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
                
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Editar datos ${usuario.nombre}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  
                    alignment: Alignment(0.0, 2.5),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("${usuario.imagen_perfil}"),
                    radius: 120.0,
                    child: GestureDetector(
                        //onTap: getImagen, 
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: usuario.nombre,
                        
                        decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 30),
                      DropdownButtonFormField(
                        
                        validator: (value) =>
                        value == '0' ? 'Debe seleccionar una ciudad' : null,
                        decoration: InputDecoration(
                          
                            labelText: 'Ciudad', icon: Icon(FontAwesomeIcons.city,color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black)),
                            
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
                        controller: _PaisController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Pais';
                          } else
                            return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Pais',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
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