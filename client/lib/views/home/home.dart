import 'package:flutter/material.dart';
import 'package:flutter_application/views/widgets/base_screen.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xffea638c);

// Modelo de donación para datos de ejemplo
class Donation {
  final String donorName;
  final String centerName;
  final String donationDate;
  final double amount;

  Donation({
    required this.donorName,
    required this.centerName,
    required this.donationDate,
    required this.amount,
  });
}

class Home extends StatelessWidget {
  final int isCentro; // true si el usuario es centro, false si es donador

  const Home({Key? key, required this.isCentro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Estilo personalizado para el título del AppBar
    final titleStyle = GoogleFonts.roboto(
      textStyle: const TextStyle(
        fontSize: 24,
        color: myColor,
        fontWeight: FontWeight.bold,
      ),
    );

    // Configuración común para el AppBar
    final appBarBackgroundColor = Colors.white;
    final appBarElevation = 10.0;
    final appBarShadowColor = Colors.black.withOpacity(0.5);
    final appBarSurfaceTintColor = Colors.transparent;
    final appBarIconTheme = const IconThemeData(color: Colors.black);

    if (isCentro == 2) {
      return BaseScreen(
        title: 'HopeBox',
        body: _buildDonationsFeed(context),
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
        // Pasamos la lista de íconos sin color; el BaseScreen asignará el color negro o resaltado
        bottomNavIcons: const <IconData>[
          Icons.home,
          Icons.account_circle,
          Icons.notifications,
          Icons.card_giftcard,
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
        body: _buildDonationsFeed(context),
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
          Icons.home,
          Icons.add,
          Icons.map_outlined,
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

// Widget que simula el feed de donaciones con un botón que navega a la ruta '/rol'
Widget _buildDonationsFeed(BuildContext context) {
  // Datos de ejemplo para el feed
  final List<Donation> fakeDonations = [
    Donation(
      donorName: 'Juan Pérez',
      centerName: 'Centro Esperanza',
      donationDate: '2025-02-20',
      amount: 50.0,
    ),
    Donation(
      donorName: 'María López',
      centerName: 'Centro Vida',
      donationDate: '2025-02-19',
      amount: 30.0,
    ),
    Donation(
      donorName: 'Carlos Mendoza',
      centerName: 'Centro Futuro',
      donationDate: '2025-02-18',
      amount: 40.0,
    ),
  ];

  return Column(
    children: [
      // Botón para navegar a la ruta '/rol'
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/rol');
          },
          child: const Text('Ir a Rol'),
        ),
      ),
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: fakeDonations.length,
          itemBuilder: (context, index) {
            final donation = fakeDonations[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                height: 150,
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Avatar del donante (izquierda)
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          const AssetImage('assets/donors/sample.png'),
                    ),
                    const SizedBox(width: 12),
                    // Columna central: descripción e insignia
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${donation.donorName} ha donado ropa, juguetes, comida y cosas para mascotas a ${donation.centerName}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Image.asset(
                            'assets/images/insignia.png',
                            width: 40,
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Avatar del centro (derecha)
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          const AssetImage('assets/centers/sample.png'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}