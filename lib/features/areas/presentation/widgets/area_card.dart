import 'package:flutter/material.dart';
import '../../domain/entities/area_protegida_entity.dart';

class AreaCard extends StatelessWidget {
  final AreaProtegidaEntity area;
  final VoidCallback? onTap;

  const AreaCard({super.key, required this.area, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (area.imagen.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                    area.imagen,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey);
                    },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(area.nombre,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(area.tipo),
                  const SizedBox(height: 4),
                  Text(area.ubicacion),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
