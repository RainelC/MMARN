import '../entities/change_password_request_entity.dart';

abstract class PasswordRepository {
  Future<void> cambiarPassword(ChangePasswordRequestEntity request);
}