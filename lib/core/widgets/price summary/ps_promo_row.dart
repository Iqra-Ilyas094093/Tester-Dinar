import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PsPromoRow extends StatelessWidget {
  final bool isDark;
  final String promoCode;
  const PsPromoRow({super.key, required this.isDark, required this.promoCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.confirmation_number_outlined,
              size: 18, color: AppColors.brandGold),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white : AppColors.nearBlack),
                children: [
                  TextSpan(
                      text: promoCode,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.brandGold)),
                  const TextSpan(text: ' applied ✓'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Text('Change',
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.brandGold,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
