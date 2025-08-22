import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/features/team/domain/entities/miembro_entity.dart';

class TeamRepository {
  final String apiUrl = 'https://adamix.net/medioambiente/equipo';

  @override
  Future<List<MiembroEntity>> getTeam({String? departamento}) async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => MiembroEntity.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar equipo: ${response.body}');
    }
  }
}