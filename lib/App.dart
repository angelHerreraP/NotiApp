import 'package:flutter/material.dart';

import 'Menu/bottom_menu.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;
  BNavigator? myBNB;

  @override
  void initState() {
    super.initState();
    myBNB = BNavigator(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias App'),
      ),
      body: Routes(index: index), // Cuerpo dinámico basado en el índice
      bottomNavigationBar: myBNB, // Barra de navegación inferior
    );
  }
}

class Routes extends StatelessWidget {
  final int index;

  const Routes({required this.index});

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0: // Noticias Generales
        return ListView(
          children: const [
            NewsCard(
              title: 'Titular General 1',
              content: 'Resumen breve de la noticia general 1.',
              imageUrl: 'https://via.placeholder.com/150',
            ),
            NewsCard(
              title: 'Titular General 2',
              content: 'Resumen breve de la noticia general 2.',
              imageUrl: 'https://via.placeholder.com/150',
            ),
          ],
        );
      case 1: // Deportes
        return ListView(
          children: const [
            NewsCard(
              title: 'Noticias de Deportes 1',
              content: 'Resumen breve de la noticia de deportes 1.',
              imageUrl: 'https://via.placeholder.com/150',
            ),
            NewsCard(
              title: 'Noticias de Deportes 2',
              content: 'Resumen breve de la noticia de deportes 2.',
              imageUrl: 'https://via.placeholder.com/150',
            ),
          ],
        );
      case 2: // Cultura / Ciencia
        return ListView(
          children: const [
            NewsCard(
              title: 'Cultura y Ciencia 1',
              content: 'Resumen breve de la noticia de cultura/ciencia 1.',
              imageUrl: 'https://via.placeholder.com/150',
            ),
            NewsCard(
              title: 'Cultura y Ciencia 2',
              content: 'Resumen breve de la noticia de cultura/ciencia 2.',
              imageUrl: 'https://via.placeholder.com/150',
            ),
          ],
        );
      default:
        return Center(
          child: Text('Sección no encontrada'),
        );
    }
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;

  const NewsCard({
    required this.title,
    required this.content,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Más información'),
            ),
          ],
        ),
      ),
    );
  }
}
