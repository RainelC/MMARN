import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/features/measures/data/repositories/measure_service.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import '../../domain/entities/measure_entity.dart';
import 'measure_detail_screen.dart';

class MeasuresScreen extends StatefulWidget {
  const MeasuresScreen({super.key});

  @override
  State<MeasuresScreen> createState() => _MeasuresScreenState();
}

class _MeasuresScreenState extends State<MeasuresScreen> {
  final MeasureService _service = MeasureService();
  late Future<List<MeasureEntity>> _futureMeasures;

  @override
  void initState() {
    super.initState();
    _futureMeasures = _service.getMeasures();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String currentRoute = state.uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Medidas Ambientales")),
      body: FutureBuilder<List<MeasureEntity>>(
        future: _futureMeasures,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay medidas disponibles"));
          }
          final measures = snapshot.data!;
          return ListView.builder(
            itemCount: measures.length,
            itemBuilder: (context, index) {
              final measure = measures[index];
              return ListTile(
                leading: Text(measure.icono, style: const TextStyle(fontSize: 24)),
                title: Text(measure.titulo),
                subtitle: Text(measure.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MeasureDetailScreen(measure: measure),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),

    );
  }
}
