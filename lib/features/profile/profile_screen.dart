import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ── Profile header ──
            _ProfileHeader(isDark: isDark),
            const SizedBox(height: 24),

            // ── ACCOUNT section ──
            _SectionLabel(label: 'ACCOUNT'),
            const SizedBox(height: 8),
            _SectionCard(
              cardBg: cardBg,
              isDark: isDark,
              children: [
                _ProfileTile(
                  emoji: '🏠',
                  title: 'Saved Addresses',
                  subtitle: 'Home, Work & 1 more',
                  onTap: () => context.push('/saved-addresses'),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ProfileTile(
                  emoji: '💳',
                  title: 'Payment Methods',
                  subtitle: 'Visa ····4242',
                  onTap: () => context.push('/payment-methods'),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ProfileTile(
                  emoji: '⭐',
                  title: 'Loyalty Rewards',
                  subtitle: '2,450 pts · Gold',
                  onTap: () => context.push('/rewards'),
                  isDark: isDark,
                  trailing: _GoldBadge(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── PREFERENCES section ──
            _SectionLabel(label: 'PREFERENCES'),
            const SizedBox(height: 8),
            _SectionCard(
              cardBg: cardBg,
              isDark: isDark,
              children: [
                _ProfileTile(
                  emoji: '🔔',
                  title: 'Notifications',
                  subtitle: 'Push & Email enabled',
                  onTap: () => context.push('/notifications'),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ProfileTile(
                  emoji: '🌙',
                  title: 'Appearance',
                  subtitle: isDark ? 'Dark Mode active' : 'Light Mode active',
                  onTap: () => context.push('/settings'),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ProfileTile(
                  emoji: '👆',
                  title: 'Biometric Login',
                  subtitle: 'Fingerprint enabled',
                  onTap: () => context.push('/settings'),
                  isDark: isDark,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Sign Out ──
            _SignOutButton(
                isDark: isDark,
                onTap: () => _showSignOutDialog(context, isDark)),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, bool isDark) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkCard : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Sign Out?'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.mutedBlue)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child:
                const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ── Profile header ────────────────────────────────────────────────────────────
class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  const _ProfileHeader({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            gradient: AppColors.goldGradient,
            borderRadius: BorderRadius.circular(18),
          ),
          child:
              const Icon(Icons.person_rounded, size: 40, color: Colors.white),
        ),
        const SizedBox(width: 16),

        // Name + email + edit
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Smith',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.nearBlack,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'john@email.com',
              style: const TextStyle(fontSize: 13, color: AppColors.mutedBlue),
            ),
            const SizedBox(height: 6),
            GestureDetector(
              //   onTap: () => Navigator.of(context).pushNamed('/edit-profile'),
              onTap: () => context.push('/edit-profile'),

              child: Row(
                children: const [
                  Icon(Icons.edit_rounded,
                      size: 13, color: AppColors.brandGold),
                  SizedBox(width: 4),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.brandGold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.mutedBlue,
        letterSpacing: 1.2,
      ),
    );
  }
}

// ── Section card ──────────────────────────────────────────────────────────────
class _SectionCard extends StatelessWidget {
  final Color cardBg;
  final bool isDark;
  final List<Widget> children;

  const _SectionCard({
    required this.cardBg,
    required this.isDark,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }
}

// ── Profile tile ──────────────────────────────────────────────────────────────
class _ProfileTile extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDark;
  final Widget? trailing;

  const _ProfileTile({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.isDark,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Emoji icon box
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkElevated : AppColors.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(width: 14),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : AppColors.nearBlack,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.mutedBlue),
                  ),
                ],
              ),
            ),

            // Trailing widget or chevron
            trailing ??
                const Icon(Icons.chevron_right_rounded,
                    color: AppColors.mutedBlue, size: 20),
          ],
        ),
      ),
    );
  }
}

// ── Gold badge ────────────────────────────────────────────────────────────────
class _GoldBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.brandGold,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Gold',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.chevron_right_rounded,
            color: AppColors.mutedBlue, size: 20),
      ],
    );
  }
}

// ── Divider ───────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
    );
  }
}

// ── Sign out button ───────────────────────────────────────────────────────────
class _SignOutButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onTap;

  const _SignOutButton({required this.isDark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.logout_rounded,
                  color: AppColors.error, size: 20),
            ),
            const SizedBox(width: 14),
            const Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
