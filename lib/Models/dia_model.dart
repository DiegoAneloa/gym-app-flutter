import 'package:gym_app/Models/actividades_model.dart';

class DiaModel {
  String nombre;
  List<ActividadesModel> actividades;
  bool completado;   // ← nuevo campo

  DiaModel({
    required this.nombre,
    required this.actividades,
    this.completado = false,   // por defecto, ningún día está completado
  });
}