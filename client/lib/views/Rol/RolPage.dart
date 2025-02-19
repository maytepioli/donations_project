import 'package:flutter/material.dart';
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
        // Aquí también podrías definir otras rutas si lo deseas.
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
              child: const Text("Entrar como Centro"),
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
              child: const Text("Entrar como Donador"),
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

  @override
  void dispose() {
    _centerNameController.dispose();
    _addressController.dispose();
    _websiteController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulario para Centros")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Se usa ListView para que el contenido sea desplazable.
        child: Form(
          key: _formKey,
          child: ListView(
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
                // Este campo es opcional
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navega a Home pasando isCentro: true.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(isCentro: true),
                      ),
                    );
                  }
                },
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Formulario para Donadores:
/// Pide únicamente el número de celular.
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Navega a Home pasando isCentro: false.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(isCentro: false),
                      ),
                    );
                  }
                },
                child: const Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
