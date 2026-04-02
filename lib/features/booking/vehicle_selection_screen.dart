import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';
import 'package:dinar_app/model/vehicle_model.dart';
import 'package:dinar_app/core/widgets/vehicle_card.dart';
import 'package:dinar_app/core/widgets/routes_info_bar.dart';

class VehicleSelectionscreen extends StatefulWidget {
  const VehicleSelectionscreen({super.key});

  @override
  State<VehicleSelectionscreen> createState() => _VehicleSelectionscreenState();
}

class _VehicleSelectionscreenState extends State<VehicleSelectionscreen> {
  String? _selectedVehicleId;

  void _onVehicleTapped(String id) {
    setState(() => _selectedVehicleId = id);
  }

  void _onContinue() {
    if (_selectedVehicleId == null) return;
    context.push('/passenger-details');
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
        title: const Text('Select Vehicle'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RouteInfoBar(
            pickup: 'Heathrow T5',
            dropoff: 'Mayfair W1K',
            date: '15 Aug',
            time: '09:30',
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 16, 4),
            child: Text(
              '${kVehicles.length} VEHICLES AVAILABLE',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.mutedBlue,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 100),
              itemCount: kVehicles.length,
              itemBuilder: (context, index) {
                final vehicle = kVehicles[index];
                return VehicleCard(
                  vehicle: vehicle,
                  isSelected: _selectedVehicleId == vehicle.id,
                  onTap: () => _onVehicleTapped(vehicle.id),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _selectedVehicleId != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
