import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class LrReferCard extends StatelessWidget {
  final bool isDark;
  const LrReferCard({super.key, required this.isDark});

  static const String _referralCode = 'DNA-JX92';

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Refer & Earn 500 pts',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor)),
                const SizedBox(height: 2),
                Text('Share with friends',
                    style: TextStyle(fontSize: 12, color: subColor)),
              ],
            ),
          ),
          // Code chip
          GestureDetector(
            onTap: () {
              Clipboard.setData(const ClipboardData(text: _referralCode));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Referral code copied!'),
                  backgroundColor: AppColors.brandGold,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.brandGold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                _referralCode,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
