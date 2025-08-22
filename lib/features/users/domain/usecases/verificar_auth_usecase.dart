import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class VerificarAuthUseCase {
  final AuthRepository repository;

  VerificarAuthUseCase(this.repository);

  Future<UserEntity?> obtenerUsuarioActual() {
    return repository.obtenerUsuarioActual();
  }

  Future<bool> estaAutenticado() {
    return repository.estaAutenticado();
  }
}