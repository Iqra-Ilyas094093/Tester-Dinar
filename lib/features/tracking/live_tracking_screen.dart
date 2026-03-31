import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class LiveTrackingscreen extends StatefulWidget {
  const LiveTrackingscreen({super.key});

  @override
  State<LiveTrackingscreen> createState() => _LiveTrackingscreenState();
}

class _LiveTrackingscreenState extends State<LiveTrackingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Tracking'),
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
              Icons.my_location_rounded,
              size: 80,
              color: AppColors.brandGold,
            ),
            const SizedBox(height: 24),
            Text(
              'Live Tracking',
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
