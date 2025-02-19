import 'package:flutter/material.dart';

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
        title: const Text('Donations Center'),
        backgroundColor: const Color(0xFFDEC3BE),
      ),
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
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Cantidad: ${donation['amount']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Donante: ${donation['donor']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Fecha: ${donation['date']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    donation['message'],
                    style: const TextStyle(fontSize: 14),
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
