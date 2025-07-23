import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather/features/weather/viewmodel/weather_viewmodel.dart';
import 'features/training/viewmodel/training_viewmodel.dart';
import 'features/training/service/training_service.dart';
import 'features/training/usecase/training_usecase.dart';
import 'core/Routing/routing.dart';
import 'features/auth/viewmodel/auth_viewmodel.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyDs6EHU0Ys0fv0BiBclpnW4vmsJNPYUM6w",
    authDomain: "weather-app-b6d4a.firebaseapp.com",
    projectId: "weather-app-b6d4a",
    storageBucket: "weather-app-b6d4a.firebasestorage.app",
    messagingSenderId: "898603372668",
    appId: "weather-app-b6d4a"),
  );
  // test user email : youssefmt735@gmail.com
  //test user pass: Test123
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => Training(TrainingUsecase(TrainingService()))),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather app',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.login,
        routes: AppRoutes.configureRoutes(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
    );
  }
}