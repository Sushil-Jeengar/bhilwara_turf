import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // Legacy static accessors (for screens not yet migrated)
  static const Color primaryGreen = Color(0xFF4CAF50);
  static const Color darkGreen = Color(0xFF388E3C);
  static const Color backgroundColor = Color(0xFF121212);
  static const Color cardColor = Color(0xFF1E1E1E);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFF9E9E9E);
  static const Color accentOrange = Color(0xFFFF7043);
  static const Color accentYellow = Color(0xFFFFB300);

  static ThemeData get darkTheme => _buildTheme(AppColors.dark);
  static ThemeData get lightTheme => _buildTheme(AppColors.light);

  static ThemeData _buildTheme(AppColors colors) {
    final isDark = colors.isDark;

    return ThemeData(
      brightness: colors.brightness,
      primarySwatch: Colors.green,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      cardColor: colors.surface,
      fontFamily: 'Inter',
      extensions: [colors],

      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: colors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: colors.textPrimary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          elevation: isDark ? 0 : 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.inputFill,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.cardBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colors.primary, width: 1.5),
        ),
        hintStyle: TextStyle(color: colors.textHint),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),

      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: isDark ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          side: BorderSide(color: colors.cardBorder),
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.navBar,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: isDark ? 0 : 4,
      ),

      textTheme: TextTheme(
        headlineLarge: TextStyle(color: colors.textPrimary, fontSize: 32, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: colors.textPrimary, fontSize: 24, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: colors.textPrimary, fontSize: 16),
        bodyMedium: TextStyle(color: colors.textSecondary, fontSize: 14),
      ),

      dividerColor: colors.divider,
      colorScheme: isDark
          ? ColorScheme.dark(primary: colors.primary, surface: colors.surface, error: colors.error)
          : ColorScheme.light(primary: colors.primary, surface: colors.surface, error: colors.error),
    );
  }
}