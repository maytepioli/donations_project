import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  DonationsScreenState createState() => DonationsScreenState();
}

class DonationsScreenState extends State<DonationsScreen> {
  int _page = 1;
  
  String? donationType;  // Variable to store donation type
  String title = '';      // Variable to store title
  String description = ''; // Variable to store description
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get the donation type passed via arguments (optional)
    donationType = ModalRoute.of(context)?.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donaciones - ${donationType ?? "error no se manda argumento"}',
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
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.add, size: 30, color: Colors.black),
          Icon(Icons.map_outlined, size: 30, color: Colors.black),
        ],
        color: const Color(0xFFDEC3BE),
        buttonBackgroundColor: const Color(0xFFDEC3BE),
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
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
      ),
    );
  }

  // Save the title and description when "Continuar" is pressed
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
  print("User logged in: $userId");

  // Mostrar diálogo de carga
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
    // Crear el documento en Firebase
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('donations')
        .add({
      "userId": userId,
      "type": donationType ?? "No type",
      "title": title,
      "description": description,
      "estado": 0, // No asignado a un centro aún
      "createdAt": DateTime.now().toIso8601String(),
    });

    String donationId = docRef.id;  // Obtener ID del documento generado por Firebase

    // Datos de la donación con el ID incluido
    Map<String, dynamic> donationData = {
      "donationId": donationId,
      "userId": userId,
      "type": donationType ?? "No type",
      "title": title,
      "description": description,
      "estado": 0,
      "createdAt": DateTime.now().toIso8601String(),
    };

    // Guardar en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastDonation', jsonEncode(donationData));

    Navigator.pop(context); // Cerrar el diálogo de carga

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Donación guardada con éxito')),
    );

    // Navegar a /map después de un breve retraso
    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pushNamed(context, '/map');
    });
  } catch (e) {
    Navigator.pop(context); // Cerrar el diálogo en caso de error
    print('Error saving donation: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al guardar la donación: $e')),
    );
  }
}


  Widget titleInput(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Título',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFDEC3BE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                title = value; // Save the title as user types
              });
            },
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Escribe el título aquí',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              filled: true,
              fillColor: const Color(0xFFDEC3BE),
            ),
          ),
        ),
      ],
    );
  }

  Widget descriptionInput(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descripción',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                description = value; // Save the description as user types
              });
            },
            controller: controller,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration.collapsed(
              hintText: 'Agrega una descripción detallada aquí...',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonContinue() {
    return Builder(
      builder: (context) => ElevatedButton(
        onPressed: () {
          print("Botón Continuar presionado");
          saveData(); // Save data when button is pressed
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFDEC3BE),
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Continuar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
