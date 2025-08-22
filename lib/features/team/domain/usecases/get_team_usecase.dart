import 'package:mmarn/features/team/data/repositories/team_repository_impl.dart';
import '../../domain/entities/miembro_entity.dart';

class GetTeamUseCase {
  final TeamRepository repo;

  GetTeamUseCase(this.repo);

  Future<List<MiembroEntity>> call() async {
    return await repo.getTeam();
  }
}
