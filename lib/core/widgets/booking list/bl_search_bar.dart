import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BlSearchBar extends StatelessWidget {
  final bool isDark;
  final ValueChanged<String> onChanged;

  const BlSearchBar({
    super.key,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(
            fontSize: 14,
            color: isDark ? Colors.white : AppColors.nearBlack,
          ),
          decoration: InputDecoration(
            hintText: 'Search by reference number...',
            hintStyle: TextStyle(fontSize: 14, color: AppColors.mutedBlue),
            prefixIcon:
                const Icon(Icons.search_rounded, color: AppColors.mutedBlue),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
