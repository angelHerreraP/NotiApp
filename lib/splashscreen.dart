import 'package:flutter/material.dart';
import 'package:noticias_app/Menu/noticias.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      body: Center(
        child: Image.asset(
          'assets/images/nohayfoto.png',
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
