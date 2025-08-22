import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/features/areas/domain/entities/area_protegida_entity.dart';

class AreasRepository {
  final String apiUrl = "https://adamix.net/medioambiente/areas_protegidas";

  Future<List<AreaProtegidaEntity>> fetchAreas({String? busqueda, String? tipo}) async {
    final Map<String, String> params = {};
    if (busqueda != null && busqueda.isNotEmpty) params['busqueda'] = busqueda;
    if (tipo != null && tipo.isNotEmpty) params['tipo'] = tipo;

    final uri = Uri.parse(apiUrl).replace(queryParameters: params);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => AreaProtegidaEntity.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar las áreas protegidas");
    }
  }
}
