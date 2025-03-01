import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const Color myColor = Color(0xFF9D4EDD);

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  DonationsScreenState createState() => DonationsScreenState();
}

class DonationsScreenState extends State<DonationsScreen> {
  int _page = 1;
  String? donationType;
  String title = '';
  String description = '';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    donationType = ModalRoute.of(context)?.settings.arguments as String?;
    return BaseScreen(
      title: 'Donaciones - ${donationType ?? "No argumento"}',
      appBarBackgroundColor: Colors.white,
      appBarElevation: 10,
      appBarShadowColor: Colors.black.withOpacity(0.5),
      appBarSurfaceTintColor: Colors.transparent,
      appBarIconTheme: const IconThemeData(color: Colors.black),
      currentPage: _page,
      showAppBarActions: false,
      onBottomNavTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/');
        } else if (index == 1) {
          Navigator.pushNamed(context, '/object');
        } else if (index == 2) {
          Navigator.pushNamed(context, '/map');
        }
        setState(() {
          _page = index;
        });
      },
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleInput(_titleController),
            const SizedBox(height: 24),
            descriptionInput(_descriptionController),
            const SizedBox(height: 24),
            buildButtonContinue(),
          ],
        ),
      ),
    );
  }

  void saveData() async {
    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa todos los campos')),
      );
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, inicia sesión')),
      );
      return;
    }

    String userId = user.uid;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Guardando donación...')
          ],
        ),
      ),
    );

    try {
      var docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('donations')
          .add({
        "userId": userId,
        "type": donationType ?? "No type",
        "title": title,
        "description": description,
        "estado": 0,
        "createdAt": DateTime.now().toIso8601String(),
      });

      String donationId = docRef.id;
      Map<String, dynamic> donationData = {
        "donationId": donationId,
        "userId": userId,
        "type": donationType ?? "No type",
        "title": title,
        "description": description,
        "estado": 0,
        "createdAt": DateTime.now().toIso8601String(),
      };

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('lastDonation', jsonEncode(donationData));

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donación guardada con éxito')),
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushNamed(context, '/map');
      });
    } catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar la donación: $e')),
      );
    }
  }

  Widget titleInput(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Título',
          style: GoogleFonts.amaticSc(fontSize: 22),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          onChanged: (value) => setState(() => title = value),
          decoration: const InputDecoration(
            hintText: 'Escribe el título aquí',
          ),
        ),
      ],
    );
  }

  Widget descriptionInput(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descripción',
          style: GoogleFonts.amaticSc(fontSize: 22),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          onChanged: (value) => setState(() => description = value),
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Agrega una descripción detallada aquí...',
          ),
        ),
      ],
    );
  }

  Widget buildButtonContinue() {
    return ElevatedButton(
      onPressed: saveData,
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor,
        minimumSize: const Size(150, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        'Continuar',
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}