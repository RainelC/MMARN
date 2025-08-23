import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/core/storage/secure_storage_service.dart';
import 'package:mmarn/features/users/data/repositories/auth_repository_impl.dart';

class BottomNavBar extends StatelessWidget {
  final String currentRoute;

  const BottomNavBar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: AuthRepositoryImpl(SecureStorageService()).isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(height: 70);
          }

          final isLoggedIn = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if(!isLoggedIn) ...[
                        _buildNavItem(context, Icons.home, 'Inicio', '/home'),
                        _buildNavItem(context, Icons.home_work, 'Servicios', '/services'),
                        _buildNavItem(context, Icons.article, 'Noticias', '/news'),
                        _buildNavItem(context, Icons.park, 'Áreas', '/protected'),
                        _buildNavItem(context, Icons.volunteer_activism, 'Voluntariado', '/volunteering'),
                      ] else ...[
                        _buildNavItem(context, Icons.home, 'Inicio', '/home'),
                        _buildNavItem(context, Icons.rule, 'Normativas', '/normative'),
                        _buildNavItem(context, Icons.report, 'Reportar', '/report'),
                        _buildNavItem(context, Icons.assignment, 'Mis Reportes', '/my_reports'),
                        _buildNavItem(context, Icons.fmd_bad, 'Mapa Reportes', '/map_report'),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, String route) {
    final isSelected = currentRoute == route;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.go(route);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? AppColors.primaryColor : Colors.white, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primaryColor : Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
