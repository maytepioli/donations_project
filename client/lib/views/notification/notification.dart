import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('notificaciones'),
      ),
      body: Center(
        child: Text(
          'Notificaciones',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
