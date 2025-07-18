import 'package:flutter/material.dart';
import '../../features/auth/view/LoginScreen.dart';
import '../../features/auth/view/ResetpassScreen.dart';
import '../../features/auth/view/SignupScreen.dart';
import '../../features/weather/view/HomeScreen.dart';


class AppRoutes {
  static const String login = '/login';
  static const String signup = '/signup';
  static const String resetpass = '/resetpass';
  static const String home = '/home';

  static Map<String, WidgetBuilder> configureRoutes() {
    return {
      login: (context) => LoginScreen(),
      signup: (context) => SignupScreen(),
      resetpass: (context) => ResetPassScreen(),
      home: (context) => HomeScreen()
    };
  }
}