import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String nombre,
    required String correo,
    required String token,
  }) : super(nombre: nombre, correo: correo, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
