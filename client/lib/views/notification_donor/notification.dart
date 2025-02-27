import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void main() {
  runApp(const MyApp());
}
const Color myColor = Color(0xFF9D4EDD);
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification Demo',
      theme: ThemeData(
        useMaterial3:
            false, // Desactiva Material 3 para evitar tintes adicionales
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent, // Evita el tinte oscuro
          elevation: 10,
          shadowColor: Colors.black54,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: GoogleFonts.amaticSc(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.normal, // Sin negrita
          ),
        ),
      ),
      home: NotificationScreen(),
    );
  }
}
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
        title: Text(
          'Notificaciones',
          style: GoogleFonts.amaticSc(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.normal, // Sin negrita
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
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal, // Sin negrita
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
                  child: Text(
                    'Rechazar',
                    style: GoogleFonts.poppins(
                      color: myColor,
                      fontSize: 16,
                      fontWeight: FontWeight.normal, // Sin negrita
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para aceptar la notificación
                    print('Aceptar notificación: ${notification.id}');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Aceptar',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.normal, // Sin negrita
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}