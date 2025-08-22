import 'package:flutter/material.dart';
import '../../domain/entities/measure_entity.dart';

class MeasureDetailScreen extends StatelessWidget {
  final MeasureEntity measure;

  const MeasureDetailScreen({super.key, required this.measure});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(measure.titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(measure.icono, style: const TextStyle(fontSize: 40)),
            Text(measure.categoria, style: const TextStyle(fontSize: 35)),
            const SizedBox(height: 16),
            Text(measure.descripcion, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            Text("Fecha de creación: ${measure.fechaCreacion}",
                style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
