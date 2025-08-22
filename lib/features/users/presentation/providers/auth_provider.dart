import 'package:flutter/foundation.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/entities/login_request_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/recuperar_password_usecase.dart';
import '../../domain/usecases/verificar_auth_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RecuperarPasswordUseCase recuperarPasswordUseCase;
  final VerificarAuthUseCase verificarAuthUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.recuperarPasswordUseCase,
    required this.verificarAuthUseCase,
  });

  UserEntity? _currentUser;
  bool _isLoading = false;
  String? _error;
  bool _isAuthenticated = false;
  bool _isRecoveringPassword = false;

  UserEntity? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _isAuthenticated;
  bool get isRecoveringPassword => _isRecoveringPassword;

  Future<void> inicializarAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await verificarAuthUseCase.obtenerUsuarioActual();
      _isAuthenticated = await verificarAuthUseCase.estaAutenticado();
    } catch (e) {
      _isAuthenticated = false;
      _currentUser = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final loginRequest = LoginRequestEntity(
        email: email.trim(),
        password: password,
      );

      _currentUser = await loginUseCase(loginRequest);
      _isAuthenticated = true;

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      _isAuthenticated = false;
      _currentUser = null;
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await logoutUseCase();
    } finally {
      _currentUser = null;
      _isAuthenticated = false;
      _error = null;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> recuperarPassword(String email) async {
    _isRecoveringPassword = true;
    _error = null;
    notifyListeners();

    try {
      await recuperarPasswordUseCase(email.trim());
      return true;
    } catch (e) {
      _error = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      _isRecoveringPassword = false;
      notifyListeners();
    }
  }

  void limpiarError() {
    _error = null;
    notifyListeners();
  }
}
