import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BdDriverCard extends StatelessWidget {
  final bool isDark;
  const BdDriverCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DRIVER',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedBlue,
                  letterSpacing: 1.2)),
          const SizedBox(height: 14),
          Row(
            children: [
              // Avatar
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                    color: AppColors.navyMid,
                    borderRadius: BorderRadius.circular(12)),
                child: const Center(
                    child: Text('😊', style: TextStyle(fontSize: 28))),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mohammed Al-Rashid',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  Text('BMW 5 Series · LN21 DXR',
                      style: TextStyle(fontSize: 12, color: subColor)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      ...List.generate(
                          5,
                          (_) => const Icon(Icons.star_rounded,
                              size: 14, color: AppColors.brandGold)),
                      const SizedBox(width: 4),
                      Text('4.9',
                          style: TextStyle(fontSize: 12, color: subColor)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
