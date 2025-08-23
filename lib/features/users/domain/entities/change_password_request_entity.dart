class ChangePasswordRequestEntity {
  final String correo;
  final String codigo;
  final String nuevaPassword;

  const ChangePasswordRequestEntity({
    required this.correo,
    required this.codigo,
    required this.nuevaPassword,
  });

  bool get isValidNewPassword {
    return nuevaPassword.length >= 8 &&
        nuevaPassword.contains(RegExp(r'[A-Z]')) &&
        nuevaPassword.contains(RegExp(r'[a-z]')) &&
        nuevaPassword.contains(RegExp(r'[0-9]'));
  }
}
