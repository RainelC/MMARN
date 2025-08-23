import 'package:mmarn/features/users/domain/entities/change_password_request_entity.dart';

class ChangePasswordRequestModel extends ChangePasswordRequestEntity {
  const ChangePasswordRequestModel({
    required super.correo,
    required super.codigo,
    required super.nuevaPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'correo': correo,
      'codigo': codigo,
      'nueva_password': nuevaPassword,
    };
  }
}
