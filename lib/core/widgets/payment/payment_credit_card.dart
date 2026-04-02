import 'package:flutter/material.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PaymentCreditCard extends StatelessWidget {
  const PaymentCreditCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2D50), Color(0xFF2C3E6B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyDark.withOpacity(0.5),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Chip icon
          Container(
            width: 36,
            height: 26,
            decoration: BoxDecoration(
              color: AppColors.brandGold,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const Spacer(),

          // Card number
          const Text(
            '••••  ••••  ••••  4242',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),

          // Cardholder + Expiry + Visa
          Row(
            children: [
              // Cardholder
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('CARDHOLDER',
                      style: TextStyle(
                          fontSize: 9,
                          color: AppColors.mutedBlue,
                          letterSpacing: 1)),
                  Text('John Smith',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              const SizedBox(width: 24),
              // Expiry
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('EXPIRES',
                      style: TextStyle(
                          fontSize: 9,
                          color: AppColors.mutedBlue,
                          letterSpacing: 1)),
                  Text('08/27',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
              const Spacer(),
              // VISA
              const Text(
                'VISA',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
