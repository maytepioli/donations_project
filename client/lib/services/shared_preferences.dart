import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  // Store user data in SharedPreferences
  static Future<void> storeUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save each data field in SharedPreferences, ensuring the correct types
    prefs.setString('uid', userData['uid']);
    prefs.setInt('telefono', userData['telefono']); // Store as int
    prefs.setInt('isCentro', userData['isCentro']); // Store as int
  }

  // Retrieve user data from SharedPreferences
  static Future<Map<String, dynamic>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve data from SharedPreferences, and use default values if not found
    String uid = prefs.getString('uid') ?? '';
    int telefono = prefs.getInt('telefono') ?? 0;  // Use int
    int isCentro = prefs.getInt('isCentro') ?? 0;  // Use int

    return {
      'uid': uid,
      'telefono': telefono,
      'isCentro': isCentro,
    };
  }

  // Check if user data exists in SharedPreferences
  static Future<bool> userExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('uid'); // Checks if 'userId' exists
  }

  // Clear stored user data
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('telefono');
    prefs.remove('isCentro');
  }
}
