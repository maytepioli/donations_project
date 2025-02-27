import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



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
    final icons = widget.bottomNavIcons ?? [Icons.home, Icons.add, Icons.map_outlined];
    return List<Widget>.generate(icons.length, (index) {
      return index == widget.currentPage
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: myColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icons[index], size: 30, color: Colors.white),
            )
          : Icon(icons[index], size: 30, color: Colors.black);
    });
  }

  @override
  Widget build(BuildContext context) {
    final items = _buildNavItems();

    return Scaffold(
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
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: widget.onBottomNavTap,
      ),
    );
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
                      : const AssetImage('assets/images/perfil.jpg') as ImageProvider,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    profileName,
                    style: GoogleFonts.roboto(color: myColor, fontSize: 18),
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
                ListTile(
                  leading: const Icon(Icons.person, color: myColor),
                  title: Text('Perfil', style: GoogleFonts.roboto(fontSize: 16, color: Colors.black)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.card_giftcard, color: myColor),
                  title: Text('Donaciones', style: GoogleFonts.roboto(fontSize: 16, color: Colors.black)),
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
            child: ListTile(
              leading: const Icon(Icons.logout, color: myColor),
              title: Text('Cerrar Sesión', style: GoogleFonts.roboto(fontSize: 16, color: Colors.black)),
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
}
