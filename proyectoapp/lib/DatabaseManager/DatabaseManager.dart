import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoapp/model/user_model.dart';

class DatabaseManager {
  final CollectionReference profileList = FirebaseFirestore.instance.collection('info_usuario');

  /* Ingresar datos del usuario en la base de datos */
  Future<void>createUserData(String nombre,String uid,String ciudad,String pais, String descripcion,String imagen_perfil) async{
    return await profileList.doc(uid).set({
      'nombre': nombre,
      'id_usuario': uid,
      'ciudad':ciudad,
      'pais': pais,
      'descripcion': descripcion,
      'imagen_perfil': imagen_perfil,
    });
  }
  
 /* Obtener informacion de un usuario pasandole la id */
  Future getInfoUsuario(String uid) async{
    DocumentSnapshot usuario_actual = await FirebaseFirestore.instance
        .collection('info_usuario')
        .doc(uid)
        .get();
        Usuario usuario = Usuario(
          nombre: usuario_actual['nombre'],
          ciudad: usuario_actual['ciudad'],
          pais: usuario_actual['pais'],
          descripcion: usuario_actual['descripcion'],
          imagen_perfil :usuario_actual['imagen_perfil'],     
        );
        return usuario;
        
  } 


  
}