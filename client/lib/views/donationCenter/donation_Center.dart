import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        .where('estado', isEqualTo: 0) // Solo donaciones con estado 0
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              var data = doc.data();
              data['id'] = doc.id; // ID de la copia en el centro de donación
              return data;
            }).toList());
  }

  Future<void> updateDonationStatus(String donorId, String donorDonationId, String centerDonationId, String centerId, int newStatus) async {
    if (donorId.isEmpty || donorDonationId.isEmpty || centerDonationId.isEmpty || centerId.isEmpty) {
      print("Error: ID del donador, ID de la donación del donador o ID del centro no válidos");
      return;
    }

    try {
      // Actualizamos el estado en la colección del donador
      await FirebaseFirestore.instance
          .collection('users')
          .doc(donorId)
          .collection('donations')
          .doc(donorDonationId)
          .update({'estado': newStatus});
      print("Estado actualizado a $newStatus para la donación $donorDonationId del donador $donorId");

      // Actualizamos el estado en la colección del centro de donación
      await FirebaseFirestore.instance
          .collection('users')
          .doc(centerId)
          .collection('donations')
          .doc(centerDonationId) // Esta es la donación en el centro de donación
          .update({'estado': newStatus});
      print("Estado actualizado a $newStatus para la donación $centerDonationId en el centro $centerId");

    } catch (e) {
      print("Error al actualizar el estado de la donación: $e");
    }
  }

  Future<void> deleteDonation(String centerId, String centerDonationId, String donorId, String donorDonationId) async {
    try {
      // Borra la donación de la colección del centro de donación
      await FirebaseFirestore.instance
          .collection('users')
          .doc(centerId)
          .collection('donations')
          .doc(centerDonationId)
          .delete();

      // Si la donación es rechazada, actualizamos el estado en la colección del donador a 0
      await updateDonationStatus(donorId, donorDonationId, centerDonationId, centerId, 0);
      print("Donación rechazada y eliminada del centro");
    } catch (e) {
      print("Error al rechazar la donación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donaciones Pendientes'),
        backgroundColor: const Color(0xFFDEC3BE),
      ),
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
              final String centerDonationId = donation['id']; // ID en la colección de donaciones del centro
              final String donorId = donation['userId'] ?? ''; // ID del donador
              final String donorDonationId = donation['donationId'] ?? ''; // ID de la donación original del donador

              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${donation['type'] ?? 'Sin categoría'} - ${donation['title'] ?? 'Sin título'}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Descripción: ${donation['description'] ?? 'No disponible'}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Fecha: ${donation['createdAt'] ?? 'Desconocida'}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (centerId != null && donorDonationId.isNotEmpty && donorId.isNotEmpty) {
                                await updateDonationStatus(donorId, donorDonationId, centerDonationId, centerId, 2); // Aceptar donación
                              } else {
                                print("Error: ID del donador o de la donación no válida");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text('Aceptar'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (centerId != null && donorDonationId.isNotEmpty && donorId.isNotEmpty) {
                                await deleteDonation(centerId, centerDonationId, donorId, donorDonationId); // Rechazar donación
                              } else {
                                print("Error: ID del donador o de la donación no válida");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
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
