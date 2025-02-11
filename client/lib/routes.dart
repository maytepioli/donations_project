import 'package:flutter_application/views/notification/notification.dart';
import 'views/donations/donations.dart';
import 'views/home/home.dart';
import 'views/login/login.dart';
import 'views/profile/profile.dart';
import 'views/object/object.dart';
import 'views/register/register.dart';
import 'views/map/map.dart';
import 'package:flutter_application/views/configuration/configuration.dart';

var appRoutes = {
  '/': (context) => Home(),
  '/login': (context) => Login(),
  '/donations': (context) => DonationsScreen(),
  '/register': (context) => Register(),
  '/object': (context) => ObjectScreen(),
  '/profile': (context) => ProfileScreen(),
  '/map': (context) => MapScreen(),
  '/configuration': (context) => ConfigurationScreen(),
  '/notification': (context) => NotificationScreen(),
};
