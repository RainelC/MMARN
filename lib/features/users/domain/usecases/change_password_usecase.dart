import 'package:mmarn/features/users/data/models/change_password_request_model.dart';
import 'package:mmarn/features/users/data/repositories/password_repository.dart';

class ChangePasswordUseCase {
  final PasswordRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call(ChangePasswordRequestModel request) async {
    if (!request.isValidNewPassword) {
      throw Exception(
        'La nueva contraseña debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas y números',
      );
    }
    return repository.changePassword(request);
  }
}