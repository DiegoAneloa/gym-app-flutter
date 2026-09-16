import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:gym_app/Models/dia_model.dart';
import 'package:gym_app/Models/actividades_model.dart';

class AppColors {
  static const rojo = Color(0xFFFF6B35);          // naranja quemado (acento principal)
  static const blanco = Color(0xFFFFF8E7);        // crema, fondo general
  static const negro = Color(0xFF1B3A4B);         // azul petróleo oscuro (texto principal)
  static const gris = Color(0xFF8B8272);          // gris cálido/arena
  static const tarjetaFondo = Color(0xFFFFFFFF);  // tarjetas blancas puras
  static const campoFondo = Color(0xFFF0EBDC);    // inputs en tono arena claro

  static const rojoOscuro = Color(0xFFCC4A1F);
  static const rojoClaro = Color(0xFFFF9466);

  static const textoSecundario = Color(0xFF6B6459);
  static const textoDeshabilitado = Color(0xFFC4BCA8);

  static const borde = Color(0xFFE0D6BE);
  static const divisor = Color(0xFFEDE4D0);

  static const exito = Color(0xFF2A9D8F);
  static const advertencia = Color(0xFFF4A300);
  static const error = Color(0xFFE63946);

  static const sombra = Color(0x1A1B3A4B);
  static const overlay = Color(0x991B3A4B);

  static const acento = Color(0xFF2A9D8F);
}

class ActividadDetalle extends StatefulWidget {
  final DiaModel dia;
  const ActividadDetalle({super.key, required this.dia});

  @override
  State<ActividadDetalle> createState() => _ActividadDetalleState();
}

class _ActividadDetalleState extends State<ActividadDetalle> with WidgetsBindingObserver {
  ActividadesModel? _actividadPendiente;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _actividadPendiente != null) {
      setState(() {
        _actividadPendiente!.completada = true;
        _actividadPendiente = null;
      });
    }
  }

  double calcularProgreso() {
    if (widget.dia.actividades.isEmpty) return 0.0;
    final completadas = widget.dia.actividades
        .where((a) => a.completada)
        .length;
    return completadas / widget.dia.actividades.length;
  }

  Future<void> _abrirVideo(ActividadesModel actividad) async {
    _actividadPendiente = actividad;
    final url = Uri.parse(actividad.video);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blanco, // fondo crema, no azul petróleo
      appBar: AppBar(
        backgroundColor: AppColors.blanco,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.negro), // ícono de back visible sobre fondo claro
        title: Text(
          widget.dia.nombre,
          style: const TextStyle(
            color: AppColors.negro, // texto oscuro, visible sobre fondo crema
            fontFamily: 'montserrat',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 8),
              child: LinearProgressIndicator(
                value: calcularProgreso(),
                minHeight: 12,
                backgroundColor: AppColors.campoFondo, // en vez de Colors.grey[300]
                color: AppColors.rojo, // color de marca en vez de Colors.blue
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: widget.dia.actividades.length,
                itemBuilder: (context, index) {
                  final actividad = widget.dia.actividades[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.tarjetaFondo,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.borde, width: 1), // borde sutil, la tarjeta ya no "flota"
                    ),
                    child: ListTile(
                      title: Text(
                        actividad.nombre,
                        style: const TextStyle(
                          color: AppColors.negro, // texto oscuro, visible sobre tarjeta blanca
                          fontFamily: 'montserrat',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        actividad.descripcion,
                        style: const TextStyle(
                          color: AppColors.textoSecundario, // gris cálido, jerarquía clara
                          fontSize: 13,
                        ),
                      ),
                      trailing: CircleAvatar(
                        radius: 18,
                        backgroundColor: actividad.completada
                            ? AppColors.exito // color de la paleta en vez de Colors.green
                            : AppColors.rojo,
                        child: const Icon(
                          Icons.play_arrow, // se ajusta dinámicamente abajo
                          color: AppColors.blanco,
                          size: 20,
                        ),
                      ),
                      onTap: () => _abrirVideo(actividad),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}