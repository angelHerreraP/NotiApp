import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noticias App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias App'),
      ),
      body: ListView(
        children: [
          NewsCard(
            title: 'Título de la Noticia',
            content: 'Contenido breve de la noticia.',
            imageUrl: 'https://via.placeholder.com/150',
          ),
          NewsCard(
            title: 'Otra Noticia',
            content: 'Descripción de otra noticia.',
            imageUrl: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    );
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
              onPressed: () {
                
              },
              child: Text('More Info'),
            ),
          ],
        ),
      ),
    );
  }
}
