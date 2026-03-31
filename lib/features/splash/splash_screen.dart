import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  Future<void> _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyDark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Container
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.flight_rounded,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            // App Name
            const Text(
              'DINAR',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.brandGold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'AIRPORT TRANSFERS',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.mutedBlue,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 60),
            // Loading Indicator
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.navyMid,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandGold),
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              'Version 1.1.0',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.mutedBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
