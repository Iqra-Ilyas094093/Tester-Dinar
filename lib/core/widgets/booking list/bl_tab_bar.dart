import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BlTabBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabChanged;
  final bool isDark;

  const BlTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Upcoming', 'Past', 'Cancelled'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightGray,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.brandGold.withOpacity(0.3)),
        ),
        child: Row(
          children: List.generate(tabs.length, (i) {
            final isSelected = selectedTab == i;
            return Expanded(
              child: GestureDetector(
                onTap: () => onTabChanged(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.brandGold : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.mutedBlue,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
