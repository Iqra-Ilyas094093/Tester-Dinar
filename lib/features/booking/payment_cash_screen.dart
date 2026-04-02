import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/widgets/payment/payment_tab_bar.dart';

class PaymentCashscreen extends StatefulWidget {
  const PaymentCashscreen({super.key});

  @override
  State<PaymentCashscreen> createState() => _PaymentCashscreenState();
}

class _PaymentCashscreenState extends State<PaymentCashscreen> {
  void _onTabChanged(int index) {
    if (index == 0) context.pushReplacement('/payment-card');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;

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
          // ── Tab Bar ──
          PaymentTabBar(selectedTab: 1, onTabChanged: _onTabChanged),
          const SizedBox(height: 16),

          // ── Cash Icon + Title + Description ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    '💵',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 34),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Pay Your Driver Directly',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your booking will be confirmed instantly. Please have the exact cash amount ready to pay your driver at the end of the journey.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: subColor, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Cash Payment Summary ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CASH PAYMENT SUMMARY',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mutedBlue,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 14),
                _SummaryRow(
                  label: 'Amount to Pay Driver',
                  value: '£59.00',
                  valueColor: AppColors.brandGold,
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _SummaryRow(
                  label: 'Payment Method',
                  value: 'Cash on completion',
                  valueBold: true,
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _SummaryRow(
                  label: 'Currency',
                  value: 'GBP (£)',
                  valueBold: true,
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Warning Note ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: AppColors.warning, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Please note: cash payment does not guarantee same-day availability. Ensure you have the correct amount ready. Change may not be available.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? Colors.white70 : AppColors.darkGray,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Confirm Button ──
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
                'Confirm Cash Booking →',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Summary Row ──────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool valueBold;
  final bool isDark;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.valueBold = false,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? AppColors.mutedBlue : AppColors.darkGray,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: valueBold ? FontWeight.w600 : FontWeight.normal,
              color:
                  valueColor ?? (isDark ? Colors.white : AppColors.nearBlack),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Divider ──────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
    );
  }
}
