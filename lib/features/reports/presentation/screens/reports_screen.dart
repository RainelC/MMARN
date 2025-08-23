import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/reports/data/repositories/reports_repository.dart';
import 'package:mmarn/features/reports/domain/entities/report_entity.dart';
import 'package:mmarn/features/reports/presentation/screens/report_detail_screen.dart' show ReportDetailScreen;
import 'package:mmarn/shared/widgets/bottom_navbar.dart';

import '../widgets/reports_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
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
      appBar: AppBar(title: const Text('Mis Reportes', style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
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

          return ListView.builder(
            itemCount: reports.length,
            itemBuilder: (context, index) {
              final report = reports[index];
              return ReportsCard(report: report, onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReportDetailScreen(report: report),
                  ),
                );
              },);
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/my_reports'),
    );
  }
}
