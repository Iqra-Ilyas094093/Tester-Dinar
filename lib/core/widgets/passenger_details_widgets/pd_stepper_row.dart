import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PdStepperRow extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;
  final bool isDark;

  const PdStepperRow({
    super.key,
    required this.label,
    required this.value,
    required this.onDecrement,
    required this.onIncrement,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final btnBg = isDark ? AppColors.darkElevated : AppColors.lightGray;

    return SizedBox(
      height: 56,
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.white70 : AppColors.darkGray),
            ),
          ),
          _StepBtn(icon: Icons.remove, bg: btnBg, onTap: onDecrement),
          SizedBox(
            width: 36,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.nearBlack,
              ),
            ),
          ),
          _StepBtn(icon: Icons.add, bg: btnBg, onTap: onIncrement),
        ],
      ),
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData icon;
  final Color bg;
  final VoidCallback? onTap;

  const _StepBtn({required this.icon, required this.bg, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap == null ? 0.3 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 32,
          height: 32,
          decoration:
              BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 16, color: AppColors.brandGold),
        ),
      ),
    );
  }
}
