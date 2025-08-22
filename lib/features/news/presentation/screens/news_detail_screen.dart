import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import '../../domain/entities/news_entity.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsEntity news;

  const NewsDetailScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.titulo, style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25,) ),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (news.imagen.isNotEmpty)
                Image.network(
                  news.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                        Icons.broken_image,
                        size: 100,
                        color: Colors.grey);
                  },),
              const SizedBox(height: 16),
              Text(news.titulo,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(news.contenido, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 12),
              Text("Fecha de publicación: ${news.fecha}",
                  style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
