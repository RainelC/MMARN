import 'package:flutter/cupertino.dart';
import 'package:mmarn/core/constants/app_colors.dart';
import 'package:mmarn/features/about_us/domain/entities/section_entity.dart';

class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.section,
  });

  final SectionEntity section;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(section.title,
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
          const SizedBox(height: 8),
          Text(section.content, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}