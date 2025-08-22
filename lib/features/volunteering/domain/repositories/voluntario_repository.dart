import '../entities/voluntario_entity.dart';

abstract class VoluntarioRepository {
  Future<void> enviarVoluntario(VoluntarioEntity voluntario);
}
