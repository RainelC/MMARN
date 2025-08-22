import 'package:flutter/material.dart';
import 'package:mmarn/shared/widgets/bottom_navbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mmarn/core/constants/app_colors.dart';

class AboutTeamScreen extends StatelessWidget {
  const AboutTeamScreen({super.key});

  final String phoneNumber = '8295543119';
  final String telegramUrl = 'https://t.me/RainyRainNi';

  void _launchPhone() async {
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchTelegram() async {
    final uri = Uri.parse(telegramUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Acerca de", style: TextStyle(color: AppColors.primaryColor)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/rainel.png'),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              "Rainel Ramirez",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(height: 8),
          const Center(
            child: Text(
              "Matrícula: 2023-1054",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.phone, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: _launchPhone,
                  child: Text(
                    phoneNumber,
                    style: const TextStyle(fontSize: 16, decoration: TextDecoration.underline, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.telegram, color: AppColors.primaryColor),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: _launchTelegram,
                  child: Text(
                    telegramUrl,
                    style: const TextStyle(fontSize: 16, decoration: TextDecoration.underline, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
        bottomNavigationBar: BottomNavBar(currentRoute: '/about_team')
    );
  }
}
