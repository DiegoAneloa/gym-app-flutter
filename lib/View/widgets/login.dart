import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_app/Models/user_model.dart';
import 'package:gym_app/View/widgets/actividades.dart';

class AppColors {
  // Colores base — ahora fondo CLARO, no oscuro
  static const rojo = Color(0xFFFF6B35);          // naranja quemado (antes rojo)
  static const blanco = Color(0xFFFFF8E7);        // crema, no blanco puro
  static const negro = Color(0xFF1B3A4B);         // azul petróleo oscuro (reemplaza al negro)
  static const gris = Color(0xFF8B8272);          // gris cálido/arena
  static const tarjetaFondo = Color(0xFFFFFFFF);  // tarjetas blancas puras sobre fondo crema
  static const campoFondo = Color(0xFFF0EBDC);    // inputs en tono arena claro

  // Variantes del color principal (naranja)
  static const rojoOscuro = Color(0xFFCC4A1F);
  static const rojoClaro = Color(0xFFFF9466);

  // Textos secundarios
  static const textoSecundario = Color(0xFF6B6459);
  static const textoDeshabilitado = Color(0xFFC4BCA8);

  // Bordes / divisores
  static const borde = Color(0xFFE0D6BE);
  static const divisor = Color(0xFFEDE4D0);

  // Estados semánticos
  static const exito = Color(0xFF2A9D8F);   // verde azulado (teal)
  static const advertencia = Color(0xFFF4A300);
  static const error = Color(0xFFE63946);

  // Sombras / overlays
  static const sombra = Color(0x1A1B3A4B);
  static const overlay = Color(0x991B3A4B);

  // Acento secundario
  static const acento = Color(0xFF2A9D8F); // teal, contraste fuerte con el naranja
}

class _CampoLogin extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;

  const _CampoLogin({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.blanco.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.blanco.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: GoogleFonts.roboto(color: AppColors.blanco),
        cursorColor: AppColors.rojo,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.gris),
          hintText: hint,
          hintStyle: GoogleFonts.roboto(color: AppColors.gris),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> {
  final List<UserModel> usuarios=[
    UserModel(usuario: 'd', clave: '1'),
  ];


  final TextEditingController _usuariocontroller = TextEditingController();
  final TextEditingController _clavecontroller = TextEditingController();

  void validacion() {
    final usuarioingresado = _usuariocontroller.text.trim();
    final claveingresada = _clavecontroller.text.trim();
    if (usuarioingresado.isEmpty || claveingresada.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('FALTA CAMPOS DE LLENAR')));
      return;
    }
    final usuarioEncontrado = usuarios.firstWhere(
    (u) => u.usuario == usuarioingresado && u.clave == claveingresada,
    orElse: () => UserModel(usuario: '', clave: ''), // "usuario vacío" si no encuentra
  );

  if (usuarioEncontrado.usuario.isNotEmpty) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Actividades(usuario: usuarioEncontrado),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('LOS CAMPOS SON INCORRECTOS')),
      );
    }
  }

  @override
  void dispose() {
    _usuariocontroller.dispose();
    _clavecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.negro,
      body: Stack(
        children: [
          // ---------------- IMAGEN DE FONDO (toda la pantalla) ----------------
          Positioned.fill(
            child: Image.asset(
              'assets/images/fondogym.jpg', 
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(color: AppColors.negro);
              },
            ),
          ),
          // ---------------- OSCURECEDOR (para que el texto se lea) ----------------
          Positioned.fill(
            child: Container(color: AppColors.negro.withValues(alpha: 0.65)),
          ),
          // ---------------- CONTENIDO ----------------
          SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.08,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // LOGO 
                          /*Image.asset(
                            'assets/images/logo.png',
                            height: size.height * 0.18,
                            errorBuilder: (context, error, stackTrace) {
                              // Placeholder mientras no tengas el logo cargado
                              return Icon(
                                Icons.shield_outlined,
                                size: size.height * 0.15,
                                color: AppColors.rojo,
                              );
                            },
                          ),
                          const SizedBox(height: 12),*/

                          // ---------------- EL NOMBRE NO TE OLVIDARAS ----------------
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: GoogleFonts.montserrat(
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'PRIMITIVO',
                                  style: TextStyle(color: AppColors.rojo),
                                ),
                                TextSpan(
                                  text: 'GYM',
                                  style: TextStyle(color: AppColors.blanco),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),

                          // ---------------- TEXTO EN CURSIVA ----------------
                          Text(
                            'Forja tu fuerza sin excusas',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dancingScript(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blanco,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // ---------------- CAMPO USUARIO ----------------
                          _CampoLogin(
                            controller: _usuariocontroller,
                            hint: 'Usuario',
                            icon: Icons.person_outline,
                          ),
                          const SizedBox(height: 16),

                          // ---------------- CAMPO CONTRASEÑA ----------------
                          _CampoLogin(
                            controller: _clavecontroller,
                            hint: 'Código',
                            icon: Icons.lock_outline,
                            obscure: true,
                          ),
                          const SizedBox(height: 28),

                          // ---------------- BOTÓN ----------------
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.rojo,
                                foregroundColor: AppColors.blanco,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              onPressed: validacion,
                              child: Text(
                                'INGRESAR ',
                                style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------
// Widget reutilizable para los campos de texto con el estilo oscuro
// -----------------------------------------------------------------------
