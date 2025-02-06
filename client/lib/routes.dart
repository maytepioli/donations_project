import 'views/donations/donations.dart';
import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/profile/profile.dart';
import 'views/object/object.dart';
import 'views/register/register.dart'; // Ensure this import is correct and the Register class is defined in this file

var appRoutes = {
  '/': (context) => Home(),
  '/login': (context) => Login(),
  '/donations': (context) => DonationsScreen(),
  '/register': (context) => Register(),
  '/object': (context) => ObjectScreen(),
  '/profile': (context) => ProfileScreen(),
};
