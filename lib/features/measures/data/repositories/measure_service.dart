import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/features/measures/domain/entities/measure_entity.dart';

class MeasureService {
  final String apiUrl = "https://adamix.net/medioambiente/medidas";

  Future<List<MeasureEntity>> getMeasures() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      print(data.map((json) => MeasureEntity.fromJson(json)).toList());
      return data.map((json) => MeasureEntity.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar medidas ambientales");
    }
  }
}
