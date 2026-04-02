import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PdAddonRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDark;
  final IconData? icon;
  final String? emoji;

  const PdAddonRow({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    required this.value,
    required this.onChanged,
    required this.isDark,
    this.icon,
    this.emoji,
  });

  @override
  Widget build(BuildContext context) {
    final subColor =
        subtitleColor ?? (isDark ? AppColors.mutedBlue : AppColors.darkGray);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          if (icon != null)
            Icon(icon, size: 18, color: AppColors.brandGold)
          else if (emoji != null)
            Text(emoji!, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : AppColors.nearBlack,
                  ),
                ),
                Text(subtitle, style: TextStyle(fontSize: 12, color: subColor)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.brandGold,
            activeTrackColor: AppColors.brandGold.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
