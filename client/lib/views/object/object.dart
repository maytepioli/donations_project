import 'package:flutter/material.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';

class ObjectScreen extends StatefulWidget {
  const ObjectScreen({super.key});

  @override
  ObjectScreenState createState() => ObjectScreenState();
}

class ObjectScreenState extends State<ObjectScreen> {
  late Color myColor;
  late Size mediaSize;
  int _page = 1; // Índice inicial para la barra inferior

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    myColor = const Color(0xFFDEC3BE);

    return BaseScreen(
      title: 'Object', // Título del AppBar
      currentPage: _page,
      showAppBarActions: false, // Oculta íconos de notificaciones y perfil
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBottomFood(mediaSize),
                const SizedBox(width: 20),
                _buildBottomClothes(mediaSize),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBottomToys(mediaSize),
                const SizedBox(width: 20),
                _buildBottomPets(mediaSize),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomFood(Size mediaSize) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/donations');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor,
        minimumSize: const Size(150, 150),
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
        backgroundColor: myColor,
        minimumSize: const Size(150, 150),
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
        backgroundColor: myColor,
        minimumSize: const Size(150, 150),
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
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/donations');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor,
        minimumSize: const Size(150, 150),
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
