import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class LrPointsCard extends StatelessWidget {
  final bool isDark;
  const LrPointsCard({super.key, required this.isDark});

  static const int currentPoints = 2450;
  static const int targetPoints = 5000;

  @override
  Widget build(BuildContext context) {
    final progress = currentPoints / targetPoints;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2D50), Color(0xFF2C3E6B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyDark.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Member badge ──
          Row(
            children: [
              const Text('🏅', style: TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Gold Member',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('Dinar Loyalty Programme',
                      style:
                          TextStyle(fontSize: 12, color: AppColors.mutedBlue)),
                ],
              ),
              const Spacer(),
              // Decorative sparkle
              Icon(Icons.auto_awesome_rounded,
                  color: Colors.white.withOpacity(0.15), size: 40),
            ],
          ),
          const SizedBox(height: 20),

          // ── Points balance ──
          const Text(
            '2,450',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1,
            ),
          ),
          const Text(
            'points balance',
            style: TextStyle(fontSize: 13, color: AppColors.mutedBlue),
          ),
          const SizedBox(height: 16),

          // ── Progress bar ──
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.brandGold),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Gold · 2,450 pts',
                  style: TextStyle(fontSize: 11, color: AppColors.mutedBlue)),
              Text('Platinum · 5,000 pts',
                  style: TextStyle(fontSize: 11, color: AppColors.mutedBlue)),
            ],
          ),
        ],
      ),
    );
  }
}
