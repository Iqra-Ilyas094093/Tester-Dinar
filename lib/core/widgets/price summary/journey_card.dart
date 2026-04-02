import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PsJourneyCard extends StatelessWidget {
  final bool isDark;
  const PsJourneyCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('YOUR JOURNEY',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedBlue,
                  letterSpacing: 1.2)),
          const SizedBox(height: 16),

          // Pickup
          _LocationRow(
            dotColor: AppColors.brandGold,
            label: 'PICKUP',
            value: 'Heathrow Airport T5, London',
            subColor: subColor,
            textColor: textColor,
          ),

          // Dotted line connector
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Column(
              children: List.generate(
                  3,
                  (_) => Container(
                        width: 1.5,
                        height: 6,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: isDark
                            ? AppColors.dividerDark
                            : AppColors.dividerLight,
                      )),
            ),
          ),

          // Dropoff
          _LocationRow(
            dotColor: AppColors.info,
            label: 'DROP-OFF',
            value: 'Mayfair, W1K, London',
            subColor: subColor,
            textColor: textColor,
          ),

          const SizedBox(height: 14),

          // Tags
          Wrap(
            spacing: 8,
            children: const [
              _Tag(label: 'Executive Saloon'),
              _Tag(label: '15 Aug · 09:30'),
              _Tag(label: '2 Passengers'),
            ],
          ),
        ],
      ),
    );
  }
}

class _LocationRow extends StatelessWidget {
  final Color dotColor;
  final String label;
  final String value;
  final Color subColor;
  final Color textColor;

  const _LocationRow({
    required this.dotColor,
    required this.label,
    required this.value,
    required this.subColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: CircleAvatar(radius: 5, backgroundColor: dotColor),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 11, color: subColor, letterSpacing: 0.8)),
            Text(value,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor)),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkElevated : AppColors.lightGray,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.brandGold.withOpacity(0.4)),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12,
              color: AppColors.brandGold,
              fontWeight: FontWeight.w500)),
    );
  }
}
