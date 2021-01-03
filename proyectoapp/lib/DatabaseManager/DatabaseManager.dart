import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectoapp/model/user_model.dart';

class DatabaseManager {
  final CollectionReference profileList = FirebaseFirestore.instance.collection('info_usuario');
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
  
  Future getUsersList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getInfoUsuario(String uid) async{
    DocumentSnapshot usuario_actual = await FirebaseFirestore.instance
        .collection('info_usuario')
        .doc(uid)
        .get();
        Usuario usuario = Usuario(
          nombre: usuario_actual['nombre'],
          ciudad: usuario_actual['ciudad'],
          descripcion: usuario_actual['descripcion'],
          imagen_perfil :usuario_actual['imagen_perfil'],     
        );
        return usuario;
        
  } 


  
}