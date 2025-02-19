import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
        ],
      ),
    );
  }

    Widget _buildGoogleButton() {
    return ElevatedButton(
      onPressed: () {
        // Acción para iniciar sesión con Google
        singInWithGoogle();
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 20,
        shadowColor: secondaryColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/icons/image.png', width: 24, height: 24),
          const SizedBox(width: 10),
          const Text('Iniciar sesión con Google'),
        ],
      ),
    );
  }

  Widget _buildBottom(Size mediaSize) {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título de bienvenida en rosa (color principal)
          Text(
            'Bienvenido',
            style: TextStyle(
              color: primaryColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildGreyText('Inicia sesión para continuar'),
          const SizedBox(height: 60),
          _buildGreyText('Correo electrónico'),
          _buildInputField(emailController),
          const SizedBox(height: 40),
          _buildGreyText('Contraseña'),
          _buildInputField(passwordController, isPassword: true),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 20),
          _buildGoogleButton(),
          const SizedBox(height: 20),
          // _buildRegisterButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        // Ícono para mostrar/ocultar contraseña (detalle en verde)
        suffixIcon: isPassword
            ? Icon(Icons.remove_red_eye, color: secondaryColor)
            : null,
        // Bordes personalizados:
        // - Borde habilitado en verde (secondaryColor)
        // - Borde enfocado en rosa (primaryColor)
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: secondaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/');
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 20,
        shadowColor: primaryColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text('Iniciar Sesión'),
    );
  }



  // Widget _buildRegisterButton() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.pushNamed(context, '/register');
  //     },
  //     style: ElevatedButton.styleFrom(
  //       shape: const StadiumBorder(),
  //       backgroundColor: primaryColor,
  //       foregroundColor: Colors.white,
  //       elevation: 20,
  //       shadowColor: primaryColor,
  //       minimumSize: const Size.fromHeight(60),
  //     ),
  //     child: const Text('Registrarse'),
  //   );
  // }
  singInWithGoogle() async {

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // ignore: avoid_print
    if (userCredential.user?.displayName == null){
      Navigator.pushNamed(context, '/');
      print("NADAAAAAAAAAAAAAAAAAAAAAAAAA");
    }
    else {
      Navigator.pushNamed(context, '/map');
      print(userCredential.user?.displayName);

    }
  } 
  
}
