import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/change_password_request_model.dart';

abstract class PasswordRemoteDataSource {
  Future<void> cambiarPassword(ChangePasswordRequestModel request, String token);
}

class PasswordRemoteDataSourceImpl implements PasswordRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://adamix.net/medioambiente/auth';

  PasswordRemoteDataSourceImpl({required this.client});

  @override
  Future<void> cambiarPassword(ChangePasswordRequestModel request, String token) async {
    final response = await client.post(
      Uri.parse('$baseUrl/change-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return; // Éxito
    } else if (response.statusCode == 401) {
      throw Exception('Tu sesión ha expirado. Inicia sesión nuevamente');
    } else if (response.statusCode == 422) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Datos inválidos');
    } else if (response.statusCode == 400) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Contraseña actual incorrecta');
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }
}
