import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class RateReviewscreen extends StatefulWidget {
  final String bookingId;
  
  const RateReviewscreen({super.key, required this.bookingId});

  @override
  State<RateReviewscreen> createState() => _RateReviewscreenState();
}

class _RateReviewscreenState extends State<RateReviewscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate & Review'),
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
              Icons.star_rounded,
              size: 80,
              color: AppColors.brandGold,
            ),
            const SizedBox(height: 24),
            Text(
              'Rate & Review',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              'ID: ${widget.bookingId}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
