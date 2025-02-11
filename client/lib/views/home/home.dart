import 'package:flutter/material.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Home',
      currentPage: 0,
      onBottomNavTap: (index) {
        // Define la navegación según el índice seleccionado en la barra inferior
        if (index == 0) {
          Navigator.pushNamed(context, '/');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/object');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/map');
        }
      },
      // Contenido de la pantalla Home
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildButton(context, 'Login', '/login'),
              const SizedBox(height: 16),
              buildButton(context, 'Register', '/register'),
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
      ),
    );
  }
}

// Widget auxiliar para crear los botones
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
