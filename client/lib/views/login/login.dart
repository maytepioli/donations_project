import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoguinState createState() => LoguinState();
}

class LoguinState extends State<Login> {
  // Ahora se usan los colores que me pasaste, pero invertidos:
  // primaryColor: rosa (#CC6D7F) para elementos principales (botones, textos destacados)
  // secondaryColor: verde (#D4E7D2) para detalles (bordes, íconos, etc.)
  final Color primaryColor = const Color(0xFFCC6D7F);
  final Color secondaryColor = const Color(0xFFD4E7D2);

  late Size mediaSize;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        // Gradiente de fondo: de rosa a verde
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        // Si deseas usar una imagen de fondo, puedes descomentar lo siguiente:
        /*
        image: DecorationImage(
          image: AssetImage("assets/images/dec3be.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(primaryColor.withAlpha(70), BlendMode.dstATop),
        ),
        */
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: _buildTop(mediaSize),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottom(mediaSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTop(Size mediaSize) {
    return SizedBox(
      width: mediaSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Nombre de la app en la parte superior
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'HopeBox',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  letterSpacing: 2.0,
                ),
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
