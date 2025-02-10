import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

// Definición del color personalizado
const Color myColor =
    Color(0xFFDEC3BE); // Puedes cambiar este color según tu preferencia

// Pantalla principal
class DonationsScreen extends StatefulWidget {
  const DonationsScreen({Key? key}) : super(key: key);

  @override
  DonationsScreenState createState() => DonationsScreenState();
}

class DonationsScreenState extends State<DonationsScreen> {
  late Color myColor;
  late Size mediaSize;
  int _page = 1; // Inicializado en 1 para que se seleccione el botón del medio

  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = const Color(0xFFDEC3BE);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Añadir padding para separar de los bordes
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleInput(TextEditingController()),
            SizedBox(height: 16),
            descriptionInput(TextEditingController()),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: _page,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.add, size: 30, color: Colors.black),
          Icon(Icons.map_outlined, size: 30, color: Colors.black),
        ],
        color: myColor,
        buttonBackgroundColor: myColor,
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

// Widget para el Título
Widget titleInput(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Título',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 5),
      Container(
        width: double.infinity, // Para que ocupe todo el ancho disponible
        height: 60,
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Escribe el título aquí',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none, // Sin borde exterior
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            filled: true,
            fillColor: myColor,
          ),
        ),
      ),
    ],
  );
}

// Widget para la Descripción
Widget descriptionInput(TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Descripción',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 5),
      Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: myColor),
        ),
        child: TextField(
          controller: controller,
          maxLines: 5,
          decoration: InputDecoration.collapsed(
            hintText: 'Agrega una descripción detallada aquí...',
          ),
        ),
      ),
    ],
  );
}
