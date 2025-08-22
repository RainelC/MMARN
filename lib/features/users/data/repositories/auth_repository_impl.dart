import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/core/storage/secure_storage_service.dart';
import 'package:mmarn/features/users/domain/repository/auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../models/login_request_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = 'https://adamix.net/medioambiente/auth';
  final SecureStorageService storage;

  AuthRepositoryImpl(this.storage);

  @override
  Future<UserEntity> login(LoginRequestModel loginRequest) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(jsonEncode(loginRequest.toJson())),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Guardar token si existe
      if (jsonResponse['token'] != null) {
        await storage.saveToken(jsonResponse['token']);
      }

      return UserModel.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      throw Exception('Credenciales incorrectas');
    } else if (response.statusCode == 422) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Datos inválidos');
    } else {
      throw Exception('Error del servidor: ${response.statusCode}');
    }
  }

  @override
  Future<void> recoverPassword(String correo) async {
    final response = await http.post(
      Uri.parse('$baseUrl/recover'),
      headers: {'Content-Type': 'application/json'},
      body: utf8.encode(jsonEncode({'correo': correo})),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Error al enviar email de recuperación');
    }
  }

  @override
  Future<void> logout() async {
    await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Content-Type': 'application/json'},
    );

    // Eliminar token local
    await storage.deleteToken();
  }
}
