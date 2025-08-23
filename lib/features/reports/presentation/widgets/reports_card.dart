import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mmarn/features/reports/domain/entities/report_entity.dart';

class ReportsCard extends StatelessWidget {
  final Report report;
  final VoidCallback? onTap;

  const ReportsCard({super.key, required this.report, this.onTap});

  @override
  Widget build(BuildContext context) {
    Uint8List fotoBase64;
    try{
      fotoBase64 = base64Decode(report.foto.replaceAll('data:image/jpeg;base64,', ''));
    }catch(e){
      fotoBase64 = Uint8List(0);
      print(e);
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (report.foto.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.memory(
                  fotoBase64,
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
                  Text(report.titulo,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(report.estado!, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}