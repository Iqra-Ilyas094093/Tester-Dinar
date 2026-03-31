import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/theme/theme_notifier.dart';

class PassengerHomeScreen extends ConsumerStatefulWidget {
  const PassengerHomeScreen({super.key});

  @override
  ConsumerState<PassengerHomeScreen> createState() => _PassengerHomeScreenState();
}

class _PassengerHomeScreenState extends ConsumerState<PassengerHomeScreen> {
  int _tripType = 0; // 0 = One Way, 1 = Return
  final _pickupController = TextEditingController(text: 'Heathrow Airport T5');
  final _dropoffController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 30);

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider.notifier).isDarkMode(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.flight_rounded, color: AppColors.brandGold, size: 24),
            const SizedBox(width: 8),
            const Text('DINAR'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/notifications'),
          ),
          IconButton(
            icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme(!isDark);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Section
            Container(
              height: 250,
              color: isDark ? AppColors.darkCard : AppColors.lightGray,
              child: Stack(
                children: [
                  // Placeholder for map
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_rounded,
                          size: 60,
                          color: AppColors.mutedBlue.withOpacity(0.3),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Map View',
                          style: TextStyle(
                            color: AppColors.mutedBlue.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Drop Pin Button
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton.small(
                      onPressed: () {},
                      backgroundColor: AppColors.brandGold,
                      child: const Icon(Icons.add_location_alt_rounded),
                    ),
                  ),
                ],
              ),
            ),

            // Booking Form
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trip Type Toggle
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkElevated : AppColors.lightGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _TripTypeButton(
                            label: 'One Way',
                            isSelected: _tripType == 0,
                            onTap: () => setState(() => _tripType = 0),
                          ),
                        ),
                        Expanded(
                          child: _TripTypeButton(
                            label: 'Return',
                            isSelected: _tripType == 1,
                            onTap: () => setState(() => _tripType = 1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Pickup Location
                  _LocationField(
                    icon: Icons.radio_button_checked_rounded,
                    iconColor: AppColors.brandGold,
                    label: 'Pickup Location',
                    controller: _pickupController,
                  ),
                  const SizedBox(height: 16),

                  // Add Stop Button
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, size: 18),
                    label: const Text('Add intermediate stop'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.mutedBlue,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Dropoff Location
                  _LocationField(
                    icon: Icons.location_on_rounded,
                    iconColor: AppColors.error,
                    label: 'Drop-off location',
                    controller: _dropoffController,
                    hintText: 'Enter destination',
                  ),
                  const SizedBox(height: 20),

                  // Date and Time
                  Row(
                    children: [
                      Expanded(
                        child: _DateTimeCard(
                          icon: Icons.calendar_today_rounded,
                          label: '15 Aug 2025',
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _DateTimeCard(
                          icon: Icons.access_time_rounded,
                          label: '09:30 AM',
                          onTap: () => _selectTime(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Saved Addresses Section
                  Text(
                    'SAVED ADDRESSES',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.mutedBlue,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _SavedAddressChip(icon: Icons.home_rounded, label: 'Mayfair W1K'),
                        _SavedAddressChip(icon: Icons.work_rounded, label: 'Canary Wharf'),
                        _SavedAddressChip(icon: Icons.star_rounded, label: 'Heathrow'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Recent Searches
                  Text(
                    'RECENT SEARCHES',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.mutedBlue,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _RecentSearch(from: 'Gatwick', to: 'Kensington'),
                  _RecentSearch(from: 'LHR T2', to: 'Chelsea'),
                  const SizedBox(height: 24),

                  // Search Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => context.push('/vehicle-selection'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandGold,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Search Vehicles',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }
}

class _TripTypeButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TripTypeButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandGold : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.mutedBlue,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _LocationField extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final TextEditingController? controller;
  final String? hintText;

  const _LocationField({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText ?? label,
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const Icon(Icons.search_rounded, color: AppColors.mutedBlue),
      ],
    );
  }
}

class _DateTimeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DateTimeCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkElevated : AppColors.lightGray,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.brandGold),
            const SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _SavedAddressChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SavedAddressChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkElevated : AppColors.lightGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.brandGold),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _RecentSearch extends StatelessWidget {
  final String from;
  final String to;

  const _RecentSearch({
    required this.from,
    required this.to,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.history_rounded, size: 20, color: AppColors.mutedBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$from → $to',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
