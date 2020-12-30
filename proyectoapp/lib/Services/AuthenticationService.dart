import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectoapp/DatabaseManager/DatabaseManager.dart';

class AuthenticationService{
  final FirebaseAuth _auth = FirebaseAuth.instance;


//registro con correo y contraseña

Future createNewUser(String nombre,String email, String password,String ciudad) async {
  try{
    UserCredential result =  await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    User user = result.user;
    await DatabaseManager().createUserData(nombre,user.uid,ciudad,'','','https://s1.eestatic.com/2015/03/31/cocinillas/Cocinillas_22257914_116018278_1024x576.jpg');
    return user;
  }catch(e){
    print(e.toString());
  }
}

//login 
Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
    }
  }

//desloguearse
 Future cerrarSesion() async {
    try {
      return _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  } 
  Future <String> getCurrentUID() async{
    return ( _auth.currentUser).uid;
  } 

}