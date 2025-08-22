import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mmarn/features/team/presentation/providers/equipo_provider.dart';
import 'package:mmarn/features/team/presentation/widgets/miembro_team_card.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _EquipoScreenState();
}

class _EquipoScreenState extends State<TeamScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeamProvider>().loadTeam();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipo del Ministerio'),
        elevation: 0,
        actions: [
          Consumer<TeamProvider>(
            builder: (context, provider, child) {
              return PopupMenuButton<String?>(
                icon: const Icon(Icons.filter_alt),
                onSelected: (departamento) {
                  if (departamento == null) {
                    provider.cleanFilter();
                  } else {
                    provider.filterByDepartamento(departamento);
                  }
                },
                itemBuilder: (context) {
                  final items = <PopupMenuEntry<String?>>[
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
                  ];

                  for (final dept in provider.departamentos) {
                  items.add(
                  PopupMenuItem<String?>(
                  value: dept,
                  child: Row(
                  children: [
                  Icon(
                  provider.departamentoSeleccionado == dept
                  ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  ),
                  const SizedBox(width: 8),
                  Flexible(child: Text(dept)),
                  ],
                  ),
                  ),
                  );
                  }

                  return items;
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<TeamProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar el equipo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[700],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      provider.error!,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => provider.loadTeam(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          }

          if (provider.Team.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.people_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay miembros del equipo',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                  if (provider.departamentoSeleccionado != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'en ${provider.departamentoSeleccionado}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton.icon(
                      onPressed: provider.cleanFilter,
                      icon: const Icon(Icons.clear),
                      label: const Text('Mostrar todos'),
                    ),
                  ],
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadTeam(
              departamento: provider.departamentoSeleccionado,
            ),
            child: Column(
              children: [
                // Header con información del filtro
                if (provider.departamentoSeleccionado != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    color: Colors.blue[50],
                    child: Row(
                      children: [
                        Icon(Icons.filter_alt, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Mostrando: ${provider.departamentoSeleccionado}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: provider.cleanFilter,
                          child: const Text('Limpiar'),
                        ),
                      ],
                    ),
                  ),
                // Lista de miembros
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: provider.Team.length,
                    itemBuilder: (context, index) {
                      final miembro = provider.Team[index];
                      return MiembroTeamCard(miembro: miembro);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}