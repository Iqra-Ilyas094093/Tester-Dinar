import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

//   API ready:
// Replace _history static list with a Riverpod provider returning grouped data from your API. Zero UI changes needed.

class PointsHistoryscreen extends StatelessWidget {
  const PointsHistoryscreen({super.key});

  // Mock data — replace with API later
  static const List<Map<String, dynamic>> _history = [
    {
      'month': 'AUGUST 2025',
      'items': [
        {
          'emoji': '✈️',
          'title': 'Heathrow → Mayfair',
          'sub': '15 Aug · DNA-2025-7841',
          'pts': 59
        },
        {
          'emoji': '✈️',
          'title': 'Gatwick → Chelsea',
          'sub': '2 Aug · DNA-2025-6210',
          'pts': 87
        },
      ],
    },
    {
      'month': 'JULY 2025',
      'items': [
        {
          'emoji': '🎁',
          'title': 'Redeemed — Discount',
          'sub': '20 Jul 2025',
          'pts': -200
        },
        {
          'emoji': '✈️',
          'title': 'LHR T3 → Shoreditch',
          'sub': '15 Jul · DNA-2025-5890',
          'pts': 64
        },
        {
          'emoji': '👥',
          'title': 'Referral Bonus',
          'sub': '3 Jul 2025',
          'pts': 500
        },
      ],
    },
  ];

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
        title: const Text('Points History'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Balance chip ──
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.brandGold.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.star_rounded, color: AppColors.brandGold, size: 18),
                SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Balance',
                        style: TextStyle(
                            fontSize: 10, color: AppColors.mutedBlue)),
                    Text('2,450 pts',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.brandGold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Grouped history ──
          ..._history.map((group) => _HistoryGroup(
                month: group['month'],
                items: List<Map<String, dynamic>>.from(group['items']),
                isDark: isDark,
              )),
        ],
      ),
    );
  }
}

// ── Month group ───────────────────────────────────────────────────────────────
class _HistoryGroup extends StatelessWidget {
  final String month;
  final List<Map<String, dynamic>> items;
  final bool isDark;

  const _HistoryGroup({
    required this.month,
    required this.items,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final divColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month label
        Text(
          month,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.mutedBlue,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),

        // Card with all items
        Container(
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final i = entry.key;
              final item = entry.value;
              final isLast = i == items.length - 1;
              final pts = item['pts'] as int;
              final isNegative = pts < 0;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        // Emoji
                        Text(item['emoji'],
                            style: const TextStyle(fontSize: 18)),
                        const SizedBox(width: 12),

                        // Title + sub
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['title'],
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
                                item['sub'],
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.mutedBlue),
                              ),
                            ],
                          ),
                        ),

                        // Points
                        Text(
                          isNegative ? '$pts' : '+$pts',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isNegative
                                ? AppColors.error
                                : AppColors.brandGold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                        height: 1, color: divColor, indent: 16, endIndent: 16),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
