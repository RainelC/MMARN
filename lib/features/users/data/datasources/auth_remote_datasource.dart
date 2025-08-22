import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../models/login_request_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginRequestModel loginRequest);
  Future<void> recuperarPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://adamix.net/medioambiente/auth';

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(LoginRequestModel loginRequest) async {
    final response = await client.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(loginRequest.toJson()),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return UserModel.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      throw Exception('Credenciales inválidas');
    } else if (response.statusCode == 422) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Datos inválidos');
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }

  @override
  Future<void> recuperarPassword(String email) async {
    final response = await client.post(
      Uri.parse('$baseUrl/recover-password'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email}),
    );

    if (response.statusCode != 200) {
      final error = json.decode(response.body);
      throw Exception(error['message'] ?? 'Error al enviar email de recuperación');
    }
  }
}