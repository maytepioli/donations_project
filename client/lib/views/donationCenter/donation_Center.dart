import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myColor = Color(0xFF9D4EDD);

class DonationCenter extends StatelessWidget {
  const DonationCenter({super.key});

  Stream<List<Map<String, dynamic>>> getPendingDonations() {
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
              data['id'] = doc.id;
              return data;
            }).toList());
  }

  Future<void> updateDonationStatus(String donorId, String donorDonationId, String centerDonationId, String centerId, int newStatus) async {
    if (donorId.isEmpty || donorDonationId.isEmpty || centerDonationId.isEmpty || centerId.isEmpty) {
      print("Error: ID inválido");
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(donorId)
          .collection('donations')
          .doc(donorDonationId)
          .update({'estado': newStatus});

      await FirebaseFirestore.instance
          .collection('users')
          .doc(centerId)
          .collection('donations')
          .doc(centerDonationId)
          .update({'estado': newStatus});
    } catch (e) {
      print("Error al actualizar estado: $e");
    }
  }

  Future<void> deleteDonation(String centerId, String centerDonationId, String donorId, String donorDonationId) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(centerId)
          .collection('donations')
          .doc(centerDonationId)
          .delete();

      await updateDonationStatus(donorId, donorDonationId, centerDonationId, centerId, 0);
    } catch (e) {
      print("Error al rechazar donación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donaciones Pendientes',
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: getPendingDonations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay donaciones pendientes.'));
          }

          final donationList = snapshot.data!;
          String? centerId = FirebaseAuth.instance.currentUser?.uid;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: donationList.length,
            itemBuilder: (context, index) {
              final donation = donationList[index];
              final String centerDonationId = donation['id'];
              final String donorId = donation['userId'] ?? '';
              final String donorDonationId = donation['donationId'] ?? '';

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
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Donante: ${donation['donor']}',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fecha: ${donation['date']}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        donation['message'] ?? '',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (centerId != null && donorDonationId.isNotEmpty && donorId.isNotEmpty) {
                                await updateDonationStatus(donorId, donorDonationId, centerDonationId, centerId, 2);
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            child: const Text('Aceptar'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (centerId != null && donorDonationId.isNotEmpty && donorId.isNotEmpty) {
                                await deleteDonation(centerId, centerDonationId, donorId, donorDonationId);
                              }
                            },
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            child: const Text('Rechazar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}