import 'package:flutter_application/views/notification_donor/notification.dart';
import 'views/donations/donations.dart';
import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/profile/profile.dart';
import 'views/object/object.dart';
import 'views/register/register.dart';
import 'views/map/map.dart';
import 'views/Rol/RolPage.dart';
import 'views/donationCenter/donation_Center.dart';
import 'package:flutter_application/views/configuration/configuration.dart';

var appRoutes = {
  '/': (context) => Home(
        isCentro: false,
      ),
  '/login': (context) => Login(),
  '/donations': (context) => DonationsScreen(),
  '/register': (context) => Register(),
  '/object': (context) => ObjectScreen(),
  '/profile': (context) => ProfileScreen(),
  '/map': (context) => MapScreen(),
  '/rol': (context) => RoleSelectionPage(),
  '/notification': (context) => NotificationScreen(),
  '/donations_Center': (context) => DonationCenter(),
};
