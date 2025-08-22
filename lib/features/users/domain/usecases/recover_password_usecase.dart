import 'package:mmarn/features/users/domain/repository/auth_repository.dart';

class RecoverPasswordUseCase {
  final AuthRepository repository;

  RecoverPasswordUseCase(this.repository);

  Future<void> call(String correo) {
    return repository.recoverPassword(correo);
  }
}