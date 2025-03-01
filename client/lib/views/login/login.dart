import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  // Función simulada para iniciar sesión con Google y verificar registro
  Future<void> signInWithGoogleAndNavigate(BuildContext context) async {
    // Simula una demora de inicio de sesión (por ejemplo, 1 segundo)
    await Future.delayed(const Duration(seconds: 1));

    // Obtén SharedPreferences para revisar si el usuario ya está registrado.
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool('isRegistered') ?? false;

    if (isRegistered) {
      // Si ya está registrado, obtenemos también el rol (isCentro)
      bool isCentro = prefs.getBool('isCentro') ?? false;
      // Navega directamente al Home pasando el rol.
      Navigator.pushReplacementNamed(context, '/home', arguments: isCentro);
    } else {
      // Si no está registrado, se navega a la página de selección de rol.
      Navigator.pushReplacementNamed(context, '/rol');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCC6D7F),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signInWithGoogleAndNavigate(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: const StadiumBorder(),
            minimumSize: const Size(200, 60),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Asegúrate de tener la imagen en assets/icons/image.png
              Image.asset('assets/icons/image.png', width: 24, height: 24),
              const SizedBox(width: 10),
              const Text(
                'Iniciar sesión con Google',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}