import 'package:flutter/material.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/shared/widgets/logo_banner.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import 'package:go_router/go_router.dart';
import '../widgets/home_slider.dart';
import '../../domain/entities/message.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouterState state = GoRouterState.of(context);
    final String currentRoute = state.uri.toString();

    final messages = [
      Message(
        imageUrl: 'https://picsum.photos/800/400?image=10',
        text: 'Protege nuestros bosques y ríos',
      ),
      Message(
        imageUrl: 'https://picsum.photos/800/400?image=20',
        text: 'El Ministerio trabaja por un ambiente sostenible',
      ),
      Message(
        imageUrl: 'https://picsum.photos/800/400?image=30',
        text: 'Reciclar es un acto de amor por la Tierra',
      ),
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            LogoBanner(imageUrl: 'https://ambiente.gob.do/app/uploads/2023/06/page-logo-3-1.svg'),
            HomeSlider(messages: messages),
            const SizedBox(height: 20),

            // Botones
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Row(
                  spacing: 5,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go('/home/about'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(20, 50),
                      ),
                      child: const Text("Sobre Nosotros", style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go('/home/team'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(20, 50),
                      ),
                      child: const Text("Equipo", style: TextStyle(color: Colors.white),),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go('/home/about_team'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        minimumSize: const Size(20, 50),
                      ),
                      child: const Text("Acerca de", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
          icon: const Icon(Icons.login, color: AppColors.primaryColor,size: 25,),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
          label: const Text("Login",style: TextStyle(color: AppColors.primaryColor, fontSize: 18)),
          onPressed: () { context.go("/login"); }
      ),
      bottomNavigationBar: BottomNavBar(currentRoute: currentRoute),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
