import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xFF9D4EDD);

class DonationCenter extends StatelessWidget {
  const DonationCenter({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos ficticios de donaciones: ropa, juguetes y cosas de mascota.
    final List<Map<String, dynamic>> donationList = [
      {
        'donor': 'Alice Johnson',
        'category': 'Ropa',
        'item': 'Chaqueta',
        'amount': 1,
        'date': '2023-10-01',
        'message': 'Espero que te sirva!',
      },
      {
        'donor': 'Bob Smith',
        'category': 'Juguetes',
        'item': 'Muñeca de trapo',
        'amount': 2,
        'date': '2023-10-02',
        'message': '¡Los niños la adorarán!',
      },
      {
        'donor': 'Carlos Martinez',
        'category': 'Cosas de mascota',
        'item': 'Cama para perro',
        'amount': 1,
        'date': '2023-10-03',
        'message': 'Mi perro la disfruta muchísimo!',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donations Center',
          style: GoogleFonts.amaticSc(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.normal,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: donationList.length,
        itemBuilder: (context, index) {
          final donation = donationList[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${donation['category']} - ${donation['item']}',
                    style: GoogleFonts.amaticSc(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cantidad: ${donation['amount']}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Donante: ${donation['donor']}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fecha: ${donation['date']}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    donation['message'],
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
