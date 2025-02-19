import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:donations/donations.dart';

class DonationsRepository extends GetxController {
  static DonationsRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createDonation(Donations donacion) async {
    try {
      await _db.collection('donacion').add(donacion.toJson());
      Get.snackbar(
        'Añadido', 
        'Correctamente',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF11FF00),
        colorText: const Color(0xFFFF0000),
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        'No se pudo añadir la donación: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF0000),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }
}