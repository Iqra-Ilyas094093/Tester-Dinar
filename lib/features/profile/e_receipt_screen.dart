import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class EReceiptscreen extends StatelessWidget {
  final String bookingId;
  const EReceiptscreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;
    final divColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;

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
        title: const Text('E-Receipt'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Receipt card ──
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // ── Header ──
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.flight_rounded,
                                  color: AppColors.brandGold, size: 16),
                              SizedBox(width: 6),
                              Text('DINAR',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.brandGold,
                                    letterSpacing: 1,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text('Airport Transfers · UK',
                              style: TextStyle(fontSize: 11, color: subColor)),
                        ],
                      ),
                      const Spacer(),
                      // Reference
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('DNA-$bookingId',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.brandGold,
                              )),
                          const SizedBox(height: 2),
                          Text('OFFICIAL RECEIPT',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: subColor,
                                  letterSpacing: 0.8)),
                        ],
                      ),
                    ],
                  ),
                ),

                Divider(color: divColor, height: 1),

                // ── Trip details rows ──
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      _ReceiptRow(
                          label: 'Date',
                          value: '15 Aug 2025 · 09:30',
                          subColor: subColor,
                          textColor: textColor),
                      _ReceiptRow(
                          label: 'Pickup',
                          value: 'Heathrow Airport T5',
                          subColor: subColor,
                          textColor: textColor),
                      _ReceiptRow(
                          label: 'Drop-off',
                          value: 'Mayfair, W1K',
                          subColor: subColor,
                          textColor: textColor),
                      _ReceiptRow(
                          label: 'Vehicle',
                          value: 'Executive Saloon',
                          subColor: subColor,
                          textColor: textColor),
                      _ReceiptRow(
                          label: 'Driver',
                          value: 'Mohammed Al-Rashid',
                          subColor: subColor,
                          textColor: textColor),
                      // Driver rating row
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Driver Rating',
                                style:
                                    TextStyle(fontSize: 13, color: subColor)),
                            Row(
                              children: [
                                ...List.generate(
                                    5,
                                    (_) => const Icon(Icons.star_rounded,
                                        size: 14, color: AppColors.brandGold)),
                                const SizedBox(width: 4),
                                Text('4.9',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: textColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Divider(color: divColor, height: 1),

                // ── Fare breakdown ──
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      _ReceiptRow(
                          label: 'Base Fare',
                          value: '£52.00',
                          subColor: subColor,
                          textColor: textColor),
                      _ReceiptRow(
                          label: 'Meet & Greet',
                          value: '£12.00',
                          subColor: subColor,
                          textColor: textColor),
                      _ReceiptRow(
                          label: 'Promo (DINAR10)',
                          value: '−£5.00',
                          subColor: subColor,
                          textColor: AppColors.error),
                      _ReceiptRow(
                          label: 'Payment Method',
                          value: 'Visa ····4242',
                          subColor: subColor,
                          textColor: textColor),
                    ],
                  ),
                ),

                // ── Total ──
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppColors.darkElevated : AppColors.lightGray,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Charged',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          )),
                      const Text('£59.00',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandGold,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Action buttons ──
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _downloadPdf(context),
                  icon: const Icon(Icons.download_rounded,
                      color: Colors.white, size: 18),
                  label: const Text('Download PDF',
                      style: TextStyle(
                          fontSize: 14,
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
                  onPressed: () => _share(context),
                  icon: const Text('📤', style: TextStyle(fontSize: 16)),
                  label: Text('Share',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.nearBlack)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark ? AppColors.darkCard : Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                          color: AppColors.brandGold.withOpacity(0.4)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _downloadPdf(BuildContext context) {
    // Integrate PDF generation with API later
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Receipt downloaded!'),
        backgroundColor: AppColors.brandGold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _share(BuildContext context) {
    // Integrate share_plus later
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sharing receipt...'),
        backgroundColor: AppColors.brandGold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

// ── Receipt row ───────────────────────────────────────────────────────────────
class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final Color subColor;
  final Color textColor;

  const _ReceiptRow({
    required this.label,
    required this.value,
    required this.subColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: subColor)),
          Text(value,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w600, color: textColor)),
        ],
      ),
    );
  }
}
