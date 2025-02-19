import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

const Color myColor = Color(0xFFDEC3BE);

class BaseScreen extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentPage;
  final ValueChanged<int>? onBottomNavTap;
  final bool showAppBarActions;
  final List<Widget>? bottomNavItems;
  final TextStyle?
      appBarTitleStyle; // Nuevo parámetro para el estilo del título

  const BaseScreen({
    super.key,
    required this.body,
    required this.title,
    this.currentPage = 1,
    this.onBottomNavTap,
    this.showAppBarActions = true,
    this.bottomNavItems,
    this.appBarTitleStyle, // Recibe el estilo personalizado si se desea
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Si no se pasa lista, usamos la lista por defecto.
    final items = bottomNavItems ??
        const <Widget>[
          Icon(Icons.home, size: 30, color: Colors.black),
          Icon(Icons.add, size: 30, color: Colors.black),
          Icon(Icons.map_outlined, size: 30, color: Colors.black),
        ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: appBarTitleStyle ??
              const TextStyle(
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
                // Botón de notificaciones
                Builder(
                  builder: (BuildContext context) {
                    return IconButton(
                      icon:
                          const Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {
                        print('Notificaciones pressed');
                        Navigator.pushNamed(context, '/notification');
                      },
                    );
                  },
                ),
                // Botón de perfil
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
      drawer: showAppBarActions ? _buildSideMenu(context) : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: currentPage,
        height: 60.0,
        items: items,
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
        // Opción de Perfil
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Perfil'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/profile');
          },
        ),
        // Nueva opción: Donaciones (Regalos)
        ListTile(
          leading: const Icon(Icons.card_giftcard),
          title: const Text('Donaciones'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(
                context, '/gifts'); // Asegúrate de definir esta ruta
          },
        ),
        // Nueva opción: Cerrar Sesión
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar Sesión'),
          onTap: () {
            Navigator.pop(context);
            // Aquí puedes agregar la lógica para cerrar sesión.
            // Por ejemplo:
            // AuthService.logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    ),
  );
}
