import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class ObjectScreen extends StatefulWidget {
  const ObjectScreen({Key? key}) : super(key: key);

  @override
  ObjectState createState() => ObjectState();
}

class ObjectState extends State<ObjectScreen> {
  late Color myColor;
  late Size mediaSize;
  int _page = 1; // Inicializado en 1 para que se seleccione el botón del medio

  // GlobalKey para el CurvedNavigationBar (opcional)
  final GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = const Color(0xFFDEC3BE);

    return Scaffold(
      backgroundColor: Colors.white,
      // Aquí puedes colocar el contenido propio de la ruta si lo deseas.
      // Si solo quieres la navegación, puedes dejarlo vacío o usar Container().
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBottomFood(mediaSize),
                const SizedBox(width: 20),
                _buildBottomClothes(mediaSize)
              ],
            ),
            const SizedBox(height: 20), // Espacio entre filas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBottomToys(mediaSize),
                const SizedBox(width: 20),
                _buildBottomPets(mediaSize)
              ],
            )
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
          // Navega a las rutas según el índice seleccionado
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

  Widget _buildBottomFood(Size mediaSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/donations');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor, // Utiliza myColor para el fondo del botón
        minimumSize: const Size(
            150, 150), // Aumenta el tamaño temporalmente para depurar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Icon(
        Icons.fastfood,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildBottomClothes(Size mediaSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/donations');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor, // Utiliza myColor para el fondo del botón
        minimumSize: const Size(
            150, 150), // Aumenta el tamaño temporalmente para depurar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildBottomToys(Size mediaSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/donations');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor, // Utiliza myColor para el fondo del botón
        minimumSize: const Size(
            150, 150), // Aumenta el tamaño temporalmente para depurar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Icon(
        Icons.toys,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget _buildBottomPets(Size mediaSize) {
    print("Construyendo el botón");
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/donations');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor, // Utiliza myColor para el fondo del botón
        minimumSize: const Size(
            150, 150), // Aumenta el tamaño temporalmente para depurar
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Icon(
        Icons.pets,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}
