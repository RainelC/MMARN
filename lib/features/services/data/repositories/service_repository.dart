import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/features/services/domain/entities/service_entity.dart';

class ServicesRepository {
  final String baseUrl = "https://adamix.net/medioambiente";

  Future<List<ServiceEntity>> fetchServices() async {
    final response = await http.get(Uri.parse("$baseUrl/servicios"));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ServiceEntity.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar los servicios");
    }
  }
}
