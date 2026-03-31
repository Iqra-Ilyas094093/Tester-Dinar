# 🛫 Dinar Airport Transfers - Flutter Mobile App

A comprehensive Flutter mobile application for airport transfer bookings with dual modes for Passengers and Drivers.

## 📱 Project Overview

**Version:** 1.2.0  
**Platform:** iOS & Android  
**Framework:** Flutter 3.x  
**State Management:** Riverpod 2.x  
**Navigation:** GoRouter 13.x  

### Key Features
- ✅ **28+ Fully Navigable Screens**
- ✅ **Complete Dark & Light Mode Support**
- ✅ **Dual App Mode** (Passenger + Driver)
- ✅ **Professional Theme System**
- ✅ **Proper State Management with Riverpod**
- ✅ **Type-Safe Navigation with GoRouter**

---

## 🎨 Brand Identity

### Color Palette
- **Brand Gold:** `#C89B3C` - Primary CTAs, highlights
- **Gold Light:** `#F5D98B` - Hover states, badges
- **Navy Dark:** `#1A2342` - Headers, dark backgrounds
- **Navy Mid:** `#2C3E6B` - Secondary elements

### Typography
- **Primary Font:** Inter (Google Fonts)
- **Accent Font:** Poppins SemiBold (for CTAs and prices)

---

## 📂 Project Structure

```
dinar_app/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── core/
│   │   ├── theme/
│   │   │   ├── app_colors.dart           # Color constants
│   │   │   ├── light_theme.dart          # Light mode theme
│   │   │   ├── dark_theme.dart           # Dark mode theme
│   │   │   └── theme_notifier.dart       # Theme state management
│   │   ├── router/
│   │   │   └── app_router.dart           # GoRouter configuration
│   │   └── widgets/
│   │       └── main_navigation.dart      # Bottom navigation
│   └── features/
│       ├── splash/
│       │   └── splash_screen.dart
│       ├── onboarding/
│       │   └── onboarding_screen.dart
│       ├── auth/
│       │   └── screens/
│       │       ├── login_screen.dart
│       │       ├── signup_screen.dart
│       │       └── forgot_password_screen.dart
│       ├── home/
│       │   └── passenger_home_screen.dart
│       ├── booking/                       # 6 screens
│       ├── tracking/                      # 1 screen
│       ├── bookings/                      # 3 screens
│       ├── rewards/                       # 3 screens
│       ├── profile/                       # 7 screens
│       └── driver/                        # 7 screens
└── pubspec.yaml                           # Dependencies
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions
- Xcode (for iOS development - macOS only)

### Installation

1. **Clone or extract the project**
   ```bash
   cd dinar_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # Run on connected device/emulator
   flutter run
   
   # Run in debug mode
   flutter run --debug
   
   # Run in release mode
   flutter run --release
   ```

4. **Build for production**
   ```bash
   # Android APK
   flutter build apk --release
   
   # Android App Bundle (for Play Store)
   flutter build appbundle --release
   
   # iOS (requires macOS)
   flutter build ios --release
   ```

---

## 📱 Complete Screen List

### 🔐 Authentication (3 screens)
1. **Splash Screen** - App logo and loading
2. **Onboarding** - 3-page introduction
3. **Login** - Email/password + biometric auth
4. **Sign Up** - User registration
5. **Forgot Password** - Password reset flow

### 🏠 Passenger App (18 screens)
6. **Home** - Map view + booking form
7. **Vehicle Selection** - Choose vehicle type
8. **Passenger Details** - Enter traveler info
9. **Price Summary** - Review booking cost
10. **Payment Card** - Stripe card payment
11. **Payment Cash** - Cash payment option
12. **Booking Confirmation** - Success screen
13. **Live Tracking** - Real-time driver tracking
14. **Bookings List** - View all bookings
15. **Booking Detail** - Individual booking view
16. **Rate & Review** - Rate completed trip
17. **Loyalty Rewards** - Points dashboard
18. **Points History** - Transaction history
19. **Redeem Points** - Use points for discounts
20. **Profile** - User profile view
21. **Edit Profile** - Update user info
22. **Saved Addresses** - Manage addresses
23. **Payment Methods** - Manage cards
24. **Settings** - App preferences
25. **Notifications** - Push notification center
26. **E-Receipt** - Downloadable receipt

### 🚗 Driver App (7 screens)
27. **Driver Login** - Driver authentication
28. **Driver Dashboard** - Job overview + stats
29. **Job List** - Available assignments
30. **Job Detail** - View job details
31. **Active Job** - Current job + navigation
32. **Earnings** - Income dashboard with charts
33. **Driver Profile** - Driver info + settings

---

## 🎨 Theme System

### Using Dark/Light Mode

The app automatically detects system theme preference and allows manual toggle:

```dart
// Toggle theme
ref.read(themeProvider.notifier).toggleTheme(isDark);

// Check current theme
final isDark = ref.watch(themeProvider.notifier).isDarkMode(context);
```

### Theme Toggle Locations
- Home screen (top-right icon)
- Settings screen
- Driver dashboard

---

## 🧭 Navigation Structure

### Passenger Routes
```
/splash → /onboarding → /login → /home (with bottom nav)
                      ↓
                   /signup

Bottom Navigation:
- /home (Home)
- /bookings (My Bookings)
- /rewards (Loyalty)
- /profile (Profile)
```

### Driver Routes
```
/driver-login → /driver-dashboard
              ↓
         /driver-jobs
         /driver-earnings
         /driver-profile
```

---

## 📦 Key Dependencies

```yaml
# State Management
flutter_riverpod: ^2.5.1

# Navigation
go_router: ^13.2.0

# HTTP & API
dio: ^5.4.3

# Payments
flutter_stripe: ^10.1.1

# Maps & Location
google_maps_flutter: ^2.6.0

# Firebase
firebase_core: ^3.0.0
firebase_messaging: ^15.0.0
firebase_analytics: ^11.0.0

# Authentication
local_auth: ^2.3.0
flutter_secure_storage: ^9.0.0

# UI & Animations
flutter_animate: ^4.5.0
lottie: ^3.1.0
cached_network_image: ^3.3.1

# Utilities
google_fonts: ^6.2.1
intl: ^0.19.0
share_plus: ^9.0.0
```

---

## 🔧 Configuration

### Environment Setup (Optional)

Create a `.env` file in the root directory for API keys:

```env
# API Configuration
API_BASE_URL=https://api.dinarairporttransfers.co.uk
API_KEY=your_api_key_here

# Stripe
STRIPE_PUBLISHABLE_KEY=pk_test_...

# Google Maps
GOOGLE_MAPS_API_KEY=AIza...

# Firebase
FIREBASE_PROJECT_ID=dinar-app
```

---

## 🎯 Development Workflow

### Phase 1: Foundation ✅
- [x] Project setup
- [x] Theme system (Dark/Light)
- [x] Navigation structure
- [x] Authentication screens
- [x] Bottom navigation

### Phase 2: Passenger Core ✅
- [x] Home screen with booking form
- [x] Booking flow (6 screens)
- [x] Bookings management (3 screens)
- [x] Profile & settings (7 screens)

### Phase 3: Advanced Features ✅
- [x] Live tracking screen
- [x] Loyalty rewards system (3 screens)
- [x] E-receipts

### Phase 4: Driver App ✅
- [x] Driver authentication
- [x] Driver dashboard
- [x] Job management (3 screens)
- [x] Earnings dashboard

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Integration tests
flutter drive --target=test_driver/app.dart
```

---

## 🚢 Deployment

### Android
1. Update version in `pubspec.yaml`
2. Build app bundle: `flutter build appbundle --release`
3. Upload to Google Play Console

### iOS
1. Update version in `pubspec.yaml` and Xcode
2. Build: `flutter build ios --release`
3. Archive and upload via Xcode

---

## 📄 License

Confidential - Dinar Airport Transfers © 2025

---

## 👥 Team

- **Iqra** - UI/UX Implementation, Theme System
- **Tayyab** - Backend Integration, API Setup
- **Laiba** - Passenger Features, Booking Flow

---

## 📞 Support

Website: [www.dinarairporttransfers.co.uk](https://www.dinarairporttransfers.co.uk)

---

## 🎉 Status

**Current Version: 1.2.0**

✅ **ALL 28+ SCREENS CREATED**  
✅ **FULL NAVIGATION WORKING**  
✅ **DARK & LIGHT MODE COMPLETE**  
✅ **PRODUCTION-READY STRUCTURE**

### What's Working:
- Complete navigation between all screens
- Dark/Light mode toggle throughout app
- Bottom navigation for passenger app
- Professional theme system
- All screen templates ready for backend integration

### Next Steps:
1. Add API integration with backend
2. Implement real payment processing (Stripe)
3. Add Google Maps integration
4. Implement Firebase push notifications
5. Add local storage for offline support
6. Implement real-time tracking
7. Add comprehensive error handling
8. Create unit and widget tests

---

**Ready to run with `flutter run`!** 🚀
