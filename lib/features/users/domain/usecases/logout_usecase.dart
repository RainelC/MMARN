import 'package:mmarn/features/users/data/repositories/auth_repository_impl.dart';
import 'package:mmarn/features/users/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
