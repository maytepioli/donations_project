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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Donaciones',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
            16.0), // Añadir padding para separar de los bordes
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleInput(TextEditingController()),
            SizedBox(height: 24), // Aumentar el espacio entre los widgets
            descriptionInput(TextEditingController()),
            SizedBox(height: 24),
            buildButtonContinue(context), // Botón añadido aquí
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
            fontSize: 22,
            fontWeight: FontWeight.bold), // Aumentar el tamaño del texto
      ),
      SizedBox(height: 10),
      Container(
        width: double.infinity, // Para que ocupe todo el ancho disponible
        height: 60, // Aumentar la altura
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: BorderRadius.circular(16), // Bordes más redondeados
        ),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Escribe el título aquí',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none, // Sin borde exterior
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20, vertical: 18), // Más espacio interno
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
            fontSize: 22,
            fontWeight: FontWeight.bold), // Aumentar el tamaño del texto
      ),
      SizedBox(height: 10),
      Container(
        padding: EdgeInsets.all(16), // Más espacio interno
        height: 150, // Aumentar la altura del contenedor
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20), // Bordes más redondeados
          border: Border.all(color: Colors.grey),
        ),
        child: TextField(
          controller: controller,
          maxLines: null, // Permitir múltiples líneas
          expands: true, // Expandir para llenar el contenedor
          decoration: InputDecoration.collapsed(
            hintText: 'Agrega una descripción detallada aquí...',
          ),
        ),
      ),
    ],
  );
}

// Botón de Continuar
Widget buildButtonContinue(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pushNamed(context, '/MapScreen');
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: myColor,
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
