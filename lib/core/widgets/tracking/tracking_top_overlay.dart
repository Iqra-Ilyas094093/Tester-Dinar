import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class TrackingTopOverlay extends StatelessWidget {
  final int etaMinutes;
  final VoidCallback onBack;
  final VoidCallback onClose;

  const TrackingTopOverlay({
    super.key,
    required this.etaMinutes,
    required this.onBack,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          _NavButton(icon: Icons.arrow_back_rounded, onTap: onBack),
          const Spacer(),
          _EtaPill(etaMinutes: etaMinutes),
          const Spacer(),
          _NavButton(icon: Icons.close_rounded, onTap: onClose),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _NavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF1A2B40),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}

class _EtaPill extends StatelessWidget {
  final int etaMinutes;

  const _EtaPill({required this.etaMinutes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1828),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.brandGold, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer_outlined,
              color: AppColors.brandGold, size: 16),
          const SizedBox(width: 6),
          Text(
            '$etaMinutes mins away',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
