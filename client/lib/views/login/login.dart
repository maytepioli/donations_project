import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  // Function to sign in with Google and check registration
  Future<void> signInWithGoogleAndNavigate(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isRegistered = prefs.getBool('isRegistered') ?? false;

    if (isRegistered) {
      bool isCentro = prefs.getBool('isCentro') ?? false;
      Navigator.pushReplacementNamed(context, '/home', arguments: isCentro);
    } else {
      Navigator.pushReplacementNamed(context, '/rol');
    }
  }

  // Google Sign-In Function
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print("User canceled Google Sign-In");
        return; // User canceled sign-in
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user?.displayName == null) {
        Navigator.pushNamed(context, '/');
        print("No display name found.");
      } else {
        Navigator.pushNamed(context, '/rol');
        print("Signed in as: ${userCredential.user?.displayName}");
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCC6D7F),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signInWithGoogle(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: const StadiumBorder(),
            minimumSize: const Size(200, 60),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/icons/image.png', width: 24, height: 24),
              const SizedBox(width: 10),
              const Text(
                'Iniciar sesión con Google',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
