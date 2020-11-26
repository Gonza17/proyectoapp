import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: HomePage(),
  )
);
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
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
                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
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
                    child: Column(
                      children: <Widget> [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[100]))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Correo",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                          )
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              hintStyle: TextStyle(color: Colors.grey[400])
                            ),
                          )
                        )
                      ],
                    )
                  ),
                  SizedBox(height: 30,),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors:[
                          Color.fromRGBO(255, 114, 21, 1),
                          Color.fromRGBO(218, 122, 59, 1)
                        ]
                      )
                    ),
                    child: Center(
                      child:Text("Login",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)) ,
                    )
                  ),
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