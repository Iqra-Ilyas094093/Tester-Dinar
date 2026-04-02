import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PdSectionLabel extends StatelessWidget {
  final String label;
  const PdSectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 16, 8),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.mutedBlue,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class PdSectionCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;
  const PdSectionCard(
      {super.key, required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}

class PdDivider extends StatelessWidget {
  final bool isDark;
  const PdDivider({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
    );
  }
}
