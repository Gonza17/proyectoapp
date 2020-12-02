  
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';
import 'package:proyectoapp/Services/AuthenticationService.dart';
class TestUser extends StatefulWidget {
  @override
  _TestUserState createState() => _TestUserState();
}

class _TestUserState extends State<TestUser> {  
  final AuthenticationService _auth = AuthenticationService();

  List userProfilesList = [];

  String userID = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
    fetchDatabaseList();
  }

  fetchUserInfo() async {
    User getUser =  FirebaseAuth.instance.currentUser;
    userID = getUser.uid;
    userEmail = getUser.email;
  }

  fetchDatabaseList() async  {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          actions: [
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
        body: Container(
            child: ListView.builder(
                itemCount: userProfilesList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(userProfilesList[index]['nombre']),
                      //title: Text(userEmail),
                    ),
                  );
                })));
  }


}
