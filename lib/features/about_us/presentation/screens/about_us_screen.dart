import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/core/constants/app_texts.dart';
import 'package:mmarn/features/about_us/domain/entities/section_entity.dart';
import 'package:mmarn/features/about_us/presentation/widgets/section_widget.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  late YoutubePlayerController _controller;
  late String videoId = 'HehRqnpesDc';

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        loop: true,
        autoPlay: false,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);

    final sections = [
      SectionEntity(title: "Historia", content:AppTexts.historia),
      SectionEntity(title: "Misión", content:AppTexts.mision),
      SectionEntity(title: "Visión", content:AppTexts.vision),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Sobre Nosotros", style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 25, ),)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            YoutubePlayer(controller: _controller, showVideoProgressIndicator: true),
            ...sections.map((s) => Section(section: s)).toList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: '/about_us')
    );
  }
}
