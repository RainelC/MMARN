import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/reports/data/repositories/reports_repository.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';

import '../../domain/entities/report_entity.dart';

class ReportMapScreen extends StatefulWidget {
  const ReportMapScreen({super.key});

  @override
  State<ReportMapScreen> createState() => _ReportMapScreen();
}

class _ReportMapScreen extends State<ReportMapScreen> {
  final ReportRepository _repository= ReportRepository();
  late Future<List<Report>> _futureReports;


  @override
  void initState() {
    super.initState();
    _futureReports = _repository.getReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Reportes', style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: FutureBuilder<List<Report>>(
        future: _futureReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay reportes.'));
          }

          final reports = snapshot.data!;


          // Centro por defecto: República Dominicana
          final LatLng fallbackCenter = const LatLng(18.7357, -70.1627);
          final LatLng initialCenter = reports.isNotEmpty
              ? LatLng(reports.first.latitud, reports.first.longitud)
              : fallbackCenter;

          // Construimos los marcadores
          final markers = reports.map((report) {
            return Marker(
              width: 60,
              height: 60,
              point: LatLng(report.latitud, report.longitud),
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (_) => ReportBottomSheet(report: report),
                  );
                },
                child: const Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            );
          }).toList();

          return Scaffold(
            body: FlutterMap(
              options: MapOptions(
                initialCenter: initialCenter,
                initialZoom: 7,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                ),
                MarkerLayer(markers: markers),
              ],
            ),
          );
        }
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/map_report'),
    );
  }
}

class ReportBottomSheet extends StatelessWidget {
  final Report report;

  const ReportBottomSheet({super.key, required this.report});

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
              report.titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(report.fecha!),
            const SizedBox(height: 6),
            Text(report.estado!),
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