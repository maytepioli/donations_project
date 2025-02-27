import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const Color myColor = Color(0xFF9D4EDD);

class BaseScreen extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentPage;
  final ValueChanged<int>? onBottomNavTap;
  final bool showAppBarActions;
  final List<IconData>? bottomNavIcons;
  final TextStyle? appBarTitleStyle;
  final Color? appBarBackgroundColor;
  final double appBarElevation;
  final Color? appBarShadowColor;
  final Color? appBarSurfaceTintColor;
  final IconThemeData? appBarIconTheme;

  const BaseScreen({
    Key? key,
    required this.body,
    required this.title,
    this.currentPage = 1,
    this.onBottomNavTap,
    this.showAppBarActions = true,
    this.bottomNavIcons,
    this.appBarTitleStyle,
    this.appBarBackgroundColor,
    this.appBarElevation = 0,
    this.appBarShadowColor,
    this.appBarSurfaceTintColor,
    this.appBarIconTheme,
  }) : super(key: key);

  List<Widget> _buildNavItems() {
    final icons = bottomNavIcons ??
        [
          MdiIcons.homeOutline,
          MdiIcons.plusCircleOutline,
          MdiIcons.mapMarkerOutline,
        ];
    return List<Widget>.generate(icons.length, (index) {
      if (index == currentPage) {
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: myColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icons[index],
            size: 30,
            color: Colors.white,
          ),
        );
      } else {
        return Icon(
          icons[index],
          size: 30,
          color: Colors.grey,
        );
      }
    });
  }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/perfil.jpg'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Nombre del Usuario',
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                PressableListTile(
                  leading:
                      Icon(MdiIcons.accountCircleOutline, color: Colors.black),
                  title: Text(
                    'Perfil',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                PressableListTile(
                  leading: Icon(MdiIcons.giftOutline, color: Colors.black),
                  title: Text(
                    'Donaciones',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/status_donation');
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: PressableListTile(
              leading: Icon(MdiIcons.logoutVariant, color: Colors.black),
              title: Text(
                'Cerrar Sesión',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildNavItems();

    return Container(
      // Aquí defines el fondo degradado que se extenderá por toda la pantalla.
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFEDE7F6), // Violeta muy claro
            Color(0xFFF3E5F5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Para ver el gradiente
        appBar: AppBar(
          title: Text(
            title,
            style: appBarTitleStyle ??
                GoogleFonts.amaticSc(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
          ),
          backgroundColor: appBarBackgroundColor ?? Colors.white,
          elevation: appBarElevation,
          shadowColor: appBarShadowColor,
          surfaceTintColor: appBarSurfaceTintColor,
          centerTitle: true,
          iconTheme: appBarIconTheme ?? const IconThemeData(color: myColor),
          actions: showAppBarActions
              ? [
                  IconButton(
                    icon: const Icon(Icons.notifications, color: myColor),
                    onPressed: () {
                      Navigator.pushNamed(context, '/notification');
                    },
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
          color:
              Colors.white, // Color de la barra (los íconos se muestran encima)
          buttonBackgroundColor:
              Colors.white, // Botón activo en blanco (flotante)
          backgroundColor:
              Colors.transparent, // Deja ver el degradado detrás de la barra
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: onBottomNavTap,
        ),
      ),
    );
  }
}

/// Widget para dispositivos móviles que simula un efecto "presionado" en el Drawer.
class PressableListTile extends StatefulWidget {
  final Widget leading;
  final Widget title;
  final VoidCallback? onTap;

  const PressableListTile({
    Key? key,
    required this.leading,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  _PressableListTileState createState() => _PressableListTileState();
}

class _PressableListTileState extends State<PressableListTile> {
  bool _pressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _pressed = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _pressed = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _pressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: _pressed ? myColor.withOpacity(0.3) : Colors.transparent,
        child: ListTile(
          tileColor: Colors.transparent,
          leading: widget.leading,
          title: widget.title,
        ),
      ),
    );
  }
}
