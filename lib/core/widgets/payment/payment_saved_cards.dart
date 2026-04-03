import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/model/card_provider.dart';

class PaymentSavedCards extends ConsumerWidget {
  final bool isDark;
  const PaymentSavedCards({super.key, required this.isDark});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards = ref.watch(cardProvider);
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    return Column(
      children: [
        // ── Header row ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Saved Cards',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : AppColors.nearBlack,
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/add-card'),
              child: const Text(
                '+ Add New',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.brandGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // ── Use different card row ──
        GestureDetector(
          onTap: () => context.push('/saved-cards'),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cards.length <= 1
                      ? 'Use a different card →'
                      : 'Choose from ${cards.length} saved cards →',
                  style: TextStyle(fontSize: 14, color: subColor),
                ),
                if (cards.length > 1)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.brandGold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${cards.length}',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brandGold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:dinar_app/core/theme/app_colors.dart';

// class PaymentSavedCards extends StatelessWidget {
//   final bool isDark;
//   const PaymentSavedCards({super.key, required this.isDark});

//   @override
//   Widget build(BuildContext context) {
//     final cardBg = isDark ? AppColors.darkCard : Colors.white;

//     return Column(
//       children: [
//         // Header row
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               'Saved Cards',
//               style: TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//                 color: isDark ? Colors.white : AppColors.nearBlack,
//               ),
//             ),
//             GestureDetector(
//               onTap: () {},
//               child: const Text(
//                 '+ Add New',
//                 style: TextStyle(
//                   fontSize: 13,
//                   color: AppColors.brandGold,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),

//         // Use different card row
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//           decoration: BoxDecoration(
//             color: cardBg,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Text(
//             'Use a different card →',
//             style: TextStyle(
//               fontSize: 14,
//               color: isDark ? AppColors.mutedBlue : AppColors.darkGray,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
