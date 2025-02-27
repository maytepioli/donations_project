import 'package:flutter/material.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

const Color myColor = Color(0xFF9D4EDD);

class Home extends StatelessWidget {
  final bool isCentro;
  const Home({Key? key, required this.isCentro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.amaticSc(
      textStyle: const TextStyle(
        fontSize: 24,
        color: myColor,
        fontWeight: FontWeight.normal,
      ),
    );
    final appBarBackgroundColor = Colors.white;
    final appBarElevation = 10.0;
    final appBarShadowColor = Colors.black.withOpacity(0.5);
    final appBarSurfaceTintColor = Colors.transparent;
    final appBarIconTheme = const IconThemeData(color: Colors.black);

    if (isCentro) {
      return BaseScreen(
        title: 'HopeBox',
        body: _buildInstagramFeed(context),
        currentPage: 0,
        onBottomNavTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/profile');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/notification');
          } else if (index == 3) {
            Navigator.pushNamed(context, '/donations_Center');
          }
        },
        showAppBarActions: false,
        bottomNavIcons: const <IconData>[
          MdiIcons.homeOutline,
          MdiIcons.accountCircleOutline,
          MdiIcons.bellOutline,
          MdiIcons.giftOutline,
        ],
        appBarTitleStyle: titleStyle,
        appBarBackgroundColor: appBarBackgroundColor,
        appBarElevation: appBarElevation,
        appBarShadowColor: appBarShadowColor,
        appBarSurfaceTintColor: appBarSurfaceTintColor,
        appBarIconTheme: appBarIconTheme,
      );
    } else {
      return BaseScreen(
        title: 'HopeBox',
        body: _buildInstagramFeed(context),
        currentPage: 0,
        onBottomNavTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/object');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/map');
          }
        },
        bottomNavIcons: const <IconData>[
          MdiIcons.homeOutline,
          MdiIcons.plusCircleOutline,
          MdiIcons.mapMarkerOutline,
        ],
        appBarTitleStyle: titleStyle,
        appBarBackgroundColor: appBarBackgroundColor,
        appBarElevation: appBarElevation,
        appBarShadowColor: appBarShadowColor,
        appBarSurfaceTintColor: appBarSurfaceTintColor,
        appBarIconTheme: appBarIconTheme,
      );
    }
  }
}

Widget _buildInstagramFeed(BuildContext context) {
  final List<Map<String, String>> fakePosts = [
    {
      'username': 'Juan Pérez',
      'avatar': 'assets/images/avatar2.png',
      'postImage': 'assets/images/animales.jpg',
      'caption': 'Disfrutando de un día soleado',
    },
    {
      'username': 'María López',
      'avatar': 'assets/images/avatar.png',
      'postImage': 'assets/images/donacion_ropa.jpg',
      'caption': 'Donando amor a través de la ropa',
    },
    {
      'username': 'Carlos Mendoza',
      'avatar': 'assets/images/avatar2.png',
      'postImage': 'assets/images/donacion_comida.jpg',
      'caption': 'Compartiendo lo que tenemos',
    },
  ];

  return ListView.builder(
    itemCount: fakePosts.length,
    itemBuilder: (context, index) {
      final post = fakePosts[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(post['avatar']!),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['username']!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        post['caption']!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              post['postImage']!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(MdiIcons.heartOutline, color: Colors.black87, size: 30),
                  const SizedBox(width: 8),
                  Icon(MdiIcons.commentOutline,
                      color: Colors.black87, size: 30),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
