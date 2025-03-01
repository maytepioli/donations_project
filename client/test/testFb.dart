import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Probar Firestore
  FirebaseFirestore.instance.collection('users').get().then((snapshot) {
    for (var doc in snapshot.docs) {
      print("ID: ${doc.id}, Data: ${doc.data()}");
    }
  });

  // Probar conversión de dirección a coordenadas
  try {
    List<Location> locations = await locationFromAddress("Avenida Reforma 123, CDMX");
    if (locations.isNotEmpty) {
      print("Lat: ${locations.first.latitude}, Lng: ${locations.first.longitude}");
    } else {
      print("Dirección no encontrada");
    }
  } catch (e) {
    print("Error en geocoding: $e");
  }
}