import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:proyectoapp/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _key = GlobalKey<FormState>();
  final AuthenticationService _auth = AuthenticationService();
  String _itemCiudad;
  String _itemPais;
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailContoller = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  List<DropdownMenuItem<String>> _ciudadItems;
  List<DropdownMenuItem<String>> _paisItems;
  @override
  void initState() {
    super.initState();
    setState(() {
      _ciudadItems = getCiudadItems();
      _itemCiudad = _ciudadItems[0].value;
      _paisItems = getPaisItems();
      _itemPais = _paisItems[0].value;
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

  getDataPais() async {
    return await FirebaseFirestore.instance.collection('paises').get();
  }
  List<DropdownMenuItem<String>> getPaisItems() {
    List<DropdownMenuItem<String>> items = List();
    QuerySnapshot dataPaises;
    getDataPais().then((data) {
      
      dataPaises = data;
      dataPaises.docs.forEach((obj) {
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
    Query query = FirebaseFirestore.instance.collection("Usuarios");
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
                       DropdownButtonFormField(
                        
                        validator: (value) =>
                        value == '0' ? 'Debe seleccionar un pais' : null,
                        decoration: InputDecoration(
                            labelText: 'Pais', icon: Icon(FontAwesomeIcons.globeAmericas,color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white)),
                            
                        value: _itemPais,
                        items: _paisItems,
                        onChanged: (value) {
                          setState(() {
                            _itemPais = value;
                          });
                        }, //seleccionarCiudadItem,
                        
                        onSaved: (value) => _itemPais = value,
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
  void registrar() async{
    dynamic result = await _auth.createNewUser(_nombreController.text,_emailContoller.text,_passwordController.text,_itemCiudad,_itemPais);
    if(result==null){
      print('email no es valido');
    }else{
      print(result.toString());
      _nombreController.clear();
      _emailContoller.clear();
      _passwordController.clear();
      Navigator.pop(context);
    }
  }
}