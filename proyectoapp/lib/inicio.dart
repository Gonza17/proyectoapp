import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectoapp/model/recetas.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  String userID = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    User getUser = FirebaseAuth.instance.currentUser;
    userID = getUser.uid;
    userEmail = getUser.email;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: StreamBuilder(
        stream: Firestore.instance.collection("recetas").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("loading....");
          } else {
            if (snapshot.data.documents.length == 0) {
            } else {
              return Container(
                child: ListView(
                  children: snapshot.data.documents.map((document) {
                    return Row(
                      children: <Widget>[
                        new Container(
                          padding:
                              EdgeInsets.only(top: 2.0, left: 2.0, right: 2.0),
                          child: ClipRRect(
                            //recondea borde Foto dentro del Stack
                            borderRadius: BorderRadius.circular(10.0),
                            child: InkWell(
                              onTap: () {
                                Recetas receta = Recetas(
                                  nombre: document['nombre'].toString(),
                                  image: document['image'].toString(),
                                  recetas: document['recetas'].toString(),
                                  ingredientes:
                                      document['ingredientes'].toString(),
                                );
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => VerReceta(
                                //             recipe: recipe,
                                //             idRecipe:
                                //                 document.documentID,
                                //             uid: userID)));
                              },
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FadeInImage(
                                        fit: BoxFit.cover,
                                        width: 380,
                                        height: 220,
                                        placeholder: AssetImage(
                                            'assets/images/azucar.gif'),
                                        image: NetworkImage(document["image"]),
                                      ),
                                    ),
                                  ),
                                  //borde para poner el la foto estrellas y titulo ...
                                  Positioned(
                                    left: 10.0,
                                    bottom: 10.0,
                                    child: Container(
                                      height: 40.0,
                                      width: 325.0,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              colors: [
                                            Colors.black,
                                            Colors.black12
                                          ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter)),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20.0,
                                    right: 10.0,
                                    bottom: 10.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              document["nombre"].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ), //
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
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
