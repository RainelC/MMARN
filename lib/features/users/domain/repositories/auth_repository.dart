import '../entities/user_entity.dart';
import '../entities/login_request_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequestEntity loginRequest);
  Future<void> logout();
  Future<void> recuperarPassword(String email);
  Future<UserEntity?> obtenerUsuarioActual();
  Future<bool> estaAutenticado();
}