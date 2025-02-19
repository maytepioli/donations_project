import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? selectedCenter;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Centro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Seleccione un Centro de Donación',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCenter = "Centro Ejemplo"; // Simulación de selección
                });
              },
              child: const Text("Seleccionar Centro"),
            ),
            const SizedBox(height: 20),
            if (selectedCenter != null)
              Text(
                'Centro seleccionado: $selectedCenter',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: selectedCenter == null || isLoading ? null : () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedCenter == null
                    ? Colors.grey
                    : const Color(0xFFDEC3BE),
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Crear Donación',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
