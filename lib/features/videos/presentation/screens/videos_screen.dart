import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/videos/data/repositories/video_repository.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import '../../domain/entities/video_entity.dart';
import '../widgets/video_card.dart';
import 'video_detail_screen.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final VideoRepository _repository = VideoRepository();
  late Future<List<VideoEntity>> _futureVideos;

  @override
  void initState() {
    super.initState();
    _futureVideos = _repository.fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String currentRoute = state.uri.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Videos Educativos", style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: FutureBuilder<List<VideoEntity>>(
        future: _futureVideos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final videos = snapshot.data ?? [];
          if (videos.isEmpty) {
            return const Center(child: Text("No hay videos disponibles"));
          }

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return VideoCard(
                video: video,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoDetailScreen(video: video),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),
    );
  }
}
