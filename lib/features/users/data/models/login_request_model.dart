import '../../domain/entities/login_request_entity.dart';

class LoginRequestModel extends LoginRequestEntity {
  const LoginRequestModel({
    required super.correo,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'password': password,
    };
  }
}