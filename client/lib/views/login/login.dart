import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application/services/auth_service.dart';  // <-- Import here
import 'package:firebase_auth/firebase_auth.dart';

const Color myColor = Color(0xffea638c);

class Login extends StatelessWidget {
  const Login({super.key});

  // Google Sign-In Function
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      User? user = await AuthService().signInWithGoogle(); // Use AuthService for login

      if (user == null) {
        print("No user signed in.");
        return;
      }

      // Fetch isCentro value from Firestore
      int? isCentro = await AuthService().isUserDonationCenter(user.uid);

      // Store the value locally
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (isCentro != 0) {
        await prefs.setInt('isCentro', isCentro);
      }

      // Navigate based on isCentro value
      if (isCentro == 0) {
        Navigator.pushReplacementNamed(context, '/rol'); // Not set
      } else if (isCentro == 2) {
        Navigator.pushReplacementNamed(context, '/donations_Center'); // Donation center
      } else {
        Navigator.pushReplacementNamed(context, '/'); // Regular user
      }

      print("Signed in as: ${user.displayName}");
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F7),
      body: Stack(
        children: [
          AnimatedPositionedWidget(top: -80, left: -80),
          AnimatedPositionedWidget(top: 120, right: -90),
          AnimatedPositionedWidget(bottom: -100, left: -50),
          AnimatedPositionedWidget(bottom: 70, right: 70),
          AnimatedPositionedWidget(top: -40, right: 40),
          AnimatedPositionedWidget(bottom: 150, left: 150),
          AnimatedPositionedWidget(top: 80, left: 250),
          AnimatedPositionedWidget(bottom: 250, right: 200),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Imagen agregada arriba del texto "HOPE BOX"
                  Image.asset(
                    'assets/fonts/logo.png',
                    height: 100, // ajusta la altura según necesites
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'HOPE BOX',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: myColor,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: myColor, width: 2),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    ),
                    onPressed: () => signInWithGoogle(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/image.png',
                          height: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Iniciar sesión con Google',
                          style: TextStyle(fontSize: 16, color: myColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedPositionedWidget extends StatefulWidget {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const AnimatedPositionedWidget(
      {this.top, this.left, this.right, this.bottom});

  @override
  _AnimatedPositionedWidgetState createState() =>
      _AnimatedPositionedWidgetState();
}

class _AnimatedPositionedWidgetState extends State<AnimatedPositionedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -15, end: 15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: widget.top != null ? widget.top! + _animation.value : null,
          left: widget.left != null ? widget.left! + _animation.value : null,
          right: widget.right != null ? widget.right! - _animation.value : null,
          bottom:
              widget.bottom != null ? widget.bottom! - _animation.value : null,
          child: CircularDecoration(),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CircularDecoration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: myColor.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }
}