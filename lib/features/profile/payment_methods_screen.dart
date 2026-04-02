import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PaymentMethodsscreen extends StatefulWidget {
  const PaymentMethodsscreen({super.key});

  @override
  State<PaymentMethodsscreen> createState() => _PaymentMethodsscreenState();
}

class _PaymentMethodsscreenState extends State<PaymentMethodsscreen> {
  // Mock cards — replace with API later
  final List<Map<String, dynamic>> _cards = [
    {
      'id': '1',
      'type': 'Visa',
      'last4': '4242',
      'expiry': '08/27',
      'holder': 'John Smith',
      'isDefault': true,
    },
    {
      'id': '2',
      'type': 'Mastercard',
      'last4': '8891',
      'expiry': '03/26',
      'holder': 'John Smith',
      'isDefault': false,
    },
  ];

  void _setDefault(String id) {
    setState(() {
      for (final c in _cards) {
        c['isDefault'] = c['id'] == id;
      }
    });
  }

  void _deleteCard(String id) {
    setState(() => _cards.removeWhere((c) => c['id'] == id));
  }

  void _showAddCard() {
    final numberCtrl = TextEditingController();
    final expiryCtrl = TextEditingController();
    final cvvCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.darkCard : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.mutedBlue.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Add New Card',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.nearBlack)),
            const SizedBox(height: 16),
            _SheetField(
                controller: numberCtrl,
                hint: 'Card Number',
                isDark: isDark,
                keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: _SheetField(
                        controller: expiryCtrl,
                        hint: 'MM/YY',
                        isDark: isDark,
                        keyboardType: TextInputType.number)),
                const SizedBox(width: 10),
                Expanded(
                    child: _SheetField(
                        controller: cvvCtrl,
                        hint: 'CVV',
                        isDark: isDark,
                        keyboardType: TextInputType.number)),
              ],
            ),
            const SizedBox(height: 10),
            _SheetField(
                controller: nameCtrl, hint: 'Cardholder Name', isDark: isDark),
            const SizedBox(height: 6),
            Row(
              children: const [
                Icon(Icons.lock_outline_rounded,
                    size: 12, color: AppColors.mutedBlue),
                SizedBox(width: 4),
                Text('Secured by Stripe · PCI DSS Compliant',
                    style: TextStyle(fontSize: 11, color: AppColors.mutedBlue)),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (numberCtrl.text.length >= 4) {
                    setState(() {
                      _cards.add({
                        'id': DateTime.now().toString(),
                        'type': 'Visa',
                        'last4': numberCtrl.text.replaceAll(' ', '').substring(
                            numberCtrl.text.replaceAll(' ', '').length - 4),
                        'expiry': expiryCtrl.text,
                        'holder': nameCtrl.text,
                        'isDefault': false,
                      });
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandGold,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)),
                ),
                child: const Text('Add Card',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
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
        title: const Text('Payment Methods'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── SAVED CARDS label ──
          const Text('SAVED CARDS',
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
            child: _cards.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                      child: Text('No saved cards',
                          style: TextStyle(color: AppColors.mutedBlue)),
                    ),
                  )
                : Column(
                    children: _cards.asMap().entries.map((entry) {
                      final i = entry.key;
                      final card = entry.value;
                      final isLast = i == _cards.length - 1;
                      return Column(
                        children: [
                          _CardTile(
                            card: card,
                            isDark: isDark,
                            onSetDefault: () => _setDefault(card['id']),
                            onDelete: () => _showDeleteDialog(
                                context,
                                card['id'],
                                '${card['type']} ····${card['last4']}',
                                isDark),
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

          // ── Add New Card ──
          GestureDetector(
            onTap: _showAddCard,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                  color: cardBg, borderRadius: BorderRadius.circular(16)),
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
                        color: AppColors.brandGold, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Add New Card',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.brandGold)),
                      Text('Visa, Mastercard, Amex accepted',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.mutedBlue)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Other Payment Methods ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: cardBg, borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Other Payment Methods',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.nearBlack)),
                const SizedBox(height: 14),

                // Cash
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text('💵', style: TextStyle(fontSize: 22))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Cash Payment',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('Pay driver at end of journey',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.mutedBlue)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.success.withOpacity(0.4)),
                      ),
                      child: const Text('Available',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.success)),
                    ),
                  ],
                ),
                Divider(height: 24, color: divColor),

                // Apple/Google Pay
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text('🍎', style: TextStyle(fontSize: 22))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Apple Pay / Google Pay',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          Text('Coming soon',
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.mutedBlue)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.mutedBlue.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Soon',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mutedBlue)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // ── Security note ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock_outline_rounded,
                  size: 13, color: AppColors.mutedBlue),
              SizedBox(width: 6),
              Text('All payments secured by Stripe · PCI DSS Level 1',
                  style: TextStyle(fontSize: 12, color: AppColors.mutedBlue)),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _showDeleteDialog(
      BuildContext context, String id, String label, bool isDark) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: isDark ? AppColors.darkCard : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove Card?'),
        content: Text('Remove $label from your saved cards?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.mutedBlue)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteCard(id);
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
  final Map<String, dynamic> card;
  final bool isDark;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const _CardTile({
    required this.card,
    required this.isDark,
    required this.onSetDefault,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDefault = card['isDefault'] as bool;

    return InkWell(
      onTap: onSetDefault,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            // Card icon
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.brandGold.withOpacity(0.15),
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
                  Text('${card['type']} ····${card['last4']}',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : AppColors.nearBlack)),
                  Text('Expires ${card['expiry']} · ${card['holder']}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.mutedBlue)),
                ],
              ),
            ),

            // Default badge or delete
            if (isDefault)
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

// ── Bottom sheet field ────────────────────────────────────────────────────────
class _SheetField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isDark;
  final TextInputType keyboardType;

  const _SheetField({
    required this.controller,
    required this.hint,
    required this.isDark,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkElevated : AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(
            fontSize: 14, color: isDark ? Colors.white : AppColors.nearBlack),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.mutedBlue, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
