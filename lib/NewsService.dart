import 'dart:convert';

import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '6e52572e-14b3-4aa4-8adc-dde146ed6db9'; // Tu API Key

  Future<List<dynamic>> fetchNews(String category) async {
    final response = await http.get(Uri.parse(
        'https://content.guardianapis.com/$category?api-key=$apiKey&show-fields=thumbnail'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['response']['results'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
