import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
            buildButtonContinue(
              /*  _titleController, _descriptionController, context*/),
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
  void saveData() {
    print('Saved data:');
    print('Type: $donationType');
    print('Title: $title');
    print('Description: $description');
    // You can store the data in any format you want here. For example:
    Map<String, String> donationData = {
      "type": donationType ?? "No type",
      "title": title,
      "description": description,
    };

    // ACA FALTA HACER ALGO CON DONATION DATA 
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
        Navigator.pushNamed(context, '/map');
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