import 'package:flutter/material.dart';

/// Centralized color tokens for the app.
/// Access via: `AppColors.of(context)` — automatically adapts to light/dark mode.
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color textHint;
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color accent;
  final Color accentWarm;
  final Color error;
  final Color success;
  final Color warning;
  final Color divider;
  final Color cardBorder;
  final Color selectedChipBg;
  final Color unselectedChipBg;
  final Color navBar;
  final Color bottomBarBg;
  final Color inputFill;
  final Color shadow;
  final Color overlay;
  final Color ratingStarColor;
  final Color badgeAvailable;
  final Color badgeHighDemand;
  final Brightness brightness;

  const AppColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textHint,
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.accent,
    required this.accentWarm,
    required this.error,
    required this.success,
    required this.warning,
    required this.divider,
    required this.cardBorder,
    required this.selectedChipBg,
    required this.unselectedChipBg,
    required this.navBar,
    required this.bottomBarBg,
    required this.inputFill,
    required this.shadow,
    required this.overlay,
    required this.ratingStarColor,
    required this.badgeAvailable,
    required this.badgeHighDemand,
    required this.brightness,
  });

  // ─── Dark Theme ─── Neutral charcoal backgrounds, vibrant green accent sparingly
  static const dark = AppColors(
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    surfaceVariant: Color(0xFF2A2A2A),
    textPrimary: Color(0xFFF5F5F5),
    textSecondary: Color(0xFF9E9E9E),
    textHint: Color(0xFF757575),
    primary: Color(0xFF4CAF50),          // Material Green 500
    primaryDark: Color(0xFF388E3C),      // Material Green 700
    primaryLight: Color(0xFF81C784),     // Material Green 300
    accent: Color(0xFF00BCD4),           // Cyan for secondary actions
    accentWarm: Color(0xFFFF7043),       // Deep Orange for badges
    error: Color(0xFFEF5350),
    success: Color(0xFF66BB6A),
    warning: Color(0xFFFFA726),
    divider: Color(0xFF2E2E2E),
    cardBorder: Color(0xFF333333),
    selectedChipBg: Color(0x264CAF50),
    unselectedChipBg: Color(0xFF1E1E1E),
    navBar: Color(0xFF1A1A1A),
    bottomBarBg: Color(0xFF1A1A1A),
    inputFill: Color(0xFF252525),
    shadow: Color(0x40000000),
    overlay: Color(0x80000000),
    ratingStarColor: Color(0xFFFFB300),
    badgeAvailable: Color(0xFF43A047),
    badgeHighDemand: Color(0xFFE65100),
    brightness: Brightness.dark,
  );

  // ─── Light Theme ─── Clean whites, soft grays, deeper green accent
  static const light = AppColors(
    background: Color(0xFFF7F8FA),
    surface: Color(0xFFFFFFFF),
    surfaceVariant: Color(0xFFF0F1F3),
    textPrimary: Color(0xFF1B1B1F),
    textSecondary: Color(0xFF5F6368),
    textHint: Color(0xFF9AA0A6),
    primary: Color(0xFF2E7D32),          // Material Green 800
    primaryDark: Color(0xFF1B5E20),      // Material Green 900
    primaryLight: Color(0xFFA5D6A7),     // Material Green 200
    accent: Color(0xFF0097A7),           // Cyan 700 for secondary
    accentWarm: Color(0xFFE64A19),       // Deep Orange 700
    error: Color(0xFFD32F2F),
    success: Color(0xFF388E3C),
    warning: Color(0xFFEF6C00),
    divider: Color(0xFFE0E0E0),
    cardBorder: Color(0xFFE8E8E8),
    selectedChipBg: Color(0x1A2E7D32),
    unselectedChipBg: Color(0xFFFFFFFF),
    navBar: Color(0xFFFFFFFF),
    bottomBarBg: Color(0xFFFFFFFF),
    inputFill: Color(0xFFF0F1F3),
    shadow: Color(0x1A000000),
    overlay: Color(0x4D000000),
    ratingStarColor: Color(0xFFF9A825),
    badgeAvailable: Color(0xFF2E7D32),
    badgeHighDemand: Color(0xFFD84315),
    brightness: Brightness.light,
  );

  /// Convenience accessor: `AppColors.of(context)`
  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>() ?? dark;
  }

  bool get isDark => brightness == Brightness.dark;

  @override
  AppColors copyWith({
    Color? background, Color? surface, Color? surfaceVariant,
    Color? textPrimary, Color? textSecondary, Color? textHint,
    Color? primary, Color? primaryDark, Color? primaryLight,
    Color? accent, Color? accentWarm, Color? error, Color? success, Color? warning,
    Color? divider, Color? cardBorder,
    Color? selectedChipBg, Color? unselectedChipBg,
    Color? navBar, Color? bottomBarBg, Color? inputFill,
    Color? shadow, Color? overlay,
    Color? ratingStarColor, Color? badgeAvailable, Color? badgeHighDemand,
    Brightness? brightness,
  }) {
    return AppColors(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      primary: primary ?? this.primary,
      primaryDark: primaryDark ?? this.primaryDark,
      primaryLight: primaryLight ?? this.primaryLight,
      accent: accent ?? this.accent,
      accentWarm: accentWarm ?? this.accentWarm,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      divider: divider ?? this.divider,
      cardBorder: cardBorder ?? this.cardBorder,
      selectedChipBg: selectedChipBg ?? this.selectedChipBg,
      unselectedChipBg: unselectedChipBg ?? this.unselectedChipBg,
      navBar: navBar ?? this.navBar,
      bottomBarBg: bottomBarBg ?? this.bottomBarBg,
      inputFill: inputFill ?? this.inputFill,
      shadow: shadow ?? this.shadow,
      overlay: overlay ?? this.overlay,
      ratingStarColor: ratingStarColor ?? this.ratingStarColor,
      badgeAvailable: badgeAvailable ?? this.badgeAvailable,
      badgeHighDemand: badgeHighDemand ?? this.badgeHighDemand,
      brightness: brightness ?? this.brightness,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryDark: Color.lerp(primaryDark, other.primaryDark, t)!,
      primaryLight: Color.lerp(primaryLight, other.primaryLight, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentWarm: Color.lerp(accentWarm, other.accentWarm, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      selectedChipBg: Color.lerp(selectedChipBg, other.selectedChipBg, t)!,
      unselectedChipBg: Color.lerp(unselectedChipBg, other.unselectedChipBg, t)!,
      navBar: Color.lerp(navBar, other.navBar, t)!,
      bottomBarBg: Color.lerp(bottomBarBg, other.bottomBarBg, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      ratingStarColor: Color.lerp(ratingStarColor, other.ratingStarColor, t)!,
      badgeAvailable: Color.lerp(badgeAvailable, other.badgeAvailable, t)!,
      badgeHighDemand: Color.lerp(badgeHighDemand, other.badgeHighDemand, t)!,
      brightness: t < 0.5 ? brightness : other.brightness,
    );
  }
}
