class UserEntity {
  final String id;
  final String email;
  final String nombre;
  final String? token;
  final String? refreshToken;
  final DateTime? fechaExpiracion;

  const UserEntity({
    required this.id,
    required this.email,
    required this.nombre,
    this.token,
    this.refreshToken,
    this.fechaExpiracion,
  });

  bool get isTokenValid {
    if (token == null || fechaExpiracion == null) return false;
    return DateTime.now().isBefore(fechaExpiracion!);
  }
}