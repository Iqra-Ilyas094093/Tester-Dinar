import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PsLoyaltyRow extends StatelessWidget {
  final bool isDark;
  final int points;
  const PsLoyaltyRow({super.key, required this.isDark, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.brandGold.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.brandGold.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.star_rounded, color: AppColors.brandGold, size: 20),
          const SizedBox(width: 10),
          Text("You'll earn ",
              style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : AppColors.nearBlack)),
          Text('$points loyalty points',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brandGold)),
          Text(' on this booking',
              style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white : AppColors.nearBlack)),
        ],
      ),
    );
  }
}
