import 'package:flutter/material.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xFF9D4EDD);
const double imageSize = 75.0;

class ObjectScreen extends StatefulWidget {
  const ObjectScreen({super.key});

  @override
  ObjectScreenState createState() => ObjectScreenState();
}

class ObjectScreenState extends State<ObjectScreen> {
  late Size mediaSize;
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    Widget bodyWithGradient = Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEDE7F6),
            Color(0xFFF3E5F5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton(
                  label: 'Comida',
                  icon: Icons.fastfood,
                  donationArgument: 'Comida',
                ),
                const SizedBox(width: 20),
                _buildCategoryButton(
                  label: 'Ropa',
                  icon: Icons.checkroom,
                  donationArgument: 'Ropa',
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategoryButton(
                  label: 'Juguetes',
                  icon: Icons.toys,
                  donationArgument: 'Juguetes',
                ),
                const SizedBox(width: 20),
                _buildCategoryButton(
                  label: 'Mascotas',
                  icon: Icons.pets,
                  donationArgument: 'Mascotas',
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return BaseScreen(
      title: 'Elige el objeto a donar',
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
      body: bodyWithGradient,
    );
  }

  Widget _buildCategoryButton({
    required String label,
    required IconData icon,
    required String donationArgument,
  }) {
    Widget buttonContent;
    if (donationArgument == 'Comida') {
      buttonContent = Image.asset('assets/fonts/imagen_comida.png', width: imageSize, height: imageSize);
    } else if (donationArgument == 'Mascotas') {
      buttonContent = Image.asset('assets/fonts/imagen_animal.png', width: imageSize, height: imageSize);
    } else if (donationArgument == 'Juguetes') {
      buttonContent = Image.asset('assets/fonts/imagen_juego.png', width: imageSize, height: imageSize);
    } else if (donationArgument == 'Ropa') {
      buttonContent = Image.asset('assets/fonts/imagen_ropa.png', width: imageSize, height: imageSize);
    } else {
      buttonContent = Icon(icon, color: myColor, size: 30);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/donations', arguments: donationArgument);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            minimumSize: const Size(150, 150),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: buttonContent,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ],
    );
  }
}
