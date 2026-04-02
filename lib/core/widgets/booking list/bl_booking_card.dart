import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/model/booking_model.dart';

class BlBookingCard extends StatelessWidget {
  final BookingModel booking;
  final bool isDark;
  final VoidCallback onTrack;
  final VoidCallback onPayNow;
  final VoidCallback onCancel;
  final ValueChanged<String> onReceipt;
  final VoidCallback onRebook;
  final ValueChanged<String> onRate;
  final ValueChanged<String> onTap;

  const BlBookingCard({
    super.key,
    required this.booking,
    required this.isDark,
    required this.onTrack,
    required this.onPayNow,
    required this.onCancel,
    required this.onReceipt,
    required this.onRebook,
    required this.onRate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    return GestureDetector(
      onTap: () => onTap(booking.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: reference + status badge ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.reference,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                _StatusBadge(status: booking.status),
              ],
            ),
            const SizedBox(height: 12),

            // ── Pickup ──
            _LocationRow(
              dotColor: AppColors.brandGold,
              label: booking.pickup,
              subColor: subColor,
            ),
            const SizedBox(height: 6),

            // ── Dropoff ──
            _LocationRow(
              dotColor: AppColors.info,
              label: booking.dropoff,
              subColor: subColor,
            ),
            const SizedBox(height: 8),

            // ── Date + Amount ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('📅', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 6),
                    Text(
                      booking.date,
                      style: TextStyle(fontSize: 12, color: subColor),
                    ),
                  ],
                ),
                Text(
                  '£${booking.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // ── Action buttons ──
            _ActionButtons(
              booking: booking,
              isDark: isDark,
              onTrack: onTrack,
              onPayNow: onPayNow,
              onCancel: onCancel,
              onReceipt: onReceipt,
              onRebook: onRebook,
              onRate: onRate,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Location row ──────────────────────────────────────────────────────────────
class _LocationRow extends StatelessWidget {
  final Color dotColor;
  final String label;
  final Color subColor;

  const _LocationRow({
    required this.dotColor,
    required this.label,
    required this.subColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 5, backgroundColor: dotColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 13, color: subColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ── Status badge ──────────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  Color get _color {
    switch (status) {
      case 'upcoming':
        return AppColors.info;
      case 'completed':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.mutedBlue;
    }
  }

  String get _label {
    switch (status) {
      case 'upcoming':
        return 'Upcoming';
      case 'Past':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _color.withOpacity(0.4)),
      ),
      child: Text(
        _label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: _color,
        ),
      ),
    );
  }
}

// ── Action buttons ────────────────────────────────────────────────────────────
class _ActionButtons extends StatelessWidget {
  final BookingModel booking;
  final bool isDark;
  final VoidCallback onTrack;
  final VoidCallback onPayNow;
  final VoidCallback onCancel;
  final ValueChanged<String> onReceipt;
  final VoidCallback onRebook;
  final ValueChanged<String> onRate;

  const _ActionButtons({
    required this.booking,
    required this.isDark,
    required this.onTrack,
    required this.onPayNow,
    required this.onCancel,
    required this.onReceipt,
    required this.onRebook,
    required this.onRate,
  });

  @override
  Widget build(BuildContext context) {
    if (booking.status == 'upcoming') {
      return Row(
        children: [
          _Btn(label: '📍 Track', onTap: onTrack, isDark: isDark, filled: true),
          const SizedBox(width: 8),
          _Btn(label: '💳 Pay Now', onTap: onPayNow, isDark: isDark),
          const SizedBox(width: 8),
          _Btn(label: '✕ Cancel', onTap: onCancel, isDark: isDark),
        ],
      );
    }

    if (booking.status == 'completed') {
      return Row(
        children: [
          _Btn(
              label: '🧾 Receipt',
              onTap: () => onReceipt(booking.id),
              isDark: isDark,
              filled: true),
          const SizedBox(width: 8),
          _Btn(label: '🔁 Rebook', onTap: onRebook, isDark: isDark),
          const SizedBox(width: 8),
          _Btn(
              label: '⭐ Rate', onTap: () => onRate(booking.id), isDark: isDark),
        ],
      );
    }

    // Cancelled — no actions
    return const SizedBox.shrink();
  }
}

class _Btn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isDark;
  final bool filled;

  const _Btn({
    required this.label,
    required this.onTap,
    required this.isDark,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: filled
                ? AppColors.brandGold
                : (isDark ? AppColors.darkElevated : AppColors.lightGray),
            borderRadius: BorderRadius.circular(10),
            border: filled
                ? null
                : Border.all(color: AppColors.brandGold.withOpacity(0.3)),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: filled
                  ? Colors.white
                  : (isDark ? Colors.white70 : AppColors.darkGray),
            ),
          ),
        ),
      ),
    );
  }
}
