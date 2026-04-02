import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/widgets/payment/payment_tab_bar.dart';
import 'package:dinar_app/core/widgets/payment/payment_credit_card.dart';
import 'package:dinar_app/core/widgets/payment/payment_saved_cards.dart';
import 'package:dinar_app/core/widgets/payment/payment_total_row.dart';

class PaymentCardscreen extends StatefulWidget {
  const PaymentCardscreen({super.key});

  @override
  State<PaymentCardscreen> createState() => _PaymentCardscreenState();
}

class _PaymentCardscreenState extends State<PaymentCardscreen> {
  int _selectedTab = 0; // 0 = Card, 1 = Cash

  void _onTabChanged(int index) {
    if (index == 1) {
      // Switch to cash screen, replace so back works correctly
      context.pushReplacement('/payment-cash');
    } else {
      setState(() => _selectedTab = 0);
    }
  }

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
        title: const Text('Payment'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tab bar
          PaymentTabBar(selectedTab: _selectedTab, onTabChanged: _onTabChanged),
          const SizedBox(height: 16),

          // Credit card visual
          const PaymentCreditCard(),
          const SizedBox(height: 16),

          // Saved cards
          PaymentSavedCards(isDark: isDark),
          const SizedBox(height: 12),

          // Total amount
          PaymentTotalRow(isDark: isDark, total: 59.00),
          const SizedBox(height: 8),

          // Security note
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock_outline_rounded,
                    size: 13, color: AppColors.mutedBlue),
                SizedBox(width: 4),
                Text(
                  'Secured by Stripe · PCI DSS Compliant',
                  style: TextStyle(fontSize: 12, color: AppColors.mutedBlue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Pay button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => context.push('/booking-confirmation'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Pay £59.00 →',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
