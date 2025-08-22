import '../../domain/entities/voluntario_entity.dart';
import '../../domain/repositories/voluntario_repository.dart';
import '../datasources/voluntario_remote_source.dart';

class VoluntarioRepositoryImpl implements VoluntarioRepository {
  final VoluntarioRemoteDataSource remoteDataSource;

  VoluntarioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> enviarVoluntario(VoluntarioEntity voluntario) {
    return remoteDataSource.enviarVoluntario(voluntario);
  }
}
