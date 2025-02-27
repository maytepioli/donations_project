import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';

const Color myColor = Color(0xFF9D4EDD);

class DonationsScreen extends StatefulWidget {
  const DonationsScreen({super.key});

  @override
  DonationsScreenState createState() => DonationsScreenState();
}

class DonationsScreenState extends State<DonationsScreen> {
  int _page = 1;
  String? donationType; // Almacena el tipo de donación recibido como argumento
  String title = ''; // Título ingresado
  String description = ''; // Descripción ingresada
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

  Widget titleInput(TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Título',
          style: GoogleFonts.amaticSc(
            fontSize: 22,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                title = value;
              });
            },
            controller: controller,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
            ),
            decoration: const InputDecoration.collapsed(
              hintText: 'Escribe el título aquí',
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
        Text(
          'Descripción',
          style: GoogleFonts.amaticSc(
            fontSize: 22,
            fontWeight: FontWeight.normal,
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
                description = value;
              });
            },
            controller: controller,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.normal,
            ),
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
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/map');
      },
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
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
