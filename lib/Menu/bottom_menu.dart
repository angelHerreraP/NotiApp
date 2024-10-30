import 'package:flutter/material.dart';

class BNavigator extends StatefulWidget {
  final Function currentIndex;
  const BNavigator({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<BNavigator> createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigator> {
  // Variable para el índice seleccionado
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // Navigation bar ya es algo pre-hecho
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor:
          Colors.black, // Color del ícono y etiqueta seleccionados
      unselectedItemColor:
          Colors.black54, // Color del ícono y etiqueta no seleccionados
      selectedFontSize: 15,
      unselectedFontSize: 12,
      onTap: (int i) {
        setState(() {
          index = i;
          widget.currentIndex(i);
        });
      },
      type: BottomNavigationBarType.fixed, // Mantiene los íconos visibles
      items: const [
        // El item es básicamente cada botón
        BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'News'),
        BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Culture'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
