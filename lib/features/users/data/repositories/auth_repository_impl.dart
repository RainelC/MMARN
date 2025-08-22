import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/login_request_model.dart';

class AuthRepository {
  final String baseUrl = 'https://adamix.net/medioambiente/auth';

  Future<UserModel> login(LoginRequestModel loginRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(json.encode(loginRequest.toJson())),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return UserModel.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      throw Exception(utf8.encode(json.encode(loginRequest.toJson())));
    } else if (response.statusCode == 422) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Datos inválidos');
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }

  Future<void> recoverPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recover-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      final error = json.decode(response.body);
      throw Exception(
          error['message'] ?? 'Error al enviar email de recuperación');
    }
  }

  Future<void> logout() async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Content-Type': 'application/json'},
    );
  }
}