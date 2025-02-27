import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xFF9D4EDD);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  // Controladores (campos no editables)
  final TextEditingController _nameController =
      TextEditingController(text: 'Juan Pérez');
  final TextEditingController _phoneController =
      TextEditingController(text: '+1 555 123 4567');

  // URL de imagen de perfil (si está vacía se muestra un ícono)
  String profileImageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: GoogleFonts.amaticSc(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfilePicture(),
            const SizedBox(height: 20),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  // Construye la foto de perfil
  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.white,
      child: profileImageUrl.isEmpty
          ? Icon(
              Icons.person,
              size: 70,
              color: myColor,
            )
          : ClipOval(
              child: Image.network(
                profileImageUrl,
                fit: BoxFit.cover,
                width: 140,
                height: 140,
              ),
            ),
    );
  }

  // Tarjeta que muestra Nombre y Teléfono
  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyField(
              label: 'Nombre',
              controller: _nameController,
            ),
            const SizedBox(height: 16),
            _buildReadOnlyField(
              label: 'Teléfono',
              controller: _phoneController,
            ),
          ],
        ),
      ),
    );
  }

  // Campo de texto de solo lectura
  Widget _buildReadOnlyField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.amaticSc(
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          readOnly: true,
          style: GoogleFonts.poppins(fontWeight: FontWeight.normal),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ],
    );
  }
}
