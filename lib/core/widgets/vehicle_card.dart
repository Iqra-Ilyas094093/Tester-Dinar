import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
//import '../model/vehicle_model.dart';
import 'package:dinar_app/model/vehicle_model.dart';

class VehicleCard extends StatelessWidget {
  final VehicleModel vehicle;
  final bool isSelected;
  final VoidCallback onTap;

  const VehicleCard({
    super.key,
    required this.vehicle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final subtitleColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.brandGold : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.brandGold.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: name + price
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vehicle.classLabel,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.brandGold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '£${vehicle.oneWayPrice.toInt()}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.brandGold,
                          height: 1,
                        ),
                      ),
                      Text(
                        'one way',
                        style: TextStyle(fontSize: 11, color: subtitleColor),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Return: £${vehicle.returnPrice.toInt()}',
                        style: TextStyle(fontSize: 12, color: subtitleColor),
                      ),
                    ],
                  ),
                ],
              ),

              // Emoji car
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    vehicle.emoji,
                    style: const TextStyle(fontSize: 64),
                  ),
                ),
              ),

              // Spec chips
              Row(
                children: [
                  _SpecChip(
                      icon: Icons.person_outline_rounded,
                      label: '${vehicle.pax} Pax'),
                  const SizedBox(width: 8),
                  _SpecChip(
                      icon: Icons.luggage_rounded,
                      label: '${vehicle.bags} Bags'),
                  if (vehicle.isStandard) ...[
                    const SizedBox(width: 8),
                    _SpecChip(
                        icon: Icons.timer_outlined,
                        label: '~${vehicle.etaMinutes} min'),
                  ],
                ],
              ),

              // Road charges note
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_outline_rounded,
                        size: 14, color: subtitleColor),
                    const SizedBox(width: 6),
                    Text(
                      'Road charges & tolls included in price',
                      style: TextStyle(fontSize: 12, color: subtitleColor),
                    ),
                  ],
                ),
              ),

              // Badges
              const Row(
                children: [
                  _BadgeChip(label: 'Fixed Price'),
                  SizedBox(width: 8),
                  _BadgeChip(label: 'Free Cancellation'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SpecChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkElevated : AppColors.lightGray,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.brandGold),
          const SizedBox(width: 4),
          Text(label,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final String label;

  const _BadgeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.brandGold, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.brandGold,
        ),
      ),
    );
  }
}
