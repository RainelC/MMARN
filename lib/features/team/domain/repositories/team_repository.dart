import 'package:mmarn/features/team/domain/entities/miembro_team_entity.dart';

abstract class TeamRepository {
  Future<List<MiembroTeamEntity>> getTeam({String? departamento});
}