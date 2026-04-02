import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BdPaymentCard extends StatelessWidget {
  final bool isDark;
  const BdPaymentCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final divColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PAYMENT',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedBlue,
                  letterSpacing: 1.2)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Amount', style: TextStyle(fontSize: 14, color: subColor)),
              const Text('£59.00',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandGold)),
            ],
          ),
          Divider(color: divColor, height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Method', style: TextStyle(fontSize: 14, color: subColor)),
              Text('Visa ····4242',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textColor)),
            ],
          ),
        ],
      ),
    );
  }
}
