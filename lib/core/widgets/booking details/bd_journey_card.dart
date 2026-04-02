import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BdJourneyCard extends StatelessWidget {
  final bool isDark;
  const BdJourneyCard({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final divColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label
          Text('JOURNEY',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mutedBlue,
                  letterSpacing: 1.2)),
          const SizedBox(height: 14),

          // Pickup
          _LocationRow(
              dotColor: AppColors.brandGold,
              label: 'PICKUP',
              value: 'Heathrow Airport T5, London',
              subColor: subColor,
              textColor: textColor),

          // Connector dots
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
                children: List.generate(
                    3,
                    (_) => Container(
                        width: 1.5,
                        height: 5,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: divColor))),
          ),

          // Dropoff
          _LocationRow(
              dotColor: AppColors.info,
              label: 'DROP-OFF',
              value: 'Mayfair, W1K, London',
              subColor: subColor,
              textColor: textColor),

          Divider(color: divColor, height: 24),

          // Details rows
          _DetailRow(
              label: 'Date & Time',
              value: '15 Aug 2025 · 09:30',
              subColor: subColor,
              textColor: textColor),
          _DetailRow(
              label: 'Vehicle',
              value: 'Executive Saloon',
              subColor: subColor,
              textColor: textColor),
          _DetailRow(
              label: 'Passengers',
              value: '2',
              subColor: subColor,
              textColor: textColor),
          _DetailRow(
              label: 'Flight',
              value: 'BA 2345',
              subColor: subColor,
              textColor: textColor,
              isLast: true),
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
                    fontSize: 10, color: subColor, letterSpacing: 0.8)),
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color subColor;
  final Color textColor;
  final bool isLast;

  const _DetailRow({
    required this.label,
    required this.value,
    required this.subColor,
    required this.textColor,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: subColor)),
          Text(value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),
        ],
      ),
    );
  }
}
