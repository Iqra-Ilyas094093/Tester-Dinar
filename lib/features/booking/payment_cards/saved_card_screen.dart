import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/model/card_model.dart';
import 'package:dinar_app/model/card_provider.dart';

class SavedCardsScreen extends ConsumerWidget {
  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardProvider);
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
              color: isDark ? AppColors.darkCard : AppColors.lightGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.arrow_back_rounded, size: 20, color: textColor),
          ),
          onPressed: () => context.pop(),
        ),
        title: Text('Saved Cards', style: TextStyle(color: textColor)),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/add-card'),
            icon: const Icon(Icons.add, color: AppColors.brandGold, size: 18),
            label: const Text('Add New',
                style: TextStyle(
                    color: AppColors.brandGold, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
      body: cards.isEmpty
          ? _EmptyState(isDark: isDark)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // ── Section label ──
                const Text('YOUR SAVED CARDS',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mutedBlue,
                        letterSpacing: 1.2)),
                const SizedBox(height: 10),

                // ── Cards list ──
                Container(
                  decoration: BoxDecoration(
                      color: cardBg, borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: cards.asMap().entries.map((entry) {
                      final i = entry.key;
                      final card = entry.value;
                      final isLast = i == cards.length - 1;

                      return Column(
                        children: [
                          _CardTile(
                            card: card,
                            isDark: isDark,
                            textColor: textColor,
                            subColor: subColor,
                            onSetDefault: () {
                              ref
                                  .read(cardProvider.notifier)
                                  .setDefault(card.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${card.cardType} ····${card.cardNumber} set as default'),
                                  backgroundColor: AppColors.brandGold,
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            onDelete: () =>
                                _showDeleteDialog(context, ref, card, isDark),
                          ),
                          if (!isLast)
                            Divider(
                                height: 1,
                                color: divColor,
                                indent: 16,
                                endIndent: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Add new card button ──
                GestureDetector(
                  onTap: () => context.push('/add-card'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                        color: cardBg, borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: AppColors.brandGold.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.add_rounded,
                              color: AppColors.brandGold, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Add New Card',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.brandGold)),
                            Text('Visa, Mastercard, Amex accepted',
                                style:
                                    TextStyle(fontSize: 12, color: subColor)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // ── Security note ──
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.lock_outline_rounded,
                          size: 13, color: AppColors.mutedBlue),
                      SizedBox(width: 4),
                      Text('All cards secured by Stripe · PCI DSS Level 1',
                          style: TextStyle(
                              fontSize: 11, color: AppColors.mutedBlue)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, WidgetRef ref, CardModel card, bool isDark) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkCard : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove Card?'),
        content: Text(
            'Remove ${card.cardType} ····${card.cardNumber} from your saved cards?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.mutedBlue)),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(cardProvider.notifier).removeCard(card.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Remove', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ── Card tile ─────────────────────────────────────────────────────────────────
class _CardTile extends StatelessWidget {
  final CardModel card;
  final bool isDark;
  final Color textColor;
  final Color subColor;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const _CardTile({
    required this.card,
    required this.isDark,
    required this.textColor,
    required this.subColor,
    required this.onSetDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSetDefault,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Card icon box
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.brandGold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: Text('💳', style: TextStyle(fontSize: 22))),
            ),
            const SizedBox(width: 14),

            // Card info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${card.cardType} ····${card.cardNumber}',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Expires ${card.expiry} · ${card.cardHolderName}',
                    style: TextStyle(fontSize: 12, color: subColor),
                  ),
                ],
              ),
            ),

            // Default badge or delete
            if (card.isDefault)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.brandGold.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: AppColors.brandGold.withOpacity(0.4)),
                ),
                child: const Text('Default',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.brandGold)),
              )
            else
              GestureDetector(
                onTap: onDelete,
                child: const Icon(Icons.delete_outline_rounded,
                    color: AppColors.error, size: 20),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final bool isDark;
  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.credit_card_off_rounded,
              size: 64, color: AppColors.mutedBlue.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text('No saved cards',
              style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.mutedBlue : AppColors.darkGray)),
          const SizedBox(height: 8),
          Text('Tap + Add New to add a card',
              style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? AppColors.mutedBlue.withOpacity(0.6)
                      : AppColors.darkGray.withOpacity(0.6))),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.push('/add-card'),
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Add New Card',
                style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGold,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24))),
          ),
        ],
      ),
    );
  }
}
