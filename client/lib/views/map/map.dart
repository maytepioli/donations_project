import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: Text(
          'Contenido del Map',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
