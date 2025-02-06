import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoguinState createState() => LoguinState();
}

class LoguinState extends State<Login> {
  late Color myColor;
  late Size mediaSize;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = Color(0xFFDEC3BE);

    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: AssetImage("assets/images/dec3be.png"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(myColor.withAlpha(70), BlendMode.dstATop),
        ),
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
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                'HopeBox',
                style: TextStyle(
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
          Text(
            'Bienvenido',
            style: TextStyle(
              color: myColor,
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
          _buildRegisterBotoon(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller,
      {isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : null,
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/home');
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: myColor,
        foregroundColor: Colors.white,
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: Text('Iniciar Sesión'),
    );
  }

  Widget _buildGoogleButton() {
    return ElevatedButton(
      onPressed: () {
        // Acción para iniciar sesión con Google
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 20,
        shadowColor: myColor,
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

  Widget _buildRegisterBotoon() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: myColor,
        foregroundColor: Color.fromARGB(255, 245, 245, 245),
        elevation: 20,
        shadowColor: myColor,
        minimumSize: const Size.fromHeight(60),
      ),
      child: Text('Registrarse'),
    );
  }
}
