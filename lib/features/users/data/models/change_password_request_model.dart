import '../../domain/entities/change_password_request_entity.dart';

class ChangePasswordRequestModel extends ChangePasswordRequestEntity {
  const ChangePasswordRequestModel({
    required super.currentPassword,
    required super.newPassword,
    required super.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': confirmPassword,
    };
  }
}