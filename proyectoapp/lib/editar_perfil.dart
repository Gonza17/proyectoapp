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
  TextEditingController _descripcionController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _PaisController = TextEditingController();
  TextEditingController _ciudadController = TextEditingController();

  File _foto;
  String urlFoto="";
  String userID = "";
  String userEmail = "";
  String _itemCiudad;
  String _itemPais;
  dynamic usuario;

  List<DropdownMenuItem<String>> _ciudadItems;
  List<DropdownMenuItem<String>> _paisItems;
  //DocumentSnapshot usuario_actual;
  @override
  void initState() {
    super.initState();
     
      User getUser = FirebaseAuth.instance.currentUser;
      userID = getUser.uid; // ID DE LA PERSONA AUTENTIFICADA
      userEmail = getUser.email;
      fetchUserInfo() ;
      //ciudad_usuario=usuario.ciudad;
      
  }
  
  Future CaptureImagen(SelectSource opcion) async {
    File image;

    opcion == SelectSource.camara
        ? image = await ImagePicker.pickImage(source: ImageSource.camera)
        : image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _foto = image;
    });
  }

  Future getImagen() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione donde desea capturar la imagen'),
      title: Text('seleccione imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            CaptureImagen(SelectSource.camara);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Camara'), Icon(Icons.camera)],
          ),
        ),
        FlatButton(
          onPressed: () {
            CaptureImagen(SelectSource.galeria);
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Row(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    showDialog(context: context, child: alerta);
    
  }
  cambiar_imagen() async {

    if (_foto != null) {
        final _storage = FirebaseStorage.instance;
        var numero_random = new Random().nextInt(100000);
        var fireStoreRef = await _storage
            .ref()
            .child('usuario')
            .child(userID)
            .child('perfil')
            .child('$numero_random.jpg')
            .putFile(_foto);

        var downloadUrl = await fireStoreRef.ref.getDownloadURL();
        urlFoto = downloadUrl;
        print(numero_random);
        print(urlFoto);
        updateDatos();
      }
      else{
        updateDatos();
      }
  }

  Future updateDatos() async {
  CollectionReference perfil_usuario = FirebaseFirestore.instance.collection('info_usuario');
  if(_itemCiudad=='0'){
    _itemCiudad=usuario.ciudad;
  }
  if(_itemPais=='0'){
    _itemCiudad=usuario.pais;
  }
   if (_foto != null) {
     return await perfil_usuario.doc(userID).update({
       'nombre' :_nombreController.text,
       'ciudad' : _itemCiudad,
       'pais' : _itemPais,
       'descripcion':_descripcionController.text,
       'imagen_perfil': urlFoto,
       
      });
   }else{
      return await perfil_usuario.doc(userID).update({
        'nombre' :_nombreController.text,
        'ciudad' : _itemCiudad,
        'pais' : _itemPais,
        'descripcion':_descripcionController.text,
        'imagen_perfil': usuario.imagen_perfil,
      });
   }
      
  }
  fetchUserInfo() async {
     usuario =  await DatabaseManager().getInfoUsuario(userID);
      _nombreController.text=usuario.nombre;
      _descripcionController.text=usuario.descripcion;
     _ciudadItems = getCiudadItems();
      _itemCiudad = _ciudadItems[0].value;
      _paisItems = getPaisItems();
      _itemPais = _paisItems[0].value;
    
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
      child: Text('${usuario.ciudad}', style: TextStyle(color: Colors.black),) ,
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
      child: Text('${usuario.pais}', style: TextStyle(color: Colors.black),) ,
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
                  'Editar datos',
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
                RaisedButton(
                  child: Text("Cambiar imagen",
                      style: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w300)),
                  color: Colors.white,
                  onPressed: () {
                    getImagen();
                    
                    }
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  
                  child: Column(
                    children: [
                     
                      TextFormField(
                        
                        controller: _nombreController,
                        decoration: InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                        style: TextStyle(color: Colors.black),
                      ),
                      
                      SizedBox(height: 30),
                      TextFormField(
                        
                        controller: _descripcionController,
                        decoration: InputDecoration(
                            labelText: 'Descripcion',
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
                      DropdownButtonFormField(
                        
                        validator: (value) =>
                        value == '0' ? 'Debe seleccionar un pais' : null,
                        decoration: InputDecoration(
                            labelText: 'Pais', icon: Icon(FontAwesomeIcons.globeAmericas,color: Colors.black),
                            labelStyle: TextStyle(color: Colors.black)),
                            
                        value: _itemPais,
                        items: _paisItems,
                        onChanged: (value) {
                          setState(() {
                            _itemPais = value;
                          });
                        }, //seleccionarCiudadItem,
                        
                        onSaved: (value) => _itemPais = value,
                      ),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            textTheme: ButtonTextTheme.accent ,
                            child: Text('Guardar cambios',style: TextStyle(color: Colors.white,)),
                            onPressed: () {
                              cambiar_imagen();
                              
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