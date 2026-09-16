import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/Models/user_model.dart';
import 'package:gym_app/Models/dia_model.dart';
import 'package:gym_app/Service/datos_quemados.dart';
import 'package:gym_app/View/widgets/actividad_detalle.dart';

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

class Actividades extends StatefulWidget {
  final UserModel usuario;
  const Actividades({super.key, required this.usuario});

  @override
  State<Actividades> createState() => _ActividadesState();
}

class _ActividadesState extends State<Actividades> {
  final List<DiaModel> dias = diasQuemados;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blanco, // fondo crema, no el azul petróleo
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 100),
            _buildSaludo(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: dias.length,
                itemBuilder: (context, index) {
                  final dia = dias[index];
                  final esActivo = index == 0;
                  return _DiaCard(
                    nombre: dia.nombre,
                    activo: esActivo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActividadDetalle(dia: dia),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- SALUDO ----------------
  Widget _buildSaludo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'LISTO PARA TRABAJAR ',
            style: GoogleFonts.montserrat(
              color: AppColors.negro, // texto oscuro sobre fondo crema
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Esta es tu rutina:',
            style: GoogleFonts.roboto(
              color: AppColors.textoSecundario, // gris cálido, jerarquía visual
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------
// Tarjeta de cada día de la rutina
// -----------------------------------------------------------------------
class _DiaCard extends StatelessWidget {
  final String nombre;
  final bool activo;
  final VoidCallback onTap;

  const _DiaCard({
    required this.nombre,
    required this.activo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: activo ? AppColors.rojo : AppColors.tarjetaFondo, // corregido: ya no era el mismo color
        borderRadius: BorderRadius.circular(12),
        elevation: activo ? 0 : 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: activo
                  ? null
                  : Border.all(color: AppColors.borde, width: 1), // borde sutil en las inactivas
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: activo ? AppColors.blanco : AppColors.textoSecundario,
                  size: 20,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    nombre,
                    style: GoogleFonts.montserrat(
                      color: activo ? AppColors.blanco : AppColors.negro, // contraste correcto en ambos casos
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: activo ? AppColors.blanco : AppColors.textoSecundario,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}