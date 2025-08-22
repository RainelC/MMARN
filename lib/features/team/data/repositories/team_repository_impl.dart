import 'package:mmarn/features/team/data/datasources/team_remote_datasource.dart';
import 'package:mmarn/features/team/domain/entities/miembro_team_entity.dart';
import 'package:mmarn/features/team/domain/repositories/team_repository.dart';

class TeamRepositoryImpl implements TeamRepository {
  final TeamRemoteDatasource remoteDataSource;

  TeamRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MiembroTeamEntity>> getTeam({String? departamento}) async {
    try {
      final equipoModels = await remoteDataSource.getTeam(
        departamento: departamento,
      );
      return equipoModels;
    } catch (e) {
      throw Exception('Error en el repositorio: $e');
    }
  }
}