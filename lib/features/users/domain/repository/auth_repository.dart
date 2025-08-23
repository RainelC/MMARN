import '../entities/user_entity.dart';
import '../../data/models/login_request_model.dart';

abstract class AuthRepository {
  Future<UserEntity> login(LoginRequestModel loginRequest);
  Future<void> recoverPassword(String email);
  Future<void> logout();
  Future<bool> isLoggedIn();
}