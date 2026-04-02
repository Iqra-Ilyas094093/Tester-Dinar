import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class SavedAddressesscreen extends StatefulWidget {
  const SavedAddressesscreen({super.key});

  @override
  State<SavedAddressesscreen> createState() => _SavedAddressesscreenState();
}

class _SavedAddressesscreenState extends State<SavedAddressesscreen> {
  // Mock data — replace with API later
  final List<Map<String, dynamic>> _addresses = [
    {
      'id': '1',
      'label': 'Home',
      'address': '14 Grosvenor Sq, Mayfair, W1K 2HN',
      'emoji': '🏠',
      'color': const Color(0xFFE8A84C),
    },
    {
      'id': '2',
      'label': 'Work',
      'address': '1 Canada Square, Canary Wharf, E14 5AB',
      'emoji': '💼',
      'color': const Color(0xFF4C8CE8),
    },
    {
      'id': '3',
      'label': 'Heathrow T5',
      'address': 'Terminal 5, Heathrow Airport, TW6 2GA',
      'emoji': '⭐',
      'color': const Color(0xFFE8C84C),
    },
  ];

  void _deleteAddress(String id) {
    setState(() => _addresses.removeWhere((a) => a['id'] == id));
  }

  void _showAddDialog() {
    final labelCtrl = TextEditingController();
    final addressCtrl = TextEditingController();
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
            // Handle
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
            Text('Add New Address',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppColors.nearBlack)),
            const SizedBox(height: 16),

            // Label field
            _SheetField(
              controller: labelCtrl,
              hint: 'Label (e.g. Home, Work)',
              isDark: isDark,
            ),
            const SizedBox(height: 12),

            // Address field
            _SheetField(
              controller: addressCtrl,
              hint: 'Full address',
              isDark: isDark,
            ),
            const SizedBox(height: 20),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (labelCtrl.text.isNotEmpty &&
                      addressCtrl.text.isNotEmpty) {
                    setState(() {
                      _addresses.add({
                        'id': DateTime.now().toString(),
                        'label': labelCtrl.text,
                        'address': addressCtrl.text,
                        'emoji': '📍',
                        'color': AppColors.brandGold,
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
                child: const Text('Save Address',
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
        title: const Text('Saved Addresses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.brandGold, size: 26),
            onPressed: _showAddDialog,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Section label ──
          const Text(
            'YOUR SAVED ADDRESSES',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.mutedBlue,
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 10),

          // ── Address list ──
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(16),
            ),
            child: _addresses.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                      child: Text('No saved addresses yet',
                          style: TextStyle(color: AppColors.mutedBlue)),
                    ),
                  )
                : Column(
                    children: _addresses.asMap().entries.map((entry) {
                      final i = entry.key;
                      final addr = entry.value;
                      final isLast = i == _addresses.length - 1;

                      return Column(
                        children: [
                          _AddressTile(
                            label: addr['label'],
                            address: addr['address'],
                            emoji: addr['emoji'],
                            color: addr['color'],
                            isDark: isDark,
                            onDelete: () => _showDeleteDialog(
                                context, addr['id'], addr['label'], isDark),
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

          // ── Add New Address button ──
          GestureDetector(
            onTap: _showAddDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: cardBg,
                borderRadius: BorderRadius.circular(16),
              ),
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
                      Text('Add New Address',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.brandGold)),
                      Text('Save a custom location',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.mutedBlue)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // ── Tip card ──
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('💡', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tip: Saved addresses appear as quick-select chips on the Home screen, saving you time when booking.',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.mutedBlue : AppColors.darkGray,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
        title: const Text('Delete Address?'),
        content: Text('Remove "$label" from saved addresses?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.mutedBlue)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteAddress(id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ── Address tile ──────────────────────────────────────────────────────────────
class _AddressTile extends StatelessWidget {
  final String label;
  final String address;
  final String emoji;
  final Color color;
  final bool isDark;
  final VoidCallback onDelete;

  const _AddressTile({
    required this.label,
    required this.address,
    required this.emoji,
    required this.color,
    required this.isDark,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          // Icon box
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(emoji, style: const TextStyle(fontSize: 20)),
            ),
          ),
          const SizedBox(width: 14),

          // Label + address
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : AppColors.nearBlack)),
                const SizedBox(height: 2),
                Text(address,
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.mutedBlue),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),

          // Delete icon
          GestureDetector(
            onTap: onDelete,
            child: const Icon(Icons.remove_circle_outline_rounded,
                color: AppColors.mutedBlue, size: 20),
          ),
        ],
      ),
    );
  }
}

// ── Bottom sheet input field ──────────────────────────────────────────────────
class _SheetField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isDark;

  const _SheetField({
    required this.controller,
    required this.hint,
    required this.isDark,
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
