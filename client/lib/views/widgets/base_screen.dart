import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

const Color myColor = Color(0xFFDEC3BE);

class BaseScreen extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentPage;
  final ValueChanged<int>? onBottomNavTap;
  final bool
      showAppBarActions; // Nuevo parámetro para controlar los íconos del AppBar

  const BaseScreen({
    Key? key,
    required this.body,
    required this.title,
    this.currentPage = 1,
    this.onBottomNavTap,
    this.showAppBarActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: showAppBarActions
            ? [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.black),
                  onPressed: () {
                    Navigator.pushNamed(context, '/notification');
                  },
                ),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.account_circle, color: Colors.black),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              ]
            : null,
      ),
      // Solo se muestra el Drawer si se están mostrando las acciones (perfil)
      drawer: showAppBarActions ? _buildSideMenu(context) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentPage,
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
        onTap: onBottomNavTap,
      ),
    );
  }
}

// Función auxiliar para construir el menú lateral (Drawer)
Widget _buildSideMenu(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: myColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/images/perfil.jpg'),
              ),
              SizedBox(height: 10),
              Text(
                'Nombre del Usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/profile');
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Configuración'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/config');
          },
        ),
      ],
    ),
  );
}
