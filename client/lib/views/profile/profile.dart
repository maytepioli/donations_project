import 'package:flutter/material.dart';

const Color myColor = Color(0xFFDEC3BE);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Si se obtiene la foto del usuario (por ejemplo, de Google), se asigna a esta variable;
  // de lo contrario, se usa una imagen por defecto.
  String profileImageUrl = '';
  final TextEditingController _nameController =
      TextEditingController(text: 'Juan Pérez');
  final TextEditingController _phoneController = TextEditingController();
  int donationsCount = 5; // Ejemplo de cantidad de donaciones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              print('Configuración');
              Navigator.pushNamed(context, '/configuration');
            },
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // La foto de perfil permanece fuera del Card.
            _buildProfilePicture(),
            const SizedBox(height: 24),
            // La tarjeta de donaciones también queda por fuera.
            _buildDonationCard(),
            const SizedBox(height: 24),
            // Se agrupan los campos editables y el botón dentro de un Card.
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildNameField(),
                    const SizedBox(height: 16),
                    _buildPhoneField(),
                    const SizedBox(height: 40),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para la foto de perfil.
  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: myColor,
      child: profileImageUrl.isEmpty
          ? const Icon(Icons.person, size: 50, color: Colors.white)
          : ClipOval(child: Image.network(profileImageUrl, fit: BoxFit.cover)),
    );
  }

  // Widget para la tarjeta de donaciones.
  Widget _buildDonationCard() {
    return Card(
      color: myColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Donaciones',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Text(
              '$donationsCount',
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para el campo del nombre.
  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
    );
  }

  // Widget para el campo del teléfono.
  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Teléfono',
        border: OutlineInputBorder(),
      ),
    );
  }

  // Widget para el botón de guardar cambios.
  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        // Aquí puedes agregar la lógica para guardar los cambios.
        print('Guardar cambios');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: const Text('Guardar cambios'),
    );
  }
}
