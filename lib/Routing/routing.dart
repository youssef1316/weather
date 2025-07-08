import 'package:flutter/material.dart';
import 'package:weather/main.dart';
import '../view/LoginScreen.dart';
import '../view/SignupScreen.dart';
import '../view/ResetPassScreen.dart';
import '../view/HomeScreen.dart';

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