import '../../domain/entities/user_entity.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/login_request_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<UserEntity> login(LoginRequestEntity loginRequest) async {
    try {
      final loginModel = LoginRequestModel(
        email: loginRequest.email,
        password: loginRequest.password,
      );

      final userModel = await remoteDataSource.login(loginModel);

      // Guardar usuario localmente
      await localDataSource.guardarUsuario(userModel);

      return userModel;
    } catch (e) {
      throw Exception('Error en login: $e');
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.eliminarUsuario();
  }

  @override
  Future<void> recuperarPassword(String email) async {
    await remoteDataSource.recuperarPassword(email);
  }

  @override
  Future<UserEntity?> obtenerUsuarioActual() async {
    return await localDataSource.obtenerUsuario();
  }

  @override
  Future<bool> estaAutenticado() async {
    final user = await localDataSource.obtenerUsuario();
    return user != null && user.isTokenValid;
  }
}