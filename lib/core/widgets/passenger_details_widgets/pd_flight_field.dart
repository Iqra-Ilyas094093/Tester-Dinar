import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PdFlightField extends StatelessWidget {
  final TextEditingController controller;
  final bool isDark;

  const PdFlightField(
      {super.key, required this.controller, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkElevated : AppColors.lightGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.flight_rounded,
              size: 16, color: AppColors.brandGold),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : AppColors.nearBlack,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'e.g. BA 2345',
              ),
            ),
          ),
          Text(
            '— Free',
            style: TextStyle(
                fontSize: 13,
                color: isDark ? AppColors.mutedBlue : AppColors.darkGray),
          ),
        ],
      ),
    );
  }
}
