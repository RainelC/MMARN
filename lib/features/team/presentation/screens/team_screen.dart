import 'package:flutter/material.dart';
import 'package:mmarn/features/team/data/repositories/team_repository_impl.dart';
import 'package:mmarn/features/team/domain/usecases/get_team_usecase.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import '../../domain/entities/miembro_entity.dart';
import '../widgets/miembro_team_card.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late final GetTeamUseCase _getEquipoUseCase;
  late Future<List<MiembroEntity>> _teamFuture;
  String? _departamentoSeleccionado;

  @override
  void initState() {
    super.initState();
    _getEquipoUseCase = GetTeamUseCase(TeamRepository());
    _loadTeam();
  }

  void _loadTeam() {
    _teamFuture = _getEquipoUseCase();
  }

  Future<void> _refresh() async {
    _loadTeam();
    setState(() {});
  }

  List<MiembroEntity> _applyFilter(List<MiembroEntity> team) {
    if (_departamentoSeleccionado == null) return team;
    return team.where((m) => m.departamento == _departamentoSeleccionado).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipo del Ministerio'),
        actions: [
          PopupMenuButton<String?>(
            icon: const Icon(Icons.filter_alt),
            onSelected: (departamento) {
              setState(() {
                _departamentoSeleccionado = departamento;
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<String?>>[
              const PopupMenuItem<String?>(
                value: null,
                child: Row(
                  children: [
                    Icon(Icons.clear),
                    SizedBox(width: 8),
                    Text('Todos los departamentos'),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              ...['Dirección General', 'Subdirección', 'Comunicación'] // ejemplo de departamentos
                  .map((dept) => PopupMenuItem<String?>(
                value: dept,
                child: Row(
                  children: [
                    Icon(
                      _departamentoSeleccionado == dept
                          ? Icons.radio_button_checked
                          : Icons.radio_button_unchecked,
                    ),
                    const SizedBox(width: 8),
                    Text(dept),
                  ],
                ),
              )),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<MiembroEntity>>(
        future: _teamFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  const Text('Error al cargar el equipo'),
                  const SizedBox(height: 8),
                  Text(snapshot.error.toString(), textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _refresh,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          final team = _applyFilter(snapshot.data ?? []);

          if (team.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  const Text('No hay miembros del equipo'),
                  if (_departamentoSeleccionado != null) ...[
                    const SizedBox(height: 8),
                    Text('en $_departamentoSeleccionado'),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _departamentoSeleccionado = null;
                        });
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('Mostrar todos'),
                    ),
                  ],
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: team.length,
              itemBuilder: (context, index) {
                final miembro = team[index];
                return MiembroTeamCard(miembro: miembro);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/team'),
    );
  }
}
