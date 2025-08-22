import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.nombre,
    super.token,
    super.refreshToken,
    super.fechaExpiracion,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      nombre: json['nombre'] ?? '',
      token: json['token'],
      refreshToken: json['refresh_token'],
      fechaExpiracion: json['fecha_expiracion'] != null
          ? DateTime.parse(json['fecha_expiracion'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'nombre': nombre,
      'token': token,
      'refresh_token': refreshToken,
      'fecha_expiracion': fechaExpiracion?.toIso8601String(),
    };
  }
}