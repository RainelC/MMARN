import 'package:mmarn/features/team/domain/entities/miembro_team_entity.dart';
import 'package:mmarn/features/team/domain/repositories/team_repository.dart';

class GetTeamUsecase {
  final TeamRepository repository;

  GetTeamUsecase(this.repository);

  Future<List<MiembroTeamEntity>> call({String? departamento}) {
    return repository.getTeam(departamento: departamento);
  }
}