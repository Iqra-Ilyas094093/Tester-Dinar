# 🚀 QUICK START GUIDE

## Run This App in 3 Steps

### Step 1️⃣: Navigate to Project
```bash
cd dinar_app
```

### Step 2️⃣: Get Dependencies
```bash
flutter pub get
```

### Step 3️⃣: Run the App
```bash
flutter run
```

That's it! The app will launch on your connected device/emulator.

---

## 🎯 What You'll See

1. **Splash Screen** (3 seconds)
   - Dinar logo with gold gradient
   - Loading animation

2. **Onboarding** (Swipe through 3 pages)
   - Page 1: Easy Booking
   - Page 2: Live Tracking
   - Page 3: Earn Rewards
   - Click "Get Started" or "Skip"

3. **Login Screen**
   - Enter any email/password
   - Or click "Sign in with Biometrics"
   - Or click "Sign Up" for registration
   - Or click "Are you a driver?" for driver login

4. **Home Screen** (Main passenger interface)
   - Map view at top
   - Booking form with pickup/dropoff
   - Date and time selection
   - Saved addresses
   - Recent searches
   - "Search Vehicles" button

5. **Bottom Navigation** (4 tabs)
   - 🏠 Home
   - 📅 Bookings
   - ⭐ Rewards
   - 👤 Profile

---

## 🌓 Toggle Dark/Light Mode

**Method 1:** Click the moon/sun icon in the Home screen app bar (top right)

**Method 2:** Go to Profile → Settings → Appearance

The theme preference is saved and persists across app restarts!

---

## 📱 Test All Screens

### From Home Screen:
- Click "Search Vehicles" → **Vehicle Selection**
- Click Notifications icon → **Notifications**

### From Bookings Tab:
- View **Bookings List**
- Click any booking → **Booking Detail**
- Click "Rate" → **Rate & Review**

### From Rewards Tab:
- View **Loyalty Rewards** dashboard
- Click "View History" → **Points History**
- Click "Redeem" → **Redeem Points**

### From Profile Tab:
- View **Profile** screen
- Click "Edit Profile" → **Edit Profile**
- Click "Saved Addresses" → **Saved Addresses**
- Click "Payment Methods" → **Payment Methods**
- Click "Settings" → **Settings**
- Click "Notifications" → **Notifications**

### Test Driver App:
- Go back to Login
- Click "Are you a driver? Login here"
- Enter credentials → **Driver Dashboard**
- All driver screens accessible from there

---

## 🔧 Troubleshooting

### "flutter: command not found"
Make sure Flutter is installed and in your PATH:
```bash
flutter doctor
```

### "No devices found"
- Start an Android emulator, or
- Connect a physical device with USB debugging enabled

### "Packages not found"
Run:
```bash
flutter pub get
flutter clean
flutter pub get
```

### "Build failed"
Make sure you're using Flutter 3.0.0 or higher:
```bash
flutter --version
flutter upgrade
```

---

## 🎨 Customization

### Change Brand Colors
Edit `lib/core/theme/app_colors.dart`:
```dart
static const Color brandGold = Color(0xFFC89B3C);  // Change hex value
```

### Add New Screen
1. Create file in `lib/features/your_module/your_screen.dart`
2. Add route in `lib/core/router/app_router.dart`
3. Navigate with `context.push('/your-route')`

### Modify Theme
Edit `lib/core/theme/light_theme.dart` or `dark_theme.dart`

---

## 📚 Learn More

- **README.md** - Complete project documentation
- **PROJECT_COMPLETE.md** - Detailed feature list
- **Flutter Docs** - https://docs.flutter.dev

---

## ✅ You're All Set!

The app is ready to run with full navigation and dark/light mode working across all 28+ screens.

**Happy coding!** 🎉
