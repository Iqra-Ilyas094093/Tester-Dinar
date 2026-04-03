import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/widgets/loyalty rewards/lr_action_buttons.dart';
import 'package:dinar_app/core/widgets/loyalty rewards/lr_points_card.dart';
import 'package:dinar_app/core/widgets/loyalty rewards/lr_recent_points.dart';
import 'package:dinar_app/core/widgets/loyalty rewards/lr_refer_card.dart';

class LoyaltyRewardsscreen extends StatelessWidget {
  const LoyaltyRewardsscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Title ──
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Rewards',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),

            // ── Points card ──
            LrPointsCard(isDark: isDark),
            const SizedBox(height: 12),

            // ── Action buttons ──
            LrActionButtons(
              isDark: isDark,
              onRedeem: () => context.push('/redeem-points'),
              onHistory: () => context.push('/points-history'),
              //  onRefer: () {},
              onRefer: () => context.push('/refer'),
            ),
            const SizedBox(height: 12),

            // ── Refer & Earn ──
            LrReferCard(isDark: isDark),
            const SizedBox(height: 20),

            // ── Recent points label ──
            Text(
              'RECENT POINTS',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.mutedBlue,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 10),

            // ── Recent points list ──
            const LrRecentPoints(),
          ],
        ),
      ),
    );
  }
}
