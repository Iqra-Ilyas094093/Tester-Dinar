import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PsFareCard extends StatelessWidget {
  final bool isDark;
  final double discount;
  const PsFareCard({super.key, required this.isDark, required this.discount});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final divColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    final items = [
      ('Base Fare', 52.0, false),
      ('Meet & Greet', 12.0, false),
      ('Road Tolls (incl.)', 0.0, false),
      ('Promo Discount (DINAR10)', -discount, true),
    ];

    final total = items.fold<double>(0, (sum, i) => sum + i.$2);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration:
          BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FARE BREAKDOWN',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedBlue,
                  letterSpacing: 1.2)),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.$1,
                        style: TextStyle(fontSize: 14, color: subColor)),
                    Text(
                      item.$2 == 0
                          ? '£0.00'
                          : item.$3
                              ? '−£${item.$2.abs().toStringAsFixed(2)}'
                              : '£${item.$2.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: item.$3 ? AppColors.error : textColor,
                      ),
                    ),
                  ],
                ),
              )),
          Divider(color: divColor, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor)),
              Text('£${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.brandGold)),
            ],
          ),
        ],
      ),
    );
  }
}
