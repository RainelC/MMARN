import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/areas/data/repositories/areas_repository.dart';
import 'package:mmarn/features/areas/presentation/screens/areas_map_screen.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import '../../domain/entities/area_protegida_entity.dart';
import '../widgets/area_card.dart';
import 'area_detail_screen.dart';

class AreasScreen extends StatefulWidget {
  const AreasScreen({super.key});

  @override
  State<AreasScreen> createState() => _AreasScreenState();
}

class _AreasScreenState extends State<AreasScreen> {
  final AreasRepository _repository = AreasRepository();
  late Future<List<AreaProtegidaEntity>> _futureAreas;
  List<AreaProtegidaEntity> _loadedAreas = [];

  String searchQuery = '';
  String tipoFilter = '';

  @override
  void initState() {
    super.initState();
    _loadAreas();
    _loadAreas();
  }

  void _loadAreas() {
    _futureAreas = _repository.fetchAreas(busqueda: searchQuery, tipo: tipoFilter);
    _futureAreas.then((areas) {
      setState(() {
        _loadedAreas = areas;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Áreas Protegidas" , style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Buscar área protegida",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                      _loadAreas();
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: tipoFilter.isEmpty ? null : tipoFilter,
                  hint: const Text("Tipo"),
                  items: const [
                    DropdownMenuItem(value: 'todos', child: Text("Todos")),
                    DropdownMenuItem(value: "parque_nacional", child: Text("Parque Nacional")),
                    DropdownMenuItem(value: "reserva_cientifica", child: Text("Reserva Científica")),
                    DropdownMenuItem(value: "monumento_natural", child: Text("Monumento Natural")),
                    DropdownMenuItem(value: "refugio_vida_silvestre", child: Text("Refugio de Vida Silvestre")),
                  ],
                  onChanged: (value) {
                    tipoFilter = (value == 'todos') ? '' : (value ?? '');
                    _loadAreas();
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<AreaProtegidaEntity>>(
              future: _futureAreas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                final areas = snapshot.data ?? [];
                if (areas.isEmpty) {
                  return const Center(child: Text("No hay áreas protegidas disponibles"));
                }

                return ListView.builder(
                  itemCount: areas.length,
                  itemBuilder: (context, index) {
                    final area = areas[index];
                    return AreaCard(
                      area: area,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AreaDetailScreen(area: area),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.map, color: AppColors.primaryColor,size: 25,),
        label: const Text("Ver en Mapa",style: TextStyle(color: AppColors.primaryColor, fontSize: 18)),
        onPressed: () {
          if (_loadedAreas.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AreasMapScreen(areas: _loadedAreas),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No hay áreas cargadas para mostrar en el mapa")),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavBar(currentRoute: '/protected'),
    );
  }
}
