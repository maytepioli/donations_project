import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application/views/home/home.dart';
import 'package:google_fonts/google_fonts.dart';

/// Definición de myColor: #ea638c
const Color myColor = Color(0xFF9D4EDD);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flujo de Roles y Formularios',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionPage(),
      },
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Selecciona tu Rol",
          style: GoogleFonts.amaticSc(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tarjeta para ingresar como Centro
                Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CenterFormPage(),
                        ),
                      );
                    },
                    child: Ink.image(
                      image: const AssetImage('assets/images/centro.jpg'),
                      height: 200,
                      fit: BoxFit.cover,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Text(
                          "Entrar como Centro",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Tarjeta para ingresar como Donador
                Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DonorFormPage(),
                        ),
                      );
                    },
                    child: Ink.image(
                      image: const AssetImage('assets/images/donador.jpg'),
                      height: 200,
                      fit: BoxFit.cover,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Text(
                          "Entrar como Donador",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Formulario para Centros:
/// - Sin AppBar.
/// - Contenedor del formulario centrado y con ancho limitado.
/// - "HOPE BOX" en Amatic Sc (título) y el resto de los textos en Poppins.
class CenterFormPage extends StatefulWidget {
  const CenterFormPage({super.key});

  @override
  State<CenterFormPage> createState() => _CenterFormPageState();
}

class _CenterFormPageState extends State<CenterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _centerNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _centerNameController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _registrarCentro() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(isCentro: true),
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con foto de centro
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/centro.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Desenfoque
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
          // Contenedor del formulario
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'HOPEBOX',
                        style: GoogleFonts.amaticSc(
                          textStyle: const TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: myColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Estás a un paso de crear tu cuenta como Centro para poder recibir donaciones',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _centerNameController,
                        decoration: _buildInputDecoration('Nombre del Centro'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el nombre del centro';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _cityController,
                        decoration: _buildInputDecoration('Ciudad'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa la ciudad';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: _buildInputDecoration('Dirección'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa la dirección';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _websiteController,
                        decoration:
                            _buildInputDecoration('Página web (opcional)'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _phoneController,
                        decoration: _buildInputDecoration('Celular'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa el número de celular';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _registrarCentro,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size(200, 50),
                        ),
                        child: Text(
                          "Registrar Centro",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Botón de regreso
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Formulario para Donadores:
/// - Sin AppBar.
/// - Contenedor del formulario centrado y con ancho limitado.
/// - "HOPE BOX" en Amatic Sc y el resto de los textos en Poppins.
class DonorFormPage extends StatefulWidget {
  const DonorFormPage({super.key});

  @override
  State<DonorFormPage> createState() => _DonorFormPageState();
}

class _DonorFormPageState extends State<DonorFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _submitDonor() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(isCentro: false),
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo con foto de donador
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/donador.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Desenfoque incrementado
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
            child: Container(color: Colors.black.withOpacity(0)),
          ),
          // Contenedor del formulario
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'HOPE BOX',
                        style: GoogleFonts.amaticSc(
                          textStyle: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w400,
                            color: myColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Estás a un paso de poder donar',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: _phoneController,
                        decoration: _buildInputDecoration('Número de Celular'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu número de celular';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitDonor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          minimumSize: const Size(180, 50),
                        ),
                        child: Text(
                          "Enviar",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Botón de regreso
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 8,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
