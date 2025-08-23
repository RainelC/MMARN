import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/constants/app_colors.dart';

class HomeBtns extends StatelessWidget {
  const HomeBtns({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
    );
  }
}
