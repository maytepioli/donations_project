import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // User canceled login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Check if user already exists in Firestore
        DocumentSnapshot userDoc = await _firestore.collection("users").doc(user.uid).get();

        if (!userDoc.exists) {
          // If new user, save their details
          await _firestore.collection("users").doc(user.uid).set({
            "uid": user.uid,
            "name": user.displayName,
            "email": user.email,
            "isCentro": 0, // Default value
            "telefono": 0 
          });
        }
      }

      return user;
    } catch (e) {
      print("Google sign-in error: $e");
      return null;
    }
  }

  // Function to check if a user is a donation center
  Future<int> isUserDonationCenter(String uid) async {
    DocumentSnapshot userDoc = await _firestore.collection("users").doc(uid).get();
    if (userDoc.exists) {
      return userDoc["isCentro"] ?? false;
    }
    return 0;
  }

  // Sign out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}