import '../entities/user_entity.dart';
import '../entities/login_request_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(LoginRequestEntity loginRequest) {
    return repository.login(loginRequest);
  }
}
