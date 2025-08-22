import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/news_entity.dart';

class NewsRepository {
  final String apiUrl = "https://adamix.net/medioambiente/noticias";

  Future<List<NewsEntity>> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => NewsEntity.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar las noticias ambientales");
    }
  }
}
