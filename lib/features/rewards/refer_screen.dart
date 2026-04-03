import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class ReferScreen extends StatefulWidget {
  const ReferScreen({super.key});

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen>
    with SingleTickerProviderStateMixin {
  // TODO: Replace with real referral code from API
  static const String _referralCode = 'DNA-JX92';
  static const int _referralPoints = 500;

  bool _copied = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(const ClipboardData(text: _referralCode));
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  void _shareCode() {
    // TODO: Replace with share_plus: Share.share(...)
    // For now, copy to clipboard as fallback
    _copyCode();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Code copied — paste it anywhere to share!'),
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
    final textColor = isDark ? Colors.white : AppColors.nearBlack;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBg : const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(textColor: textColor, onBack: () => context.pop()),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                children: [
                  const SizedBox(height: 8),

                  // ── Hero card ──
                  _HeroCard(
                    pulseAnimation: _pulseAnimation,
                    referralPoints: _referralPoints,
                  ),
                  const SizedBox(height: 20),

                  // ── Referral code box ──
                  _ReferralCodeBox(
                    code: _referralCode,
                    copied: _copied,
                    isDark: isDark,
                    onCopy: _copyCode,
                  ),
                  const SizedBox(height: 16),

                  // ── Share button ──
                  _ShareButton(onShare: _shareCode),
                  const SizedBox(height: 28),

                  // ── How it works ──
                  _HowItWorks(isDark: isDark),
                  const SizedBox(height: 28),

                  // ── Referrals summary ──
                  _ReferralsSummary(isDark: isDark),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Top bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final Color textColor;
  final VoidCallback onBack;

  const _TopBar({required this.textColor, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2A3B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_back_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Text(
            'Refer & Earn',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Hero card ─────────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  final Animation<double> pulseAnimation;
  final int referralPoints;

  const _HeroCard({
    required this.pulseAnimation,
    required this.referralPoints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E2D50), Color(0xFF162038)],
        ),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: AppColors.brandGold.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          // Animated gold coin
          ScaleTransition(
            scale: pulseAnimation,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.brandGold,
                    AppColors.brandGold.withOpacity(0.6),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.brandGold.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Icon(Icons.card_giftcard_rounded,
                  color: Colors.white, size: 36),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            'Invite Friends, Earn Points',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 14, color: AppColors.mutedBlue, height: 1.5),
              children: [
                const TextSpan(text: 'You and your friend both earn '),
                TextSpan(
                  text: '$referralPoints pts',
                  style: const TextStyle(
                    color: AppColors.brandGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const TextSpan(
                    text: '\nwhen they complete their first booking'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Points pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.brandGold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppColors.brandGold.withOpacity(0.4), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star_rounded,
                    color: AppColors.brandGold, size: 16),
                const SizedBox(width: 6),
                Text(
                  '+$referralPoints pts per referral',
                  style: const TextStyle(
                    color: AppColors.brandGold,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Referral code box ─────────────────────────────────────────────────────────

class _ReferralCodeBox extends StatelessWidget {
  final String code;
  final bool copied;
  final bool isDark;
  final VoidCallback onCopy;

  const _ReferralCodeBox({
    required this.code,
    required this.copied,
    required this.isDark,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.brandGold.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR REFERRAL CODE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mutedBlue,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  code,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.brandGold,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: GestureDetector(
              key: ValueKey(copied),
              onTap: onCopy,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: copied
                      ? Colors.green.withOpacity(0.15)
                      : AppColors.brandGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: copied
                        ? Colors.green.withOpacity(0.5)
                        : AppColors.brandGold.withOpacity(0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      copied ? Icons.check_circle_rounded : Icons.copy_rounded,
                      color: copied ? Colors.green : AppColors.brandGold,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      copied ? 'Copied!' : 'Copy',
                      style: TextStyle(
                        color: copied ? Colors.green : AppColors.brandGold,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Share button ──────────────────────────────────────────────────────────────

class _ShareButton extends StatelessWidget {
  final VoidCallback onShare;

  const _ShareButton({required this.onShare});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: onShare,
        icon: const Icon(Icons.share_rounded, color: Colors.white, size: 20),
        label: const Text(
          'Share with Friends',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brandGold,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 0,
        ),
      ),
    );
  }
}

// ── How it works ──────────────────────────────────────────────────────────────

class _HowItWorks extends StatelessWidget {
  final bool isDark;

  const _HowItWorks({required this.isDark});

  static const _steps = [
    (
      icon: Icons.share_rounded,
      title: 'Share Your Code',
      desc: 'Send your unique code DNA-JX92 to friends via any app',
    ),
    (
      icon: Icons.person_add_rounded,
      title: 'Friend Signs Up',
      desc: 'They register with Dinar using your referral code',
    ),
    (
      icon: Icons.star_rounded,
      title: 'Both Earn 500 pts',
      desc: 'Points added after their first completed booking',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HOW IT WORKS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.mutedBlue,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: List.generate(_steps.length, (i) {
              final step = _steps[i];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Step number + icon
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.brandGold.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(step.icon,
                                  color: AppColors.brandGold, size: 22),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: AppColors.brandGold,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${i + 1}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                step.title,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? Colors.white
                                      : AppColors.nearBlack,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                step.desc,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.mutedBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (i < _steps.length - 1)
                    Divider(
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                      color: isDark
                          ? AppColors.dividerDark
                          : AppColors.dividerLight,
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ── Referrals summary ─────────────────────────────────────────────────────────

class _ReferralsSummary extends StatelessWidget {
  final bool isDark;

  const _ReferralsSummary({required this.isDark});

  // TODO: Replace with real referrals from API
  static const _stats = [
    ('3', 'Friends Invited'),
    ('2', 'Completed'),
    ('1,000', 'pts Earned'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'YOUR REFERRALS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.mutedBlue,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: List.generate(_stats.length, (i) {
              final stat = _stats[i];
              return Expanded(
                child: Column(
                  children: [
                    Text(
                      stat.$1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.brandGold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stat.$2,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.mutedBlue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
