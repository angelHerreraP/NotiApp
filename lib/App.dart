import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Menu/bottom_menu.dart';
import 'NewsService.dart'; // Asegúrate de que esta importación sea correcta

class NewsCard extends StatelessWidget {
  final String title;
  final String content;
  final String imageUrl;
  final String newsUrl; // Añadir una propiedad para la URL de la noticia

  const NewsCard({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.newsUrl, // Asegúrate de que esta propiedad esté requerida
    Key? key,
  }) : super(key: key);

  // Función para abrir la URL en el navegador
  void _launchURL() async {
    if (await canLaunch(newsUrl)) {
      await launch(newsUrl);
    } else {
      throw 'No se pudo abrir $newsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              content,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _launchURL,
              child: Text('Más Información'),
            ),
          ],
        ),
      ),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;
  BNavigator? myBNB;
  late Future<List<dynamic>> news;

  @override
  void initState() {
    super.initState();
    myBNB = BNavigator(currentIndex: (i) {
      setState(() {
        index = i;
        // Cargar noticias cada vez que cambia el índice
        news = loadNews(index);
      });
    });
    news = loadNews(index); // Cargar noticias iniciales
  }

  Future<List<dynamic>> loadNews(int index) {
    String category = '';
    switch (index) {
      case 0:
        category = 'news';
        break;
      case 1:
        category = 'sport';
        break;
      case 2:
        category = 'culture';
        break;
      default:
        category = 'news';
    }
    return NewsService().fetchNews(category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticias App'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: news,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay noticias disponibles.'));
          }

          // Asegúrate de que estás accediendo a los campos correctos
          final newsArticles = snapshot.data!;
          return ListView.builder(
            itemCount: newsArticles.length,
            itemBuilder: (context, index) {
              final article = newsArticles[index];
              final title = article['webTitle'] ?? 'Sin título';
              final content =
                  article['fields']?['trailText'] ?? 'Sin contenido';
              final imageUrl = article['fields']?['thumbnail'] ??
                  'https://via.placeholder.com/150';
              final newsUrl = article['webUrl'] ?? '';

              return NewsCard(
                title: title,
                content: content,
                imageUrl: imageUrl,
                newsUrl: newsUrl,
              );
            },
          );
        },
      ),
      bottomNavigationBar: myBNB,
    );
  }
}
