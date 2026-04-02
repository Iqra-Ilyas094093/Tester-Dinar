import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BdActionButtons extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTrack;
  final VoidCallback onCancel;

  const BdActionButtons({
    super.key,
    required this.isDark,
    required this.onTrack,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onTrack,
                icon: const Text('📍', style: TextStyle(fontSize: 16)),
                label: const Text('Track Ride',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandGold,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: onCancel,
                icon: const Icon(Icons.close_rounded,
                    size: 18, color: Colors.white),
                label: const Text('Cancel',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDark ? AppColors.darkElevated : AppColors.darkGray,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
