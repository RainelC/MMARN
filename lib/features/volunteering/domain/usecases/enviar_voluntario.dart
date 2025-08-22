import '../repositories/voluntario_repository.dart';
import '../entities/voluntario_entity.dart';

class EnviarVoluntario {
  final VoluntarioRepository repository;

  EnviarVoluntario(this.repository);

  Future<void> call(VoluntarioEntity voluntario) async {
    return repository.enviarVoluntario(voluntario);
  }
}
