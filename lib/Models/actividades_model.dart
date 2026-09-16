class ActividadesModel {
  String nombre;
  String descripcion;
  //String imagen;
  String video;
  bool completada; 

  ActividadesModel(
    {
      required this.nombre,
      required this.descripcion,
      //required this.imagen,
      required this.video,
      this.completada = false,
    }
  );
}