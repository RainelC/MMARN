import 'package:flutter/foundation.dart';
import '../../domain/entities/change_password_request_entity.dart';
import '../../domain/usecases/cambiar_password_usecase.dart';

class ChangePasswordProvider extends ChangeNotifier {
  final CambiarPasswordUseCase cambiarPasswordUseCase;

  ChangePasswordProvider({required this.cambiarPasswordUseCase});

  bool _isLoading = false;
  String? _error;
  bool _passwordChanged = false;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get passwordChanged => _passwordChanged;

  Future<bool> cambiarPassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    _isLoading = true;
    _error = null;
    _passwordChanged = false;
    notifyListeners();

    try {
      final request = ChangePasswordRequestEntity(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      await cambiarPasswordUseCase(request);
      _passwordChanged = true;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void limpiarError() {
    _error = null;
    notifyListeners();
  }

  void resetState() {
    _error = null;
    _passwordChanged = false;
    _isLoading = false;
    notifyListeners();
  }
}