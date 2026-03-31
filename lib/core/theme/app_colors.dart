import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color brandGold = Color(0xFFC89B3C);
  static const Color goldLight = Color(0xFFF5D98B);
  static const Color navyDark = Color(0xFF1A2342);
  static const Color navyMid = Color(0xFF2C3E6B);

  // Light Mode Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF8F6F2);
  static const Color lightGray = Color(0xFFF0EEE9);
  static const Color darkGray = Color(0xFF4A4A4A);
  static const Color nearBlack = Color(0xFF111111);

  // Dark Mode Colors
  static const Color darkBg = Color(0xFF121928);
  static const Color darkCard = Color(0xFF1E2A3B);
  static const Color darkElevated = Color(0xFF2C3A50);
  static const Color mutedBlue = Color(0xFF9AA5B4);

  // Status Colors
  static const Color error = Color(0xFFC62828);
  static const Color errorLight = Color(0xFFEF9A9A);
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFFA5D6A7);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // Dividers
  static const Color dividerLight = Color(0xFFD0CECC);
  static const Color dividerDark = Color(0xFF2C3A50);

  // Gradients
  static const LinearGradient goldGradient = LinearGradient(
    colors: [brandGold, goldLight],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient navyGradient = LinearGradient(
    colors: [navyDark, navyMid],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
