import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/voluntario_entity.dart';

class VoluntarioRemoteDataSource {
  final String apiUrl = 'https://adamix.net/medioambiente/voluntarios';

  Future<void> enviarVoluntario(VoluntarioEntity voluntario) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(jsonEncode({
        "cedula": voluntario.cedula,
        "nombre": voluntario.nombre,
        "apellido": voluntario.apellido,
        "correo": voluntario.correo,
        "password": voluntario.password,
        "telefono": voluntario.telefono,
      })),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Error al enviar voluntario: ${response.body}');
      throw Exception('Error al enviar voluntario: ${response.body}');
    }
  }
}
