import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../domain/entities/area_protegida_entity.dart';

class AreasMapScreen extends StatelessWidget {
  final List<AreaProtegidaEntity> areas;

  const AreasMapScreen({super.key, required this.areas});

  @override
  Widget build(BuildContext context) {
    // Centro por defecto: República Dominicana
    final LatLng fallbackCenter = const LatLng(18.7357, -70.1627);
    final LatLng initialCenter = areas.isNotEmpty
        ? LatLng(areas.first.latitud, areas.first.longitud)
        : fallbackCenter;

    // Construimos los marcadores
    final markers = areas.map((area) {
      return Marker(
        width: 60,
        height: 60,
        point: LatLng(area.latitud, area.longitud),
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              builder: (_) => AreaBottomSheet(area: area),
            );
          },
          child: const Icon(Icons.location_on, color: Colors.red, size: 40),
        ),
      );
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Mapa de Áreas Protegidas")),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: initialCenter,
          initialZoom: 7,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            // IMPORTANTÍSIMO: pon tu package real para no ser bloqueado por OSM
            userAgentPackageName: 'com.tuempresa.tuapp',
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}

class AreaBottomSheet extends StatelessWidget {
  final AreaProtegidaEntity area;

  const AreaBottomSheet({super.key, required this.area});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              area.nombre,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text("Tipo: ${area.tipo}"),
            const SizedBox(height: 6),
            if (area.ubicacion.isNotEmpty) Text("Ubicación: ${area.ubicacion}"),
            const SizedBox(height: 12),
            Text(
              area.descripcion,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}