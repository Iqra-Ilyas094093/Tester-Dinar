import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class LrRecentPoints extends StatelessWidget {
  const LrRecentPoints({super.key});

  static const List<Map<String, dynamic>> _points = [
    {'route': 'Heathrow → Mayfair', 'date': '15 Aug 2025', 'pts': '+59 pts'},
    {'route': 'Gatwick → Chelsea', 'date': '2 Aug 2025', 'pts': '+87 pts'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;

    return Column(
      children: _points.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              const Icon(Icons.flight_takeoff_rounded,
                  size: 16, color: AppColors.brandGold),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['route'],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor)),
                    Text(item['date'],
                        style: TextStyle(fontSize: 12, color: subColor)),
                  ],
                ),
              ),
              Text(
                item['pts'],
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandGold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
