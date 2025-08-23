import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/change_password_request_model.dart';

class PasswordRepository {
  final String baseUrl = 'https://adamix.net/medioambiente/auth';

  Future<void> changePassword(ChangePasswordRequestModel request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return;
    } else if (response.statusCode == 401) {
      throw Exception('Código inválido o expirado');
    } else if (response.statusCode == 422) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Datos inválidos');
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }
}
