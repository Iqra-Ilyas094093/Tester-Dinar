import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class RouteInfoBar extends StatelessWidget {
  final String pickup;
  final String dropoff;
  final String date;
  final String time;

  const RouteInfoBar({
    super.key,
    required this.pickup,
    required this.dropoff,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: isDark ? AppColors.darkElevated : const Color(0xFF1E2A40),
      child: Row(
        children: [
          const Icon(Icons.flight_takeoff_rounded,
              size: 16, color: AppColors.brandGold),
          const SizedBox(width: 8),
          Text(
            pickup,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(Icons.arrow_forward_rounded,
                size: 14, color: AppColors.mutedBlue),
          ),
          Text(
            dropoff,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const Spacer(),
          Text(
            '$date · $time',
            style: const TextStyle(fontSize: 12, color: AppColors.mutedBlue),
          ),
        ],
      ),
    );
  }
}
