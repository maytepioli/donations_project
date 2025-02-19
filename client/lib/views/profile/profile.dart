import 'package:flutter/material.dart';

const Color myColor = Color(0xFFDEC3BE);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String profileImageUrl = '';
  final TextEditingController _nameController =
      TextEditingController(text: 'Juan Pérez');
  final TextEditingController _phoneController = TextEditingController();
  int donationsCount = 5;

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
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfilePicture(),
            const SizedBox(height: 24),
            _buildDonationCard(),
            const SizedBox(height: 24),
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

  Widget _buildProfilePicture() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: myColor,
      child: profileImageUrl.isEmpty
          ? const Icon(Icons.person, size: 50, color: Colors.white)
          : ClipOval(child: Image.network(profileImageUrl, fit: BoxFit.cover)),
    );
  }

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

  Widget _buildNameField() {
    return TextFormField(
      controller: _nameController,
      decoration: const InputDecoration(
        labelText: 'Nombre',
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: _phoneController,
      decoration: const InputDecoration(
        labelText: 'Teléfono',
        border: OutlineInputBorder(),
      ),
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
      child: const Text('Guardar cambios'),
    );
  }
}
