import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dinar_app/features/splash/splash_screen.dart';
import 'package:dinar_app/features/onboarding/onboarding_screen.dart';
import 'package:dinar_app/features/auth/screens/login_screen.dart';
import 'package:dinar_app/features/auth/screens/signup_screen.dart';
import 'package:dinar_app/features/auth/screens/forgot_password_screen.dart';
import 'package:dinar_app/features/home/passenger_home_screen.dart';
import 'package:dinar_app/features/booking/vehicle_selection_screen.dart';
import 'package:dinar_app/features/booking/passenger_details_screen.dart';
import 'package:dinar_app/features/booking/price_summary_screen.dart';
import 'package:dinar_app/features/booking/payment_card_screen.dart';
import 'package:dinar_app/features/booking/payment_cash_screen.dart';
import 'package:dinar_app/features/booking/booking_confirmation_screen.dart';
import 'package:dinar_app/features/tracking/live_tracking_screen.dart';
import 'package:dinar_app/features/bookings/bookings_list_screen.dart';
import 'package:dinar_app/features/bookings/booking_detail_screen.dart';
import 'package:dinar_app/features/bookings/rate_review_screen.dart';
import 'package:dinar_app/features/rewards/loyalty_rewards_screen.dart';
import 'package:dinar_app/features/rewards/points_history_screen.dart';
import 'package:dinar_app/features/rewards/redeem_points_screen.dart';
import 'package:dinar_app/features/profile/profile_screen.dart';
import 'package:dinar_app/features/profile/edit_profile_screen.dart';
import 'package:dinar_app/features/profile/saved_addresses_screen.dart';
import 'package:dinar_app/features/profile/payment_methods_screen.dart';
import 'package:dinar_app/features/profile/settings_screen.dart';
import 'package:dinar_app/features/profile/notifications_screen.dart';
import 'package:dinar_app/features/profile/e_receipt_screen.dart';
import 'package:dinar_app/features/driver/driver_login_screen.dart';
import 'package:dinar_app/features/driver/driver_dashboard_screen.dart';
import 'package:dinar_app/features/driver/job_list_screen.dart';
import 'package:dinar_app/features/driver/job_detail_screen.dart';
import 'package:dinar_app/features/driver/active_job_screen.dart';
import 'package:dinar_app/features/driver/earnings_screen.dart';
import 'package:dinar_app/features/driver/driver_profile_screen.dart';
import 'package:dinar_app/core/widgets/main_navigation.dart';
import 'package:dinar_app/features/booking/payment_cards/add_new_card_screen.dart';
import 'package:dinar_app/features/booking/payment_cards/saved_card_screen.dart';

import '../../features/rewards/refer_screen.dart';

// ── Navigator Keys ────────────────────────────────────────────────────────────
// rootNavigatorKey  → full-screen routes (NO bottom bar)
// shellNavigatorKey → tab routes only (WITH bottom bar)

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// ── Router ────────────────────────────────────────────────────────────────────

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    // ── Splash & Onboarding (no bottom bar) ──────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // ── Auth (no bottom bar) ─────────────────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),

    // ── Driver Auth (no bottom bar) ──────────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-login',
      builder: (context, state) => const DriverLoginscreen(),
    ),

    // ── Shell: ONLY these 4 screens show bottom bar ──────────────────────────
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainNavigation(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const PassengerHomeScreen(),
        ),
        GoRoute(
          path: '/bookings',
          builder: (context, state) => const BookingsListscreen(),
        ),
        GoRoute(
          path: '/rewards',
          builder: (context, state) => const LoyaltyRewardsscreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const Profilescreen(),
        ),
      ],
    ),

    // ── Booking Flow (no bottom bar) ────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/vehicle-selection',
      builder: (context, state) => const VehicleSelectionscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/passenger-details',
      builder: (context, state) => const PassengerDetailsscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/price-summary',
      builder: (context, state) => const PriceSummaryscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/payment-card',
      builder: (context, state) => const PaymentCardscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/payment-cash',
      builder: (context, state) => const PaymentCashscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/booking-confirmation',
      builder: (context, state) => const BookingConfirmationscreen(),
    ),

    // ── Tracking (no bottom bar) ─────────────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/live-tracking',
      builder: (context, state) => const LiveTrackingscreen(),
    ),

    // ── Booking Details (no bottom bar) ─────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/booking-detail/:id',
      builder: (context, state) =>
          BookingDetailscreen(bookingId: state.pathParameters['id']!),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/rate-review/:id',
      builder: (context, state) =>
          RateReviewscreen(bookingId: state.pathParameters['id']!),
    ),

    // ── Rewards sub-screens (no bottom bar) ──────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/points-history',
      builder: (context, state) => const PointsHistoryscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/redeem-points',
      builder: (context, state) => const RedeemPointsscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/refer',
      builder: (context, state) => const ReferScreen(),
    ),

    // ── Profile sub-screens (no bottom bar) ──────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/edit-profile',
      builder: (context, state) => const EditProfilescreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/saved-addresses',
      builder: (context, state) => const SavedAddressesscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/payment-methods',
      builder: (context, state) => const PaymentMethodsscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/settings',
      builder: (context, state) => const Settingsscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/notifications',
      builder: (context, state) => const Notificationsscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/e-receipt/:id',
      builder: (context, state) =>
          EReceiptscreen(bookingId: state.pathParameters['id']!),
    ),

    // ── Driver Routes (no bottom bar) ────────────────────────────────────────
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-dashboard',
      builder: (context, state) => const DriverDashboardscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-jobs',
      builder: (context, state) => const JobListscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-job-detail/:id',
      builder: (context, state) =>
          JobDetailscreen(jobId: state.pathParameters['id']!),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-active-job/:id',
      builder: (context, state) =>
          ActiveJobscreen(jobId: state.pathParameters['id']!),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-earnings',
      builder: (context, state) => const Earningsscreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/driver-profile',
      builder: (context, state) => const DriverProfilescreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/add-card',
      builder: (context, state) => const AddNewCardScreen(),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/saved-cards',
      builder: (context, state) => const SavedCardsScreen(),
    ),
  ],
);

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:dinar_app/features/splash/splash_screen.dart';
// import 'package:dinar_app/features/onboarding/onboarding_screen.dart';
// import 'package:dinar_app/features/auth/screens/login_screen.dart';
// import 'package:dinar_app/features/auth/screens/signup_screen.dart';
// import 'package:dinar_app/features/auth/screens/forgot_password_screen.dart';
// import 'package:dinar_app/features/home/passenger_home_screen.dart';
// import 'package:dinar_app/features/booking/vehicle_selection_screen.dart';
// import 'package:dinar_app/features/booking/passenger_details_screen.dart';
// import 'package:dinar_app/features/booking/price_summary_screen.dart';
// import 'package:dinar_app/features/booking/payment_card_screen.dart';
// import 'package:dinar_app/features/booking/payment_cash_screen.dart';
// import 'package:dinar_app/features/booking/booking_confirmation_screen.dart';
// import 'package:dinar_app/features/tracking/live_tracking_screen.dart';
// import 'package:dinar_app/features/bookings/bookings_list_screen.dart';
// import 'package:dinar_app/features/bookings/booking_detail_screen.dart';
// import 'package:dinar_app/features/bookings/rate_review_screen.dart';
// import 'package:dinar_app/features/rewards/loyalty_rewards_screen.dart';
// import 'package:dinar_app/features/rewards/points_history_screen.dart';
// import 'package:dinar_app/features/rewards/redeem_points_screen.dart';
// import 'package:dinar_app/features/profile/profile_screen.dart';
// import 'package:dinar_app/features/profile/edit_profile_screen.dart';
// import 'package:dinar_app/features/profile/saved_addresses_screen.dart';
// import 'package:dinar_app/features/profile/payment_methods_screen.dart';
// import 'package:dinar_app/features/profile/settings_screen.dart';
// import 'package:dinar_app/features/profile/notifications_screen.dart';
// import 'package:dinar_app/features/profile/e_receipt_screen.dart';
// import 'package:dinar_app/features/driver/driver_login_screen.dart';
// import 'package:dinar_app/features/driver/driver_dashboard_screen.dart';
// import 'package:dinar_app/features/driver/job_list_screen.dart';
// import 'package:dinar_app/features/driver/job_detail_screen.dart';
// import 'package:dinar_app/features/driver/active_job_screen.dart';
// import 'package:dinar_app/features/driver/earnings_screen.dart';
// import 'package:dinar_app/features/driver/driver_profile_screen.dart';
// import 'package:dinar_app/core/widgets/main_navigation.dart';

// final GoRouter appRouter = GoRouter(
//   initialLocation: '/splash',
//   routes: [
//     // Splash & Onboarding
//     GoRoute(
//       path: '/splash',
//       builder: (context, state) => const SplashScreen(),
//     ),
//     GoRoute(
//       path: '/onboarding',
//       builder: (context, state) => const OnboardingScreen(),
//     ),

//     // Auth Routes
//     GoRoute(
//       path: '/login',
//       builder: (context, state) => const LoginScreen(),
//     ),
//     GoRoute(
//       path: '/signup',
//       builder: (context, state) => const SignupScreen(),
//     ),
//     GoRoute(
//       path: '/forgot-password',
//       builder: (context, state) => const ForgotPasswordScreen(),
//     ),

//     // Driver Auth
//     GoRoute(
//       path: '/driver-login',
//       builder: (context, state) => const DriverLoginscreen(),
//     ),

//     // Main App with Bottom Navigation (Passenger)
//     ShellRoute(
//       builder: (context, state, child) {
//         return MainNavigation(child: child);
//       },
//       routes: [
//         GoRoute(
//           path: '/home',
//           builder: (context, state) => const PassengerHomeScreen(),
//         ),
//         GoRoute(
//           path: '/bookings',
//           builder: (context, state) => const BookingsListscreen(),
//         ),
//         GoRoute(
//           path: '/rewards',
//           builder: (context, state) => const LoyaltyRewardsscreen(),
//         ),
//         GoRoute(
//           path: '/profile',
//           builder: (context, state) => const Profilescreen(),
//         ),
//       ],
//     ),

//     // Booking Flow
//     GoRoute(
//       path: '/vehicle-selection',
//       builder: (context, state) => const VehicleSelectionscreen(),
//     ),
//     GoRoute(
//       path: '/passenger-details',
//       builder: (context, state) => const PassengerDetailsscreen(),
//     ),
//     GoRoute(
//       path: '/price-summary',
//       builder: (context, state) => const PriceSummaryscreen(),
//     ),
//     GoRoute(
//       path: '/payment-card',
//       builder: (context, state) => const PaymentCardscreen(),
//     ),
//     GoRoute(
//       path: '/payment-cash',
//       builder: (context, state) => const PaymentCashscreen(),
//     ),
//     GoRoute(
//       path: '/booking-confirmation',
//       builder: (context, state) => const BookingConfirmationscreen(),
//     ),

//     // Tracking & Details
//     GoRoute(
//       path: '/live-tracking',
//       builder: (context, state) => const LiveTrackingscreen(),
//     ),
//     GoRoute(
//       path: '/booking-detail/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return BookingDetailscreen(bookingId: id);
//       },
//     ),
//     GoRoute(
//       path: '/rate-review/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return RateReviewscreen(bookingId: id);
//       },
//     ),

//     // Rewards
//     GoRoute(
//       path: '/points-history',
//       builder: (context, state) => const PointsHistoryscreen(),
//     ),
//     GoRoute(
//       path: '/redeem-points',
//       builder: (context, state) => const RedeemPointsscreen(),
//     ),

//     // Profile & Settings
//     GoRoute(
//       path: '/edit-profile',
//       builder: (context, state) => const EditProfilescreen(),
//     ),
//     GoRoute(
//       path: '/saved-addresses',
//       builder: (context, state) => const SavedAddressesscreen(),
//     ),
//     GoRoute(
//       path: '/payment-methods',
//       builder: (context, state) => const PaymentMethodsscreen(),
//     ),
//     GoRoute(
//       path: '/settings',
//       builder: (context, state) => const Settingsscreen(),
//     ),
//     GoRoute(
//       path: '/notifications',
//       builder: (context, state) => const Notificationsscreen(),
//     ),
//     GoRoute(
//       path: '/e-receipt/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return EReceiptscreen(bookingId: id);
//       },
//     ),

//     // Driver Routes
//     GoRoute(
//       path: '/driver-dashboard',
//       builder: (context, state) => const DriverDashboardscreen(),
//     ),
//     GoRoute(
//       path: '/driver-jobs',
//       builder: (context, state) => const JobListscreen(),
//     ),
//     GoRoute(
//       path: '/driver-job-detail/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return JobDetailscreen(jobId: id);
//       },
//     ),
//     GoRoute(
//       path: '/driver-active-job/:id',
//       builder: (context, state) {
//         final id = state.pathParameters['id']!;
//         return ActiveJobscreen(jobId: id);
//       },
//     ),
//     GoRoute(
//       path: '/driver-earnings',
//       builder: (context, state) => const Earningsscreen(),
//     ),
//     GoRoute(
//       path: '/driver-profile',
//       builder: (context, state) => const DriverProfilescreen(),
//     ),
//   ],
// );
