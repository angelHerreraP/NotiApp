import 'package:flutter/material.dart';

import 'splashscreen.dart'; // Importa tu SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Cambia a SplashScreen
    );
  }
}
