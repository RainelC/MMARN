import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/video_entity.dart';

class VideoRepository {
  final String apiUrl = "https://adamix.net/medioambiente/videos";

  Future<List<VideoEntity>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => VideoEntity.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar los videos educativos");
    }
  }
}
