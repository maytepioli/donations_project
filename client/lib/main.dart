import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("🔥 Firebase está conectado correctamente");
  } catch (e) {
    print("⚠️ Error al conectar Firebase: $e");
  }
  runApp(MyApp());
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("🔥 Firebase está conectado correctamente");
  } catch (e) {
    print("⚠️ Error al conectar Firebase: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Test")),
      appBar: AppBar(title: Text("Firebase Test")),
      body: Center(
        child: Text("🔥 Firebase está conectado"),
      ),
        child: Text("🔥 Firebase está conectado"),
      ),
    );
  }
}
