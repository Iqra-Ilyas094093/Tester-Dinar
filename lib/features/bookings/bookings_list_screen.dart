import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/widgets/booking%20list/bl_search_bar.dart';
import 'package:dinar_app/core/widgets/booking%20list/bl_tab_bar.dart';
import 'package:dinar_app/core/widgets/booking%20list/bl_booking_card.dart';
import 'package:dinar_app/model/booking_model.dart';

class BookingsListscreen extends StatefulWidget {
  const BookingsListscreen({super.key});

  @override
  State<BookingsListscreen> createState() => _BookingsListscreenState();
}

class _BookingsListscreenState extends State<BookingsListscreen> {
  int _selectedTab = 0; // 0=Upcoming, 1=Past, 2=Cancelled
  String _searchQuery = '';

  List<BookingModel> get _filteredBookings {
    final status = ['Upcoming', 'Past', 'Cancelled'][_selectedTab];
    return kMockBookings.where((b) {
      final matchesTab = b.status == status;
      final matchesSearch = _searchQuery.isEmpty ||
          b.reference.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesTab && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Title ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Text(
                'My Bookings',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.nearBlack,
                ),
              ),
            ),

            // ── Search ──
            BlSearchBar(
              isDark: isDark,
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
            const SizedBox(height: 16),

            // ── Tabs ──
            BlTabBar(
              selectedTab: _selectedTab,
              onTabChanged: (i) => setState(() => _selectedTab = i),
              isDark: isDark,
            ),
            const SizedBox(height: 16),

            // ── List ──
            Expanded(
              child: _filteredBookings.isEmpty
                  ? _EmptyState(isDark: isDark)
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemCount: _filteredBookings.length,
                      itemBuilder: (context, index) {
                        return BlBookingCard(
                          booking: _filteredBookings[index],
                          isDark: isDark,
                          onTrack: () => context.push('/live-tracking'),
                          onPayNow: () => context.push('/payment-card'),
                          onCancel: () => _showCancelDialog(
                              context, _filteredBookings[index]),
                          onReceipt: (id) => context.push('/e-receipt/$id'),
                          onRebook: () => context.push('/vehicle-selection'),
                          onRate: (id) => context.push('/rate-review/$id'),
                          onTap: (id) => context.push('/booking-detail/$id'),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, BookingModel booking) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkCard
            : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancel Booking?'),
        content: Text('Are you sure you want to cancel ${booking.reference}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('No', style: TextStyle(color: AppColors.mutedBlue)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Yes, Cancel',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isDark;
  const _EmptyState({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_rounded,
              size: 64, color: AppColors.mutedBlue.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text('No bookings found',
              style: TextStyle(
                fontSize: 16,
                color: isDark ? AppColors.mutedBlue : AppColors.darkGray,
              )),
        ],
      ),
    );
  }
}
