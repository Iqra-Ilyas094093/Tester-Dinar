import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/core/widgets/passenger_details_widgets/pd_section_card.dart';
import 'package:dinar_app/core/widgets/passenger_details_widgets/pd_addon_row.dart';
import 'package:dinar_app/core/widgets/passenger_details_widgets/pd_stepper_row.dart';
import 'package:dinar_app/core/widgets/passenger_details_widgets/pd_info_row.dart';
import 'package:dinar_app/core/widgets/passenger_details_widgets/pd_flight_field.dart';

class PassengerDetailsscreen extends StatefulWidget {
  const PassengerDetailsscreen({super.key});

  @override
  State<PassengerDetailsscreen> createState() => _PassengerDetailsscreenState();
}

class _PassengerDetailsscreenState extends State<PassengerDetailsscreen> {
  final _nameController = TextEditingController(text: 'John Smith');
  final _emailController = TextEditingController(text: 'john@email.com');
  final _phoneController = TextEditingController(text: '+44 7700 000000');
  final _flightController = TextEditingController(text: 'BA 2345');

  int _passengers = 2;
  int _suitcases = 2;
  bool _flightNumberEnabled = true;
  bool _babySeat = false;
  bool _meetAndGreet = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _flightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
        title: const Text('Passenger Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Contact Information
          const PdSectionLabel(label: 'CONTACT INFORMATION'),
          PdSectionCard(
            isDark: isDark,
            children: [
              PdInfoRow(
                  label: 'Full Name',
                  controller: _nameController,
                  isDark: isDark),
              PdDivider(isDark: isDark),
              PdInfoRow(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  isDark: isDark),
              PdDivider(isDark: isDark),
              PdInfoRow(
                  label: 'Phone',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  isDark: isDark),
            ],
          ),

          const SizedBox(height: 8),

          // Trip Details
          const PdSectionLabel(label: 'TRIP DETAILS'),
          PdSectionCard(
            isDark: isDark,
            children: [
              PdStepperRow(
                label: 'Passengers',
                value: _passengers,
                onDecrement: _passengers > 1
                    ? () => setState(() => _passengers--)
                    : null,
                onIncrement: _passengers < 8
                    ? () => setState(() => _passengers++)
                    : null,
                isDark: isDark,
              ),
              PdDivider(isDark: isDark),
              PdStepperRow(
                label: 'Suitcases',
                value: _suitcases,
                onDecrement:
                    _suitcases > 0 ? () => setState(() => _suitcases--) : null,
                onIncrement:
                    _suitcases < 8 ? () => setState(() => _suitcases++) : null,
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Add-ons
          const PdSectionLabel(label: 'ADD-ONS'),
          PdSectionCard(
            isDark: isDark,
            children: [
              PdAddonRow(
                icon: Icons.flight_rounded,
                title: 'Flight Number',
                subtitle: "We'll monitor delays",
                value: _flightNumberEnabled,
                onChanged: (v) => setState(() => _flightNumberEnabled = v),
                isDark: isDark,
              ),
              if (_flightNumberEnabled) ...[
                const SizedBox(height: 4),
                PdFlightField(controller: _flightController, isDark: isDark),
                const SizedBox(height: 8),
              ],
              PdDivider(isDark: isDark),
              PdAddonRow(
                emoji: '🧸',
                title: 'Baby Seat',
                subtitle: '+ £8.00',
                subtitleColor: AppColors.brandGold,
                value: _babySeat,
                onChanged: (v) => setState(() => _babySeat = v),
                isDark: isDark,
              ),
              PdDivider(isDark: isDark),
              PdAddonRow(
                icon: Icons.sign_language_rounded,
                title: 'Meet & Greet',
                subtitle: '+ £12.00',
                subtitleColor: AppColors.brandGold,
                value: _meetAndGreet,
                onChanged: (v) => setState(() => _meetAndGreet = v),
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Return Trip
          const PdSectionLabel(label: 'RETURN TRIP DETAILS'),
          PdSectionCard(
            isDark: isDark,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Same details will be used for return trip',
                  style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.mutedBlue : AppColors.darkGray),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Continue
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => context.push('/price-summary'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandGold,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26)),
                ),
                child: const Text('Continue',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
