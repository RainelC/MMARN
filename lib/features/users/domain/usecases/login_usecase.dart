import 'package:mmarn/features/users/domain/repository/auth_repository.dart';
import '../entities/user_entity.dart';
import '../../data/models/login_request_model.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(LoginRequestModel loginRequest) {
    return repository.login(loginRequest);
  }
}
