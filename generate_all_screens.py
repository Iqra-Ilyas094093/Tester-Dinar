#!/usr/bin/env python3
"""
Generate all remaining Dinar App Flutter screens with proper structure
"""

import os

# Screen templates
SCREEN_TEMPLATE = """import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class {class_name} extends StatefulWidget {{
  const {class_name}({{super.key}});

  @override
  State<{class_name}> createState() => _{class_name}State();
}}

class _{class_name}State extends State<{class_name}> {{
  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        title: const Text('{title}'),
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
              {icon},
              size: 80,
              color: AppColors.brandGold,
            ),
            const SizedBox(height: 24),
            Text(
              '{title}',
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
  }}
}}
"""

SCREEN_WITH_PARAM_TEMPLATE = """import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/core/theme/app_colors.dart';

class {class_name} extends StatefulWidget {{
  final String {param_name};
  
  const {class_name}({{super.key, required this.{param_name}}});

  @override
  State<{class_name}> createState() => _{class_name}State();
}}

class _{class_name}State extends State<{class_name}> {{
  @override
  Widget build(BuildContext context) {{
    return Scaffold(
      appBar: AppBar(
        title: const Text('{title}'),
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
              {icon},
              size: 80,
              color: AppColors.brandGold,
            ),
            const SizedBox(height: 24),
            Text(
              '{title}',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 16),
            Text(
              'ID: ${{widget.{param_name}}}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }}
}}
"""

def snake_to_pascal(snake_str):
    """Convert snake_case to PascalCase"""
    return ''.join(word.capitalize() for word in snake_str.split('_'))

def generate_screen(filename, title, icon, folder, param_name=None):
    """Generate a screen file"""
    class_name = snake_to_pascal(filename.replace('_screen', 'Screen'))
    
    if param_name:
        content = SCREEN_WITH_PARAM_TEMPLATE.format(
            class_name=class_name,
            title=title,
            icon=icon,
            param_name=param_name
        )
    else:
        content = SCREEN_TEMPLATE.format(
            class_name=class_name,
            title=title,
            icon=icon
        )
    
    filepath = f"lib/features/{folder}/{filename}.dart"
    os.makedirs(os.path.dirname(filepath), exist_ok=True)
    
    with open(filepath, 'w') as f:
        f.write(content)
    
    print(f"✓ Created {filepath}")

# Define all screens to generate
screens = [
    # Booking Flow
    ("booking", "vehicle_selection_screen", "Vehicle Selection", "Icons.directions_car_rounded", None),
    ("booking", "passenger_details_screen", "Passenger Details", "Icons.person_outline_rounded", None),
    ("booking", "price_summary_screen", "Price Summary", "Icons.receipt_long_rounded", None),
    ("booking", "payment_card_screen", "Card Payment", "Icons.credit_card_rounded", None),
    ("booking", "payment_cash_screen", "Cash Payment", "Icons.payments_rounded", None),
    ("booking", "booking_confirmation_screen", "Booking Confirmed", "Icons.check_circle_rounded", None),
    
    # Tracking
    ("tracking", "live_tracking_screen", "Live Tracking", "Icons.my_location_rounded", None),
    
    # Bookings
    ("bookings", "bookings_list_screen", "My Bookings", "Icons.calendar_today_rounded", None),
    ("bookings", "booking_detail_screen", "Booking Details", "Icons.info_outline_rounded", "bookingId"),
    ("bookings", "rate_review_screen", "Rate & Review", "Icons.star_rounded", "bookingId"),
    
    # Rewards
    ("rewards", "loyalty_rewards_screen", "Loyalty Rewards", "Icons.card_giftcard_rounded", None),
    ("rewards", "points_history_screen", "Points History", "Icons.history_rounded", None),
    ("rewards", "redeem_points_screen", "Redeem Points", "Icons.redeem_rounded", None),
    
    # Profile
    ("profile", "profile_screen", "Profile", "Icons.person_rounded", None),
    ("profile", "edit_profile_screen", "Edit Profile", "Icons.edit_rounded", None),
    ("profile", "saved_addresses_screen", "Saved Addresses", "Icons.location_on_rounded", None),
    ("profile", "payment_methods_screen", "Payment Methods", "Icons.payment_rounded", None),
    ("profile", "settings_screen", "Settings", "Icons.settings_rounded", None),
    ("profile", "notifications_screen", "Notifications", "Icons.notifications_rounded", None),
    ("profile", "e_receipt_screen", "E-Receipt", "Icons.receipt_rounded", "bookingId"),
    
    # Driver App
    ("driver", "driver_login_screen", "Driver Login", "Icons.local_taxi_rounded", None),
    ("driver", "driver_dashboard_screen", "Driver Dashboard", "Icons.dashboard_rounded", None),
    ("driver", "job_list_screen", "Available Jobs", "Icons.work_outline_rounded", None),
    ("driver", "job_detail_screen", "Job Details", "Icons.assignment_rounded", "jobId"),
    ("driver", "active_job_screen", "Active Job", "Icons.navigation_rounded", "jobId"),
    ("driver", "earnings_screen", "Earnings", "Icons.account_balance_wallet_rounded", None),
    ("driver", "driver_profile_screen", "Driver Profile", "Icons.badge_rounded", None),
]

# Generate all screens
print("Generating all Dinar App screens...\n")
for folder, filename, title, icon, param in screens:
    generate_screen(filename, title, icon, folder, param)

print(f"\n✅ Successfully generated {len(screens)} screen files!")
print("\nAll screens are now ready with:")
print("  - Proper navigation structure")
print("  - Theme integration (Light/Dark mode)")
print("  - AppBar with back navigation")
print("  - Placeholder content")
