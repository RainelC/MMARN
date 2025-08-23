import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/normatives/data/repositories/normative_repository.dart';
import 'package:mmarn/features/normatives/domain/entities/normative_entity.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';

class NormativesScreen extends StatefulWidget {
  const NormativesScreen({super.key});

  @override
  State<NormativesScreen> createState() => _NormativesScreenState();
}

class _NormativesScreenState extends State<NormativesScreen> {
  final NormativeRepository _repository= NormativeRepository();
  late Future<List<Normative>> _futureNormatives;

  @override
  void initState() {
    super.initState();
    _futureNormatives = _repository.getNormatives();
  }

  Future<void> _openDocument(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Normativas Ambientales', style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: FutureBuilder<List<Normative>>(
        future: _futureNormatives,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay normativas disponibles.'));
          }

          final normatives = snapshot.data!;

          return ListView.builder(
            itemCount: normatives.length,
            itemBuilder: (context, index) {
              final n = normatives[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: ListTile(
                  title: Text(n.titulo),
                  subtitle: Text('${n.tipo} - ${n.numero}\nPublicado: ${n.fechaPublicacion}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    onPressed: () => _openDocument(n.urlDocumento),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/normative'),
    );
  }
}
