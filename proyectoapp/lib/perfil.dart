
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';


class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}
class _PerfilState extends State<Perfil> {
  String userID = "";
  String userEmail = "";
  String _itemCiudad;

  String nombre_user = "";
  String ciudad_user = "";
  String descripcion_user= "";
  List<DropdownMenuItem<String>> _ciudadItems;
  //final AuthenticationService _auth = AuthenticationService();
  
  @override

  void initState() {
    super.initState();
    fetchUserInfo();
    //getUsuarioItems();
  }
  fetchUserInfo() async {
    User getUser =  FirebaseAuth.instance.currentUser;    
    userID = getUser.uid;// ID DE LA PERSONA AUTENTIFICADA
    userEmail = getUser.email;
    DocumentSnapshot usuario_actual = await FirebaseFirestore.instance.collection('info_usuario').doc(userID).get();//informacion de la persona autentificada
    nombre_user = usuario_actual['nombre'];
    ciudad_user = usuario_actual['ciudad'];
    descripcion_user = usuario_actual['descripcion'];
  }
/*
  getData() async {
    return await FirebaseFirestore.instance.collection('info_usuario').get();
  }

  //Dropdownlist from firestore
   List<DropdownMenuItem<String>> getUsuarioItems() {
    QuerySnapshot dataUsuario;
    getData().then((data) {
      
      dataUsuario = data;
      //print(dataCiudades.docs[0]['nombre']);
      dataUsuario.docs.forEach((obj) {
        if((obj.id)==userID){
          
          nombre_user = obj['nombre'];
          ciudad_user = obj['ciudad'];
          descripcion_user = obj['descripcion'];
          //print('Usuario encontrado!!! $nombre_user $ciudad_user'); 
        }
      });
    }).catchError((error) => print('hay un error.....' + error));
  }
  */
  @override 
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
         child:

        Column(
          
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://s1.eestatic.com/2015/03/31/cocinillas/Cocinillas_22257914_116018278_1024x576.jpg"
                  ),
                  fit: BoxFit.cover
                )
              ),
            child: Container(
              width: double.infinity,
              height: 200,
              child: Container(
                alignment: Alignment(0.0,2.5),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://st2.depositphotos.com/1341440/7182/v/950/depositphotos_71824861-stock-illustration-chef-hat-vector-black-silhouette.jpg "
                  ),
                  radius: 60.0,
                ),
              ),
            ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              nombre_user,
              style: TextStyle(
                fontSize: 25.0,
                color:Colors.blueGrey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w400
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ciudad_user
              ,style: TextStyle(
                fontSize: 18.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              descripcion_user
              ,style: TextStyle(
                fontSize: 15.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              elevation: 2.0,
              child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12,horizontal: 30),
                  child: Text("Texto",style: TextStyle(
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300
                  ),))
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Texto || Texto"
              ,style: TextStyle(
                fontSize: 18.0,
                color:Colors.black45,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w300
            ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text("Recetas",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text("15",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                      Column(
                        children: [
                          Text("Seguidores",
                            style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600
                            ),),
                          SizedBox(
                            height: 7,
                          ),
                          Text("2000",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w300
                            ),)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: (){
                  },
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.pink,Colors.redAccent]
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                      alignment: Alignment.center,
                      child: Text(
                        "Contact me",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: (){
                  },
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.pink,Colors.redAccent]
                      ),
                      borderRadius: BorderRadius.circular(80.0),
                    ),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 100.0,maxHeight: 40.0,),
                      alignment: Alignment.center,
                      child: Text(
                        "Portfolio",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w300
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
         
      )
    );
  }
}
