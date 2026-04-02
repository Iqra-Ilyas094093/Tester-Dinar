import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class LrActionButtons extends StatelessWidget {
  final bool isDark;
  final VoidCallback onRedeem;
  final VoidCallback onHistory;
  final VoidCallback onRefer;

  const LrActionButtons({
    super.key,
    required this.isDark,
    required this.onRedeem,
    required this.onHistory,
    required this.onRefer,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;

    return Row(
      children: [
        _ActionBtn(
          bg: cardBg,
          emoji: '🎁',
          label: 'Redeem',
          onTap: onRedeem,
          isDark: isDark,
        ),
        const SizedBox(width: 10),
        _ActionBtn(
          bg: cardBg,
          emoji: '📊',
          label: 'History',
          onTap: onHistory,
          isDark: isDark,
        ),
        const SizedBox(width: 10),
        _ActionBtn(
          bg: cardBg,
          emoji: '👥',
          label: 'Refer',
          onTap: onRefer,
          isDark: isDark,
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final Color bg;
  final String emoji;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _ActionBtn({
    required this.bg,
    required this.emoji,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : AppColors.darkGray,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
