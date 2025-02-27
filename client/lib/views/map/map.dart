import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Centros Registrados"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('isCentro', isEqualTo: 2) // Filtra los centros
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay centros registrados.'));
          }

          var userDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              var user = userDocs[index];
              var centerId = user.id; // ID del centro de donación
              var centerName = user['centerName'] ?? 'Nombre no disponible';
              var address = user['address'] ?? 'Dirección no disponible';
              var phone = user['telefono'] ?? 'Número no disponible';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  title: Text(centerName),
                  subtitle: Text('Dirección: $address\nTeléfono: $phone'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    assignDonationToCenter(centerId);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Función para obtener la última donación localmente
  Future<Map<String, dynamic>?> getLastDonation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? donationString = prefs.getString('lastDonation');
    
    if (donationString != null) {
      return jsonDecode(donationString);
    }
    return null;
  }
  
  Future<String?> getUserIdFromLastDonation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? donationString = prefs.getString('lastDonation');
  if (donationString != null) {
    Map<String, dynamic> donation = jsonDecode(donationString);
    return donation['userId'];  // Extract userId from the saved donation data
  }
  return null;
}
  Future<String?> getDonationIdFromLastDonation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? donationString = prefs.getString('lastDonation');
  if (donationString != null) {
    Map<String, dynamic> donation = jsonDecode(donationString);
    return donation['donationId'];  // Extract donationId from the saved donation data
  }
  return null;
}

  // Función para asignar la donación a un centro de donación
void assignDonationToCenter(String centerId) async {
  Map<String, dynamic>? donation = await getLastDonation();
  if (donation == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No hay donaciones recientes para asignar')),
    );
    return;
  }

  String? userId = await getUserIdFromLastDonation();
  String? donationId = await getDonationIdFromLastDonation();
  if (userId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No se ha encontrado el ID del usuario')),
    );
    return;
  }


    try {
      await FirebaseFirestore.instance
          .collection('users')  // Colección de centros de donación
          .doc(centerId)  // Centro seleccionado
          .collection('donations')  // Subcolección de donaciones
          .add(donation);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Donación asignada al centro con éxito')),
      );

       await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('donations')
          .doc(donationId)
          .update({
            'estado': 1,
            'enviado': centerId,
          });

    } catch (e) {
      print('Error asignando donación al centro: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al asignar donación: $e')),
      );
    }
  }
}
