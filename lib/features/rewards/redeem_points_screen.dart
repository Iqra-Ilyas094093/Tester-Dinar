import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class RedeemPointsscreen extends StatefulWidget {
  const RedeemPointsscreen({super.key});

  @override
  State<RedeemPointsscreen> createState() => _RedeemPointsscreenState();
}

class _RedeemPointsscreenState extends State<RedeemPointsscreen> {
  static const int _availablePoints = 2450;
  static const double _pointValue = 0.01; // 1 pt = £0.01

  int _selectedPoints = 500;

  final List<Map<String, dynamic>> _presets = [
    {'pts': 250, 'label': '250 pts · £2.50'},
    {'pts': 500, 'label': '500 pts · £5.00'},
    {'pts': 1000, 'label': '1000 pts · £10.00'},
    {'pts': 2450, 'label': 'All · £24.50'},
  ];

  double get _discountValue => _selectedPoints * _pointValue;

  void _increment() {
    if (_selectedPoints + 50 <= _availablePoints) {
      setState(() => _selectedPoints += 50);
    }
  }

  void _decrement() {
    if (_selectedPoints - 50 >= 250) {
      setState(() => _selectedPoints -= 50);
    }
  }

  void _applyPoints() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '$_selectedPoints pts applied — £${_discountValue.toStringAsFixed(2)} off your next booking!'),
        backgroundColor: AppColors.brandGold,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

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
        title: const Text('Redeem Points'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Available balance card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E2D50), Color(0xFF2C3E6B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text(
                  'AVAILABLE BALANCE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mutedBlue,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  '2,450',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandGold,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 6),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 13, color: AppColors.mutedBlue),
                    children: [
                      TextSpan(text: 'points = '),
                      TextSpan(
                        text: '£24.50',
                        style: TextStyle(
                          color: AppColors.brandGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(text: ' discount value'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── How many points label ──
          Text(
            'HOW MANY POINTS TO REDEEM?',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.mutedBlue,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),

          // ── Points selector ──
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                // Value display
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.brandGold, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '$_selectedPoints',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandGold,
                          ),
                        ),
                        Text(
                          '= £${_discountValue.toStringAsFixed(2)} off',
                          style: TextStyle(fontSize: 12, color: subColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // +/- buttons
                Column(
                  children: [
                    _StepBtn(
                        icon: Icons.add, onTap: _increment, isDark: isDark),
                    const SizedBox(height: 8),
                    _StepBtn(
                        icon: Icons.remove, onTap: _decrement, isDark: isDark),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ── Preset chips ──
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _presets.map((p) {
              final isSelected = _selectedPoints == p['pts'];
              return GestureDetector(
                onTap: () => setState(() => _selectedPoints = p['pts']),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.brandGold : cardBg,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.brandGold
                          : AppColors.brandGold.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    p['label'],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : subColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // ── Info box ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _InfoRow(
                    text:
                        'Points are redeemed as a discount on your next booking',
                    subColor: subColor),
                const SizedBox(height: 6),
                _InfoRow(
                    text: 'Minimum redemption: 250 points (£2.50)',
                    subColor: subColor),
                const SizedBox(height: 6),
                _InfoRow(
                    text: 'Points cannot be combined with promo codes',
                    subColor: subColor),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ── Apply button ──
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _applyPoints,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGold,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
              child: Text(
                // Apply → snackbar (API call goes here)
                'Apply $_selectedPoints pts to Next Booking →',
                style: const TextStyle(
                  fontSize: 15,
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

// ── Step button (+/-) ─────────────────────────────────────────────────────────
class _StepBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;

  const _StepBtn({
    required this.icon,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkElevated : AppColors.lightGray,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: AppColors.brandGold),
      ),
    );
  }
}

// ── Info row ──────────────────────────────────────────────────────────────────
class _InfoRow extends StatelessWidget {
  final String text;
  final Color subColor;

  const _InfoRow({required this.text, required this.subColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('✦ ',
            style: TextStyle(fontSize: 10, color: AppColors.brandGold)),
        Expanded(
          child: Text(text,
              style: TextStyle(fontSize: 12, color: subColor, height: 1.4)),
        ),
      ],
    );
  }
}
