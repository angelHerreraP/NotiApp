import 'package:flutter/material.dart';
import 'package:noticias_app/Menu/cultura.dart';
import 'package:noticias_app/Menu/deportes.dart';
import 'package:noticias_app/Menu/noticias.dart';

class Routes extends StatelessWidget {
  const Routes({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext contex) {
    List<Widget> myList = [
      const MainScreen(),
      const deportesScren(),
      const culturaScreen(),
    ];
    return myList[index];
  }
}
