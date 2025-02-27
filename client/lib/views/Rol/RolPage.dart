import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application/views/home/home.dart';


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
        // Otras rutas pueden definirse aquí.
      },
    );
  }
}

/// Pantalla para seleccionar el rol: Centro o Donador.
class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Selecciona tu Rol")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navega al formulario para Centros.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CenterFormPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEC3BE),
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
                minimumSize: const Size(220, 70),
              ),
              child: const Text(
                "Entrar como Centro",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega al formulario para Donadores.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DonorFormPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDEC3BE),
                foregroundColor: Colors.black,
                shape: const StadiumBorder(),
                minimumSize: const Size(220, 70),
              ),
              child: const Text(
                "Entrar como Donador",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Formulario para Centros:
/// Pide: Nombre del centro, Dirección, Página web (opcional) y Celular.
class CenterFormPage extends StatefulWidget {
  const CenterFormPage({super.key});
  @override
  State<CenterFormPage> createState() => _CenterFormPageState();
}

class _CenterFormPageState extends State<CenterFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _centerNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _centerNameController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> saveCenterData() async {
    if (_formKey.currentState!.validate()) {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        String centerName = _centerNameController.text;
        String address = _addressController.text;
        String website = _websiteController.text;
        int phone = int.tryParse(_phoneController.text) ?? 0;

        // Save center data to Firestore
        await _firestore.collection('users').doc(uid).update({
          'isCentro': 2, // Mark as center
          'centerName': centerName,
          'address': address,
          'website': website,
          'telefono': phone,
        });

        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(isCentro: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario para Centros")),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _centerNameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Centro',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa el nombre del centro';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Dirección',
                      border: OutlineInputBorder(),
                    ),
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
                    decoration: const InputDecoration(
                      labelText: 'Página web (opcional)',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Celular',
                      border: OutlineInputBorder(),
                    ),
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
                    onPressed: saveCenterData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDEC3BE),
                      foregroundColor: Colors.black,
                      shape: const StadiumBorder(),
                      minimumSize: const Size(180, 50),
                    ),
                    child: const Text(
                      "Enviar",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class DonorFormPage extends StatefulWidget {
  const DonorFormPage({super.key});

  @override
  State<DonorFormPage> createState() => _DonorFormPageState();
}

class _DonorFormPageState extends State<DonorFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> saveDonorData() async {
    if (_formKey.currentState!.validate()) {
      User? user = _auth.currentUser;
      if (user != null) {
        String uid = user.uid;
        int telefono = int.tryParse(_phoneController.text) ?? 0;

        // Guardar en Firestore
        await _firestore.collection('users').doc(uid).update({
          'isCentro': 1, // Donador
          'telefono': telefono,
        });

        // Navegar a Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home(isCentro: 1)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ingresa tu Número de Celular")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Número de Celular',
                  border: OutlineInputBorder(),
                ),
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
                onPressed: saveDonorData,
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
