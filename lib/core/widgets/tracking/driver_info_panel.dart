import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/features/tracking/models/tracking_data.dart';

class DriverInfoPanel extends StatelessWidget {
  final TrackingData data;
  final VoidCallback? onCallDriver;
  final VoidCallback? onMessage;
  final VoidCallback? onCancel;

  const DriverInfoPanel({
    super.key,
    required this.data,
    this.onCallDriver,
    this.onMessage,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.navyDark,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: AppColors.mutedBlue.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          _DriverRow(data: data),
          const SizedBox(height: 16),
          _ActionButtonsRow(
            onCallDriver: onCallDriver,
            onMessage: onMessage,
            onCancel: onCancel,
          ),
        ],
      ),
    );
  }
}

class _DriverRow extends StatelessWidget {
  final TrackingData data;
  const _DriverRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.navyMid,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
              child:
                  Text(data.driverEmoji, style: const TextStyle(fontSize: 28))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.driverName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(data.vehicleInfo,
                  style: const TextStyle(
                      color: AppColors.mutedBlue, fontSize: 12)),
              const SizedBox(height: 4),
              Text(data.licensePlate,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1)),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('RATING',
                style: TextStyle(
                    color: AppColors.mutedBlue,
                    fontSize: 10,
                    letterSpacing: 1)),
            const SizedBox(height: 4),
            Row(children: [
              const Icon(Icons.star_rounded,
                  color: AppColors.brandGold, size: 16),
              const SizedBox(width: 3),
              Text(data.rating.toStringAsFixed(1),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
            ]),
          ],
        ),
      ],
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final VoidCallback? onCallDriver;
  final VoidCallback? onMessage;
  final VoidCallback? onCancel;

  const _ActionButtonsRow({this.onCallDriver, this.onMessage, this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionBtn(
            icon: Icons.call_rounded,
            label: 'Call Driver',
            onTap: onCallDriver),
        const SizedBox(width: 10),
        _ActionBtn(
            icon: Icons.chat_bubble_outline_rounded,
            label: 'Message',
            onTap: onMessage),
        const SizedBox(width: 10),
        _ActionBtn(
            icon: Icons.close_rounded,
            label: 'Cancel',
            onTap: onCancel,
            isDestructive: true),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;

  const _ActionBtn(
      {required this.icon,
      required this.label,
      this.onTap,
      this.isDestructive = false});

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : Colors.white70;
    final borderColor = isDestructive
        ? AppColors.error.withOpacity(0.6)
        : AppColors.mutedBlue.withOpacity(0.4);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(label,
                  style: TextStyle(
                      color: color, fontSize: 12, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
