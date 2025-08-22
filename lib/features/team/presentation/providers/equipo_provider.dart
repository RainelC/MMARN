import 'package:flutter/foundation.dart';
import '../../domain/entities/miembro_team_entity.dart';
import '../../domain/usecases/get_Team_usecase.dart';

class TeamProvider extends ChangeNotifier {
  final GetTeamUsecase getTeamUseCase;

  TeamProvider({required this.getTeamUseCase});

  List<MiembroTeamEntity> _Team = [];
  bool _isLoading = false;
  String? _error;
  String? _departamentoSeleccionado;

  List<MiembroTeamEntity> get Team => _Team;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get departamentoSeleccionado => _departamentoSeleccionado;

  List<String> get departamentos {
    final depts = _Team.map((m) => m.departamento).toSet().toList();
    depts.sort();
    return depts;
  }

  Future<void> loadTeam({String? departamento}) async {
    _isLoading = true;
    _error = null;
    _departamentoSeleccionado = departamento;
    notifyListeners();

    try {
      _Team = await getTeamUseCase(departamento: departamento);
      _Team.sort((a, b) => a.orden.compareTo(b.orden));
    } catch (e) {
      _error = e.toString();
      _Team = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterByDepartamento(String? departamento) {
    loadTeam(departamento: departamento);
  }

  void cleanFilter() {
    loadTeam();
  }
}