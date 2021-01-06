/* en el modelo de la receta se ocupara para poder recuperar los datos dentro del inicio 
y  nos da la posibilidad de poder  manejar los datos dentro de la bd. */
class Receta {
  Receta(
      {this.uid,
      this.recetas,
      this.image,
      this.nombre,
      this.ingredientes,
      this.categoria});

  String uid;
  String recetas;
  String image;
  String nombre;
  String ingredientes;
  String categoria;
}
