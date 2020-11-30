import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


//registro con correo y contraseña

Future createNewUser(String email, String password) async {
  try{
    UserCredential result =  await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
    User user = result.user;
    return user;
  }catch(e){
    print(e.toString());
  }
}

//login 


//desloguearse
}