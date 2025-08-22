import '../repositories/auth_repository.dart';

class RecuperarPasswordUseCase {
  final AuthRepository repository;

  RecuperarPasswordUseCase(this.repository);

  Future<void> call(String email) {
    return repository.recuperarPassword(email);
  }
}