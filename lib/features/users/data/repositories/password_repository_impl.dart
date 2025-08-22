import 'package:mmarn/features/users/data/datasources/auth_local_datasource.dart';
import '../../domain/entities/change_password_request_entity.dart';
import '../../domain/repositories/password_repository.dart';
import '../datasources/password_remote_datasource.dart';
import '../models/change_password_request_model.dart';

class PasswordRepositoryImpl implements PasswordRepository {
  final PasswordRemoteDataSource remoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  PasswordRepositoryImpl({
    required this.remoteDataSource,
    required this.authLocalDataSource,
  });

  @override
  Future<void> cambiarPassword(ChangePasswordRequestEntity request) async {
    try {
      // Obtener el token del usuario actual
      final user = await authLocalDataSource.obtenerUsuario();
      if (user == null || user.token == null) {
        throw Exception('Usuario no autenticado');
      }

      final requestModel = ChangePasswordRequestModel(
        currentPassword: request.currentPassword,
        newPassword: request.newPassword,
        confirmPassword: request.confirmPassword,
      );

      await remoteDataSource.cambiarPassword(requestModel, user.token!);
    } catch (e) {
      throw Exception('Error al cambiar contraseña: $e');
    }
  }
}