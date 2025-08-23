import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmarn/core/storage/secure_storage_service.dart';
import 'package:mmarn/features/reports/data/models/report_request_model.dart';
import '../../domain/entities/report_entity.dart';

class ReportRepository {
  Future<List<Report>> getReports() async {
    final response = await http.get(
        headers: {'Authorization': 'Bearer ${await SecureStorageService().getToken()}'},
        Uri.parse('https://adamix.net/medioambiente/reportes')
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Report.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar normatives");
    }
  }

  Future<void> sendReport(ReportRequestModel report) async {
    final token = await SecureStorageService().getToken();
    print("Token: $token");
    print("Report: ${report.toJson()}");
    final response = await http.post(
      Uri.parse('https://adamix.net/medioambiente/reportes'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"},
      body: jsonEncode(report.toJson()),
    );

    if (response.statusCode != 200) {
      print(response.body);
      throw Exception("Error al enviar el reporte ${response.body}");
    }
  }
}

