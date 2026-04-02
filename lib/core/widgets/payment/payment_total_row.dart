import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PaymentTotalRow extends StatelessWidget {
  final bool isDark;
  final double total;

  const PaymentTotalRow({super.key, required this.isDark, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Amount Due',
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : AppColors.darkGray,
            ),
          ),
          Text(
            '£${total.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.brandGold,
            ),
          ),
        ],
      ),
    );
  }
}
