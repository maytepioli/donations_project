import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xFF9D4EDD);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileImageUrl = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  int donationsCount = 5;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        profileImageUrl = user.photoURL ?? '';
        _nameController.text = user.displayName ?? 'Juan Pérez';
      });
    }
  }

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
            _buildDonationCard(),
            const SizedBox(height: 20),
            _buildInfoCard(),
            const SizedBox(height: 40),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 70,
      backgroundColor: Colors.white,
      child: profileImageUrl.isEmpty
          ? Icon(Icons.person, size: 70, color: myColor)
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

  Widget _buildDonationCard() {
    return Card(
      color: myColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Donaciones',
              style: GoogleFonts.amaticSc(color: Colors.white, fontSize: 20),
            ),
            Text(
              '$donationsCount',
              style: GoogleFonts.amaticSc(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildReadOnlyField(label: 'Nombre', controller: _nameController),
            const SizedBox(height: 16),
            _buildReadOnlyField(label: 'Teléfono', controller: _phoneController),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyField({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.amaticSc(fontSize: 20, fontWeight: FontWeight.normal),
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
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        print('Guardar cambios');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor,
        minimumSize: const Size.fromHeight(50),
      ),
      child: Text(
        'Guardar cambios',
        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
