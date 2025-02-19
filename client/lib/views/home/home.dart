import 'package:flutter/material.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  final bool isCentro; // true si el usuario es centro, false si es donador
  const Home({super.key, required this.isCentro});

  @override
  Widget build(BuildContext context) {
    // Definimos el estilo personalizado para el título (AppBar)
    final titleStyle = GoogleFonts.pacifico(
      textStyle: const TextStyle(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );

    // Para depuración:
    print('Construyendo Home. isCentro: $isCentro');

    if (isCentro) {
      // Para usuario centro:
      // Establecemos currentPage en 1 para que al entrar se preseleccione el ícono de notificaciones (no el de perfil).
      return BaseScreen(
        title: 'HopeBox',
        appBarTitleStyle: titleStyle, // Aplica el estilo solo al título
        currentPage: 1,
        showAppBarActions: false, // Oculta el drawer para centros
        bottomNavItems: const <Widget>[
          Icon(Icons.account_circle, size: 30, color: Colors.black), // Perfil
          Icon(Icons.notifications,
              size: 30, color: Colors.black), // Notificaciones
          Icon(Icons.card_giftcard,
              size: 30, color: Colors.black), // Donaciones
        ],
        onBottomNavTap: (index) {
          // Configuración para usuario centro:
          if (index == 0) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/notification');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/donations_Center');
          }
        },
        body: _buildCentralButtons(context),
      );
    } else {
      // Para usuario donador: se utiliza el diseño original
      return BaseScreen(
        title: 'HopeBox',
        appBarTitleStyle: titleStyle,
        currentPage: 0,
        // En este caso se asume que el drawer se muestra (por defecto en BaseScreen)
        onBottomNavTap: (index) {
          // Configuración para donador:
          if (index == 0) {
            Navigator.pushNamed(context, '/home'); // Se mantiene en Home
          } else if (index == 1) {
            Navigator.pushNamed(context, '/object');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
        body: _buildCentralButtons(context),
      );
    }
  }
}

// Función auxiliar para construir los botones centrales (se mantiene igual para ambos roles)
Widget _buildCentralButtons(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(context, 'Login', '/login'),
          const SizedBox(height: 16),
          buildButton(context, 'Register', '/register'),
          const SizedBox(height: 16),
          buildButton(context, 'Rol', '/rol'),
          const SizedBox(height: 16),
          buildButton(context, 'Donations', '/donations'),
          const SizedBox(height: 16),
          buildButton(context, 'Object', '/object'),
          const SizedBox(height: 16),
          buildButton(context, 'Profile', '/profile'),
          const SizedBox(height: 16),
          buildButton(context, 'Map', '/map'),
        ],
      ),
    ),
  );
}

// Widget auxiliar para crear los botones (se mantiene la tipografía predeterminada)
Widget buildButton(BuildContext context, String text, String routeName) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, routeName);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFDEC3BE),
      minimumSize: const Size(150, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
  );
}
