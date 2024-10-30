import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'Menu/bottom_menu.dart';

class NewsService {
  final String apiKey = '6e52572e-14b3-4aa4-8adc-dde146ed6db9';

  Future<List<dynamic>> fetchNews(String category) async {
    final queryParameters = {
      'api-key': apiKey,
      'q': 'mexico',
      'section': category,
      'show-fields': 'headline,thumbnail,short-url'
    };

    final uri =
        Uri.https('content.guardianapis.com', '/search', queryParameters);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['response']['results'];
      return results;
    } else {
      throw Exception('Error al cargar noticias');
    }
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
        title: const Text('Noticias App'),
      ),
      body: Routes(index: index), // Cuerpo dinámico basado en el índice
      bottomNavigationBar: myBNB, // Barra de navegación inferior
    );
  }
}

class Routes extends StatelessWidget {
  final int index;
  final NewsService newsService = NewsService(); // Instancia de NewsService

  Routes({required this.index});

  @override
  Widget build(BuildContext context) {
    String category = '';

    switch (index) {
      case 0:
        category = 'news'; // Noticias generales
        break;
      case 1:
        category = 'sport'; // Deportes
        break;
      case 2:
        category = 'culture'; // Cultura / Ciencia
        break;
      default:
        return Center(child: Text('Sección no encontrada'));
    }

    return FutureBuilder(
      future: newsService.fetchNews(category),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar noticias'));
        } else if (snapshot.hasData) {
          final newsList = snapshot.data!;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              final String title = news['fields']['headline'];
              final String imageUrl = news['fields']['thumbnail'] ??
                  'https://via.placeholder.com/150';
              final String url = news['webUrl'];

              return NewsCard(
                title: title,
                imageUrl: imageUrl,
                url: url,
              );
            },
          );
        } else {
          return const Center(child: Text('No se encontraron noticias'));
        }
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String url;

  const NewsCard({
    required this.title,
    required this.imageUrl,
    required this.url,
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
            const SizedBox(height: 8),
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 150,
              width: double.infinity,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Navegar al enlace de la noticia
                launchUrl(url);
              },
              child: const Text('Leer más'),
            ),
          ],
        ),
      ),
    );
  }
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se pudo abrir el enlace $url';
  }
}
