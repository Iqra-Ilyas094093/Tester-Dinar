import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/theme/theme_notifier.dart';

class Settingsscreen extends ConsumerStatefulWidget {
  const Settingsscreen({super.key});

  @override
  ConsumerState<Settingsscreen> createState() => _SettingsscreenState();
}

class _SettingsscreenState extends ConsumerState<Settingsscreen> {
  // Theme
  int _themeIndex = 0; // 0=Dark, 1=Light, 2=System

  // Appearance
  bool _reduceMotion = false;
  bool _highContrast = false;

  // Notifications
  bool _pushNotifs = true;
  bool _emailNotifs = true;
  bool _marketingMails = false;

  // Security
  bool _biometric = true;
  bool _autoLock = true;

  void _onThemeChanged(int index) {
    setState(() => _themeIndex = index);
    // Wire to Riverpod theme notifier
    if (index == 0) {
      ref.read(themeProvider.notifier).toggleTheme(true); // dark
    } else if (index == 1) {
      ref.read(themeProvider.notifier).toggleTheme(false); // light
    }
    // index == 2 = System (handle later)
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;

    // Sync theme index with current theme
    _themeIndex = isDark ? 0 : 1;

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
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── APPEARANCE ──
          _SectionLabel(label: 'APPEARANCE'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: cardBg, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Theme',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.nearBlack)),
                const SizedBox(height: 12),

                // Theme selector
                Row(
                  children: [
                    _ThemeOption(
                      emoji: '🌙',
                      label: 'Dark Mode',
                      isSelected: _themeIndex == 0,
                      onTap: () => _onThemeChanged(0),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    _ThemeOption(
                      emoji: '☀️',
                      label: 'Light Mode',
                      isSelected: _themeIndex == 1,
                      onTap: () => _onThemeChanged(1),
                      isDark: isDark,
                    ),
                    const SizedBox(width: 8),
                    _ThemeOption(
                      emoji: '📱',
                      label: 'System',
                      isSelected: _themeIndex == 2,
                      onTap: () => _onThemeChanged(2),
                      isDark: isDark,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _Divider(isDark: isDark),

                // Reduce Motion
                _ToggleRow(
                  title: 'Reduce Motion',
                  subtitle: 'Minimise animations',
                  value: _reduceMotion,
                  onChanged: (v) => setState(() => _reduceMotion = v),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),

                // High Contrast
                _ToggleRow(
                  title: 'High Contrast',
                  subtitle: 'Improve accessibility',
                  value: _highContrast,
                  onChanged: (v) => setState(() => _highContrast = v),
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── NOTIFICATIONS ──
          _SectionLabel(label: 'NOTIFICATIONS'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: cardBg, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                _ToggleRow(
                  emoji: '🔔',
                  title: 'Push Notifications',
                  subtitle: 'Booking & driver alerts',
                  value: _pushNotifs,
                  onChanged: (v) => setState(() => _pushNotifs = v),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ToggleRow(
                  emoji: '📧',
                  title: 'Email Notifications',
                  subtitle: 'Confirmations & receipts',
                  value: _emailNotifs,
                  onChanged: (v) => setState(() => _emailNotifs = v),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ToggleRow(
                  emoji: '📣',
                  title: 'Marketing Emails',
                  subtitle: 'Promos & offers (SendPulse)',
                  value: _marketingMails,
                  onChanged: (v) => setState(() => _marketingMails = v),
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── SECURITY ──
          _SectionLabel(label: 'SECURITY'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: cardBg, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                _ToggleRow(
                  emoji: '👆',
                  title: 'Biometric Login',
                  subtitle: 'Fingerprint / Face ID',
                  value: _biometric,
                  onChanged: (v) => setState(() => _biometric = v),
                  isDark: isDark,
                ),
                _Divider(isDark: isDark),
                _ToggleRow(
                  emoji: '🔒',
                  title: 'Auto-lock',
                  subtitle: 'Lock app when inactive',
                  value: _autoLock,
                  onChanged: (v) => setState(() => _autoLock = v),
                  isDark: isDark,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Section label ─────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.mutedBlue,
            letterSpacing: 1.2));
  }
}

// ── Theme option box ──────────────────────────────────────────────────────────
class _ThemeOption extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _ThemeOption({
    required this.emoji,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkElevated : AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.brandGold : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(height: 6),
              Text(label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color:
                        isSelected ? AppColors.brandGold : AppColors.mutedBlue,
                  )),
              const SizedBox(height: 6),
              // Dot indicator
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.brandGold : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Toggle row ────────────────────────────────────────────────────────────────
class _ToggleRow extends StatelessWidget {
  final String? emoji;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isDark;

  const _ToggleRow({
    this.emoji,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          if (emoji != null) ...[
            Text(emoji!, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.nearBlack)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.mutedBlue)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.brandGold,
            activeTrackColor: AppColors.brandGold.withOpacity(0.4),
          ),
        ],
      ),
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
        color: isDark ? AppColors.dividerDark : AppColors.dividerLight);
  }
}
