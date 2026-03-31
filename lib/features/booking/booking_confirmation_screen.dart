import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class BookingConfirmationscreen extends StatefulWidget {
  const BookingConfirmationscreen({super.key});

  @override
  State<BookingConfirmationscreen> createState() => _BookingConfirmationscreenState();
}

class _BookingConfirmationscreenState extends State<BookingConfirmationscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmed'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 80,
              color: AppColors.brandGold,
            ),
            const SizedBox(height: 24),
            Text(
              'Booking Confirmed',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              'Screen implementation coming soon',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
