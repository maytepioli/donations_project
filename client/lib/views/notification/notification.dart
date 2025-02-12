import 'package:flutter/material.dart';

const Color myColor = Color(0xFFDEC3BE);

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  // Lista de notificaciones de ejemplo
  final List<NotificationItem> notifications = [
    NotificationItem(
        id: '1', message: 'Se ha recibido una solicitud de donación.'),
    NotificationItem(
        id: '2', message: 'Se ha recibido una solicitud de donación.'),
    NotificationItem(
        id: '3', message: 'Se ha recibido una solicitud de donación.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notificaciones',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationBubble(notification: notifications[index]);
        },
      ),
    );
  }
}

// Modelo simple para representar una notificación
class NotificationItem {
  final String id;
  final String message;

  NotificationItem({required this.id, required this.message});
}

// Widget que representa cada notificación como una burbuja con botones
class NotificationBubble extends StatelessWidget {
  final NotificationItem notification;

  const NotificationBubble({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Lógica para rechazar la notificación
                    print('Rechazar notificación: ${notification.id}');
                  },
                  child: const Text(
                    'Rechazar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para aceptar la notificación
                    print('Aceptar notificación: ${notification.id}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: myColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Aceptar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
