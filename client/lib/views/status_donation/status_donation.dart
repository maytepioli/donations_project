import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xffea638c);

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

class DonationService {
  // Función para obtener las donaciones con estado 0 del usuario logueado
  Stream<List<Map<String, dynamic>>> getDonationsWithStatusZero() {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return const Stream.empty(); // Si no hay usuario logueado, retorna un Stream vacío
    }

    // Obtiene las donaciones del usuario con estado 0
    return FirebaseFirestore.instance
        .collection('users') // Colección de usuarios
        .doc(userId) // Documento del usuario
        .collection('donations') // Subcolección de donaciones
        .where('estado', isEqualTo: 0) // Filtra donaciones con estado 0
        .snapshots() // Escucha los cambios en tiempo real
        .map((snapshot) {
          // Convierte los documentos en una lista de mapas
          return snapshot.docs.map((doc) {
            var data = doc.data();
            data['id'] = doc.id; // Añade la ID de la donación al mapa
            return data;
          }).toList();
        });
  }
}

class StatusScreen extends StatelessWidget {
  StatusScreen({Key? key}) : super(key: key);

  // Datos de ejemplo para donaciones finalizadas y en curso
  final List<Donation> finishedDonations = [];
  final List<Donation> ongoingDonations = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Dos pestañas: finalizadas y en curso
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Fondo blanco en el AppBar
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
              color: Colors.white, // Fondo blanco para la zona de TabBar
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
            DonationList(donations: finishedDonations),
            DonationList(donations: ongoingDonations),
          ],
        ),
      ),
    );
  }
}

// Modelo actualizado para representar una donación con información adicional
class Donation {
  final String id;
  final String title;
  final String description;
  final String category;

  Donation({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
  });
}

// Widget para representar cada donación en una tarjeta con diseño vertical y ancho limitado
class DonationCard extends StatelessWidget {
  final Donation donation;

  const DonationCard({Key? key, required this.donation}) : super(key: key);

  // Función para mostrar el diálogo con detalles de la donación
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
                  donation.title,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '${donation.description
                  } .',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Categoría: ${donation.category}',
                  style: GoogleFonts.roboto(
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
                    style: GoogleFonts.roboto(
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
                // Mensaje principal de la donación
                Text(
                  donation.title,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 10),
                // Información adicional
                Text(
                  '${donation.description}.',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Categoría: ${donation.category}',
                  style: GoogleFonts.roboto(
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

// Widget para listar las donaciones en cada pestaña
class DonationList extends StatefulWidget {
  final List<Donation> donations;

  const DonationList({Key? key, required this.donations}) : super(key: key);

  @override
  _DonationListState createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  bool donationsLoaded = false;

  @override
  void initState() {
    super.initState();
    DonationService().getDonationsWithStatusZero().listen((data) {
      setState(() {
        widget.donations.clear();
        for (var donation in data) {
          widget.donations.add(Donation(
            id: donation['id'],
            title: donation['title'] ?? 'Sin mensaje',
            description: donation['description'] ?? 'No disponible',
            category: donation['category'] ?? 'No disponible',
          ));
        }
        donationsLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!donationsLoaded) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.donations.isEmpty) {
      return const Center(child: Text('No tienes donaciones pendientes.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: widget.donations.length,
      itemBuilder: (context, index) {
        return DonationCard(donation: widget.donations[index]);
      },
    );
  }
}
