import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/reports/domain/entities/report_entity.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    Uint8List fotoBase64;
    try{
      fotoBase64 = base64Decode(report.foto.replaceAll('data:image/jpeg;base64,', ''));
    }catch(e){
      fotoBase64 = Uint8List(0);
      print(e);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          report.titulo,
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (report.foto.isNotEmpty)
                Image.memory(
                  fotoBase64,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image,
                      size: 100,
                      color: Colors.grey,
                    );
                  },
                ),
              const SizedBox(height: 16),
              Text(
                report.titulo,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                "Código: ${report.codigo}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Text(
                report.descripcion,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                "Estado: ${report.estado}",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              if (report.comentario_ministerio!.isNotEmpty)
                Text("Comentario del Ministerio: ${report.comentario_ministerio}", style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),),
              const SizedBox(height: 12),
              Text("Fecha: ${report.fecha}", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
