class ChangePasswordRequestEntity {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordRequestEntity({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  bool get passwordsMatch => newPassword == confirmPassword;

  bool get isValidNewPassword {
    return newPassword.length >= 8 &&
        newPassword.contains(RegExp(r'[A-Z]')) &&
        newPassword.contains(RegExp(r'[a-z]')) &&
        newPassword.contains(RegExp(r'[0-9]'));
  }
}