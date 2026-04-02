import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class RateReviewscreen extends StatefulWidget {
  final String bookingId;
  const RateReviewscreen({super.key, required this.bookingId});

  @override
  State<RateReviewscreen> createState() => _RateReviewscreenState();
}

class _RateReviewscreenState extends State<RateReviewscreen> {
  int _rating = 4;
  final List<String> _tags = [
    'Punctual',
    'Clean vehicle',
    'Friendly driver',
    'Smooth ride',
    'Good route'
  ];
  final Set<String> _selectedTags = {'Punctual', 'Clean vehicle'};
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
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
        title: const Text('Rate Your Ride'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Booking info card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(
                  'DNA-${widget.bookingId} · 2 Aug 2025',
                  style: TextStyle(fontSize: 12, color: subColor),
                ),
                const SizedBox(height: 6),
                Text(
                  'Gatwick North → Chelsea SW3',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mohammed Al-Rashid · £87.00',
                  style: TextStyle(fontSize: 13, color: subColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // ── How was your journey ──
          Text(
            'How was your journey?',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 20),

          // ── Star rating ──
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) {
              final filled = i < _rating;
              return GestureDetector(
                onTap: () => setState(() => _rating = i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Icons.star_rounded,
                    size: 52,
                    color: filled
                        ? AppColors.brandGold
                        : AppColors.mutedBlue.withOpacity(0.4),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Text(
            '$_rating out of 5 stars',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: subColor),
          ),
          const SizedBox(height: 28),

          // ── What went well ──
          Text(
            'WHAT WENT WELL?',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.mutedBlue,
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _tags.map((tag) {
              final selected = _selectedTags.contains(tag);
              return GestureDetector(
                onTap: () => setState(() {
                  selected ? _selectedTags.remove(tag) : _selectedTags.add(tag);
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.brandGold.withOpacity(0.15)
                        : (isDark ? AppColors.darkCard : Colors.white),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? AppColors.brandGold
                          : (isDark
                              ? AppColors.dividerDark
                              : AppColors.dividerLight),
                    ),
                  ),
                  child: Text(
                    selected ? '✓ $tag' : tag,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: selected ? AppColors.brandGold : subColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // ── Additional comments ──
          Text(
            'ADDITIONAL COMMENTS',
            style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.mutedBlue,
                letterSpacing: 1.2),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: TextField(
              controller: _commentController,
              maxLines: 4,
              style: TextStyle(fontSize: 14, color: textColor),
              decoration: InputDecoration(
                hintText: 'Great driver, very professional...',
                hintStyle: TextStyle(color: subColor, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // ── Submit button ──
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: _submitReview,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandGold,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)),
              ),
              child: const Text(
                'Submit Review',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _submitReview() {
    // API call goes here later
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Thank You! 🌟'),
        content: const Text('Your review has been submitted successfully.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            style:
                ElevatedButton.styleFrom(backgroundColor: AppColors.brandGold),
            child: const Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
