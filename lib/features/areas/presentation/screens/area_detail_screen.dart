import 'package:flutter/material.dart';
import '../../domain/entities/area_protegida_entity.dart';

class AreaDetailScreen extends StatelessWidget {
  final AreaProtegidaEntity area;

  const AreaDetailScreen({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(area.nombre)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (area.imagen.isNotEmpty)
                Image.network(
                  area.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey);
                  },
                ),
              const SizedBox(height: 12),
              Text(area.nombre,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text("Tipo: ${area.tipo}"),
              Text("Ubicación: ${area.ubicacion}"),
              Text("Superficie: ${area.superficie}"),
              const SizedBox(height: 8),
              Text(area.descripcion, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Text("Fecha de creación: ${area.fechaCreacion}",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
