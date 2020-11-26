import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyectoapp/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class Registro extends StatelessWidget {
  final TextEditingController nombre = new TextEditingController();
  final TextEditingController correo = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController edad = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("usuarios");
    void registrar() async {
      await FirebaseFirestore.instance.collection("Usuarios").add({"nombre":nombre.text, "correo":correo.text,"contraseña":password.text,"edad":edad.text}).then((value) => print(value.id));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background4.png'),
                  fit: BoxFit.fill
                )
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top:50),
                      child: Center(
                        child: Text("Registro de usuario", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                      )
                    )
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child:Column(
                children: <Widget>[
                  Container(
                    
                    child: Column(
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(239, 127, 26, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                              )
                            ]
                          ),
                          child: new TextField(
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: "Nombre",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                            controller: nombre,
                          )
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(239, 127, 26, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                              )
                            ]
                          ),
                          child: new TextField(
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: "Correo",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                            controller: correo,
                          )
                        ),
                        /*Container(  
                          child: new RaisedButton(
                            child: new Text("ingresar",style: new TextStyle(color: Colors.white),),
                            color: Colors.deepPurple,
                            onPressed:ingresar,
                          )
                        ),*/
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(239, 127, 26, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                              )
                            ]
                          ),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                            controller: password,
                          )
                        ),
                        SizedBox(height: 10,),
                        Container(
                         padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(239, 127, 26, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                              )
                            ]
                          ),
                          child: new TextField(
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintText: "Edad",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                            keyboardType: TextInputType.number,
                            controller: edad,
                          )
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 50,
                    /*decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(255, 114, 21, 1),
                          Color.fromRGBO(255, 114, 21, 1)
                        ]
                      )
                    ),*/
                    child: Center(
                      
                      child: RaisedButton(
                        child:Text("Registrar",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)) ,
                        onPressed: registrar,/*(){
                          Navigator.pushNamed(context, '/home');
                        },*/
                         shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Color.fromRGBO(255, 114, 21, 1))
                        ),
                        padding: EdgeInsets.all(10.0),
                        
                        color: Color.fromRGBO(255, 114, 21, 1),
                      ),
                      
                    )
                  ),
                  /*Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: query.snapshots(),
                      builder: (context, stream){
                        if(stream.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }

                        if(stream.hasError){
                          return Center(child: Text(stream.error.toString()));
                        }
                        QuerySnapshot querySnapshot = stream.data;
                        return ListView(
                          children: <Widget>[
                            for(var Docs in querySnapshot.docs) ListTile(title: new Text(Docs.data()['correo']),)
                          ]
                        );
                      },
                    )
                  ),*/
                  SizedBox(height: 50,),
                  Text("Registrarse", style: TextStyle(color: Color.fromRGBO(218, 122, 59, 1), fontWeight: FontWeight.bold)) 
                ],
              )
            )
          ]
        )
      ),
    );
  }
}