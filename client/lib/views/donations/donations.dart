import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({Key? key}) : super(key: key);

  @override
  DonationsScreenState createState() => DonationsScreenState();
}

class DonationsScreenState extends State<DonationsScreen> {
  int _page = 1; // Índice actual para la barra de navegación inferior
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donaciones',
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
            buildButtonContinue(
                _titleController, _descriptionController, context),
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

Widget buildButtonContinue(TextEditingController titleController,
    TextEditingController descController, BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(
        context,
        '/map',
        arguments: {
          'title': titleController.text,
          'description': descController.text,
        },
      );
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
  );
}
