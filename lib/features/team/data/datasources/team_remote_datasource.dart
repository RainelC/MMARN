import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/features/team/data/models/miembro_team_model.dart';

abstract class TeamRemoteDatasource {
  Future<List<MiembroTeamModel>> getTeam({String? departamento});
}

class TeamRemoteDataSourceImpl implements TeamRemoteDatasource {
  final http.Client client;
  static const String baseUrl = 'https://adamix.net/medioambiente';

  TeamRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MiembroTeamModel>> getTeam({String? departamento}) async {
    String url = '$baseUrl/equipo';

    if (departamento != null && departamento.isNotEmpty) {
      url += '?departamento=${Uri.encodeComponent(departamento)}';
    }

    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => MiembroTeamModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener el equipo: ${response.statusCode}');
    }
  }
}