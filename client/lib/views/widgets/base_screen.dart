import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
const Color myColor = Color(0xffea638c);
class BaseScreen extends StatefulWidget {
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
  @override
  _BaseScreenState createState() => _BaseScreenState();
}
class _BaseScreenState extends State<BaseScreen> {
  String profileImageUrl = '';
  String profileName = '';
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  void _loadUserData() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        profileImageUrl = user.photoURL ?? '';
        profileName = user.displayName ?? 'Juan Pérez';
      });
    }
  }
  List<Widget> _buildNavItems() {
    final icons = widget.bottomNavIcons ??
        [
          MdiIcons.homeOutline,
          MdiIcons.plusCircleOutline,
          MdiIcons.mapMarkerOutline,
        ];
    return List<Widget>.generate(icons.length, (index) {
      if (index == widget.currentPage) {
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
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : const AssetImage('assets/images/perfil.jpg')
                          as ImageProvider,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    profileName,
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                PressableListTile(
                  leading: Icon(MdiIcons.accountCircleOutline, color: Colors.black),
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
                GoogleSignIn().signOut();
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            widget.title,
            style: widget.appBarTitleStyle ??
                GoogleFonts.amaticSc(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
          ),
          backgroundColor: widget.appBarBackgroundColor ?? Colors.white,
          elevation: widget.appBarElevation,
          shadowColor: widget.appBarShadowColor,
          surfaceTintColor: widget.appBarSurfaceTintColor,
          centerTitle: true,
          iconTheme: widget.appBarIconTheme ?? const IconThemeData(color: myColor),
          actions: widget.showAppBarActions
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
        drawer: widget.showAppBarActions ? _buildSideMenu(context) : null,
        body: Padding(padding: const EdgeInsets.all(16.0), child: widget.body),
        bottomNavigationBar: CurvedNavigationBar(
          index: widget.currentPage,
          height: 60.0,
          items: items,
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: widget.onBottomNavTap,
        ),
      ),
    );
  }
}
/// Widget que simula un efecto presionado para cada opción del Drawer.
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