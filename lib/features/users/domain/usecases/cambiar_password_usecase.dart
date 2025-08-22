import 'package:mmarn/features/users/data/repositories/password_repository.dart';

import '../entities/change_password_request_entity.dart';

class CambiarPasswordUseCase {
  final PasswordRepository repository;

  CambiarPasswordUseCase(this.repository);

  Future<void> call(ChangePasswordRequestEntity request) async {
    if (!request.passwordsMatch) {
      throw Exception('Las contraseñas no coinciden');
    }

    if (!request.isValidNewPassword) {
      throw Exception('La nueva contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas y números');
    }

    if (request.currentPassword == request.newPassword) {
      throw Exception('La nueva contraseña debe ser diferente a la actual');
    }

    // return repository.changePassword(request, token);
  }
}