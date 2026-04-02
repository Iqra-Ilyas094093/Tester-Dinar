import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class Notificationsscreen extends StatefulWidget {
  const Notificationsscreen({super.key});

  @override
  State<Notificationsscreen> createState() => _NotificationsscreenState();
}

class _NotificationsscreenState extends State<Notificationsscreen> {
  final List<_NotifItem> _notifs = [
    _NotifItem(
      id: '1',
      emoji: '🚗',
      title: 'Driver Assigned',
      body:
          'Mohammed has been assigned to booking DNA-2025-7841. Pick-up at 09:30.',
      time: '2 mins ago',
      isUnread: true,
    ),
    _NotifItem(
      id: '2',
      emoji: '✅',
      title: 'Booking Confirmed',
      body:
          'Your Heathrow T5 transfer on 15 Aug is confirmed. Ref: DNA-2025-7841.',
      time: '12 mins ago',
      isUnread: true,
    ),
    _NotifItem(
      id: '3',
      emoji: '🎁',
      title: 'Exclusive Offer',
      body:
          'Use DINAR20 for 20% off your next booking. Valid until 31 Aug 2025.',
      time: 'Yesterday · 3:45 PM',
      isUnread: false,
    ),
    _NotifItem(
      id: '4',
      emoji: '⭐',
      title: 'Rate Your Ride',
      body: 'How was your transfer on 2 Aug? Your feedback helps our drivers.',
      time: '3 Aug 2025',
      isUnread: false,
    ),
    _NotifItem(
      id: '5',
      emoji: '🚀',
      title: 'Trip Complete',
      body:
          'Your journey from Gatwick to Chelsea is now complete. Thanks for choosing Dinar!',
      time: '2 Aug · 16:20',
      isUnread: false,
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (final n in _notifs) {
        n.isUnread = false;
      }
    });
  }

  void _deleteNotif(String id) {
    setState(() => _notifs.removeWhere((n) => n.id == id));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final unreadCount = _notifs.where((n) => n.isUnread).length;

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
        title: const Text('Notifications'),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllRead,
              child: const Text('Mark all read',
                  style: TextStyle(
                      color: AppColors.brandGold,
                      fontWeight: FontWeight.w600,
                      fontSize: 13)),
            ),
        ],
      ),
      body: _notifs.isEmpty
          ? _EmptyState(isDark: isDark)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemCount: _notifs.length,
              itemBuilder: (context, index) {
                final notif = _notifs[index];
                return _NotifCard(
                  notif: notif,
                  isDark: isDark,
                  onDismiss: () => _deleteNotif(notif.id),
                  onTap: () {
                    setState(() => notif.isUnread = false);
                  },
                );
              },
            ),
    );
  }
}

// ── Data class ────────────────────────────────────────────────────────────────
class _NotifItem {
  final String id;
  final String emoji;
  final String title;
  final String body;
  final String time;
  bool isUnread;

  _NotifItem({
    required this.id,
    required this.emoji,
    required this.title,
    required this.body,
    required this.time,
    required this.isUnread,
  });
}

// ── Notification card ─────────────────────────────────────────────────────────
class _NotifCard extends StatelessWidget {
  final _NotifItem notif;
  final bool isDark;
  final VoidCallback onDismiss;
  final VoidCallback onTap;

  const _NotifCard({
    required this.notif,
    required this.isDark,
    required this.onDismiss,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = isDark ? AppColors.darkCard : Colors.white;
    final textColor = isDark ? Colors.white : AppColors.nearBlack;
    final subColor = isDark ? AppColors.mutedBlue : AppColors.darkGray;

    return Dismissible(
      key: Key(notif.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete_outline_rounded,
            color: Colors.white, size: 24),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(16),
            border: notif.isUnread
                ? Border.all(
                    color: AppColors.brandGold.withOpacity(0.25), width: 1)
                : null,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emoji icon box
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkElevated : AppColors.lightGray,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child:
                      Text(notif.emoji, style: const TextStyle(fontSize: 22)),
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(notif.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                        ),
                        // Unread dot
                        if (notif.isUnread)
                          Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              color: AppColors.brandGold,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(notif.body,
                        style: TextStyle(
                            fontSize: 12, color: subColor, height: 1.4)),
                    const SizedBox(height: 6),
                    Text(notif.time,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.mutedBlue)),
                  ],
                ),
              ),
            ],
          ),
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
          Icon(Icons.notifications_off_outlined,
              size: 64, color: AppColors.mutedBlue.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text('No notifications',
              style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.mutedBlue : AppColors.darkGray)),
        ],
      ),
    );
  }
}
