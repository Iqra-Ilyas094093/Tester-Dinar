import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PaymentSavedCards extends StatelessWidget {
  final bool isDark;
  const PaymentSavedCards({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;

    return Column(
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Saved Cards',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.nearBlack,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Text(
                '+ Add New',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.brandGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Use different card row
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Use a different card →',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.mutedBlue : AppColors.darkGray,
            ),
          ),
        ),
      ],
    );
  }
}
