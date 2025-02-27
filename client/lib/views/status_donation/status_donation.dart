import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xFF9D4EDD);

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: false, // Asegura Material 2
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        shadowColor: Colors.black54,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: GoogleFonts.amaticSc(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
    home: StatusScreen(),
  ));
}

/// Servicio para obtener las donaciones en tiempo real desde Firestore.
class DonationService {
  /// Obtiene las donaciones con estado 0 del usuario logueado.
  Stream<List<Donation>> getDonationsWithStatusZero() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty();
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('donations')
        .where('estado', isEqualTo: 0)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var data = doc.data();
              return Donation(
                id: doc.id,
                message: data['message'] ?? 'Sin mensaje',
                recipient: data['recipient'] ?? 'No disponible',
                category: data['category'] ?? 'No disponible',
              );
            }).toList());
  }
}

/// Modelo para representar una donación.
class Donation {
  final String id;
  final String message;
  final String recipient;
  final String category;

  Donation({
    required this.id,
    required this.message,
    required this.recipient,
    required this.category,
  });
}

/// Pantalla principal que muestra dos pestañas: “Finalizadas” y “En curso”.
class StatusScreen extends StatelessWidget {
  StatusScreen({Key? key}) : super(key: key);

  // Lista de ejemplo para donaciones finalizadas.
  final List<Donation> finishedDonations = [
    Donation(
      id: '1',
      message: 'Donación finalizada: Ayuda para el refugio.',
      recipient: 'Refugio Los Ángeles',
      category: 'Comida',
    ),
    Donation(
      id: '2',
      message: 'Donación finalizada: Apoyo a campaña de salud.',
      recipient: 'Clínica Santa María',
      category: 'Ropa',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Dos pestañas: finalizadas y en curso.
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          title: Text(
            'Mis Donaciones',
            style: GoogleFonts.amaticSc(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Container(
              color: Colors.white,
              child: const TabBar(
                indicatorColor: myColor,
                labelColor: myColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Finalizadas'),
                  Tab(text: 'En curso'),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            // Pestaña de donaciones finalizadas con datos de ejemplo.
            DonationList(donations: finishedDonations),
            // Pestaña de donaciones en curso, obtenidas desde Firebase.
            StreamBuilder<List<Donation>>(
              stream: DonationService().getDonationsWithStatusZero(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final donations = snapshot.data!;
                if (donations.isEmpty) {
                  return const Center(child: Text('No tienes donaciones pendientes.'));
                }
                return DonationList(donations: donations);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget que representa cada donación en una tarjeta.
class DonationCard extends StatelessWidget {
  final Donation donation;

  const DonationCard({Key? key, required this.donation}) : super(key: key);

  /// Muestra un diálogo con los detalles de la donación.
  void _showDonationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  donation.message,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Donado a: ${donation.recipient}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Categoría: ${donation.category}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: myColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Cerrar',
                    style: GoogleFonts.poppins(
                      color: myColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDonationDialog(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donation.message,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Donado a: ${donation.recipient}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Categoría: ${donation.category}',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget que lista las donaciones recibidas.
class DonationList extends StatelessWidget {
  final List<Donation> donations;

  const DonationList({Key? key, required this.donations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: donations.length,
      itemBuilder: (context, index) {
        return DonationCard(donation: donations[index]);
      },
    );
  }
}
