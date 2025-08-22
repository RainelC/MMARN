import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> guardarUsuario(UserModel user);
  Future<UserModel?> obtenerUsuario();
  Future<void> eliminarUsuario();
  Future<bool> tieneUsuarioGuardado();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  static const String _userKey = 'user_data';

  @override
  Future<void> guardarUsuario(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = json.encode(user.toJson());
    await prefs.setString(_userKey, userJson);
  }

  @override
  Future<UserModel?> obtenerUsuario() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final userMap = json.decode(userJson);
        return UserModel.fromJson(userMap);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> eliminarUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  @override
  Future<bool> tieneUsuarioGuardado() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }
}
