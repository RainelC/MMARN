import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/news/data/repositories/news_repository.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import '../../domain/entities/news_entity.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _repository = NewsRepository();
  late Future<List<NewsEntity>> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = _repository.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String currentRoute = state.uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Noticias Ambientales", style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: FutureBuilder<List<NewsEntity>>(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final newsList = snapshot.data ?? [];
          if (newsList.isEmpty) {
            return const Center(child: Text("No hay noticias disponibles"));
          }

          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              final news = newsList[index];
              return NewsCard(
                news: news,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => NewsDetailScreen(news: news),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),
      floatingActionButton: ElevatedButton.icon(
        icon: const Icon(Icons.video_library, color: AppColors.primaryColor,size: 25,),
        label: const Text("Videos Educativos",style: TextStyle(color: AppColors.primaryColor, fontSize: 18)),
        onPressed: () { context.go("/news/videos"); }
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
