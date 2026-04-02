import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/widgets/price summary/journey_card.dart';
import 'package:dinar_app/core/widgets/price summary/ps_fare_card.dart';
import 'package:dinar_app/core/widgets/price summary/ps_promo_row.dart';
import 'package:dinar_app/core/widgets/price summary/ps_loyalty_row.dart';

class PriceSummaryscreen extends StatefulWidget {
  const PriceSummaryscreen({super.key});

  @override
  State<PriceSummaryscreen> createState() => _PriceSummaryscreenState();
}

class _PriceSummaryscreenState extends State<PriceSummaryscreen> {
  final String _promoCode = 'DINAR10';
  final double _discount = 5.0;
  final int _loyaltyPoints = 59;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color:
                  isDark ? AppColors.darkCard : Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_rounded, size: 20),
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text('Price Summary'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Journey card
          PsJourneyCard(isDark: isDark),
          const SizedBox(height: 12),

          // Fare breakdown
          PsFareCard(isDark: isDark, discount: _discount),
          const SizedBox(height: 12),

          // Promo code row
          PsPromoRow(isDark: isDark, promoCode: _promoCode),
          const SizedBox(height: 12),

          // Loyalty points
          PsLoyaltyRow(isDark: isDark, points: _loyaltyPoints),
          const SizedBox(height: 32),

          // Confirm button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => context.push('/payment-card'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ),
              child: const Text(
                'Confirm & Pay',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
