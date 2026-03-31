import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class PaymentMethodsscreen extends StatefulWidget {
  const PaymentMethodsscreen({super.key});

  @override
  State<PaymentMethodsscreen> createState() => _PaymentMethodsscreenState();
}

class _PaymentMethodsscreenState extends State<PaymentMethodsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
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
              Icons.payment_rounded,
              size: 80,
              color: AppColors.brandGold,
            ),
            const SizedBox(height: 24),
            Text(
              'Payment Methods',
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
