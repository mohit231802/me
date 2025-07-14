import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the music streaming application.
/// Implements Contemporary Spatial Minimalism with Adaptive Audio Spectrum colors.
class AppTheme {
  AppTheme._();

  // Adaptive Audio Spectrum Color Palette
  static const Color primaryGreen =
      Color(0xFF1DB954); // Spotify-inspired green for play states
  static const Color deepCharcoal =
      Color(0xFF191414); // Deep charcoal for backgrounds
  static const Color warmOrange =
      Color(0xFFFF6B35); // Warm orange for notifications
  static const Color trueDarkSurface =
      Color(0xFF121212); // True dark surface for OLED
  static const Color pureBlack =
      Color(0xFF000000); // Pure black for immersive modes
  static const Color textPrimary = Color(0xFFFFFFFF); // High contrast white
  static const Color textSecondary =
      Color(0xFFB3B3B3); // Muted gray for metadata
  static const Color errorRed = Color(0xFFE22134); // Clear red for errors
  static const Color successGreen =
      Color(0xFF1ED760); // Bright green for success
  static const Color neutralGray =
      Color(0xFF535353); // Mid-tone gray for inactive states

  // Additional semantic colors
  static const Color cardLight = Color(0xFFF8F8F8);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF2D2D2D);

  // Shadow colors for subtle elevation
  static const Color shadowLight = Color(0x0A000000); // 2-4dp shadows
  static const Color shadowDark = Color(0x1A000000);

  // Divider colors - minimal usage
  static const Color dividerLight = Color(0x1A000000);
  static const Color dividerDark = Color(0x1AFFFFFF);

  /// Light theme - optimized for mobile readability
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryGreen,
          onPrimary: textPrimary,
          primaryContainer: primaryGreen.withValues(alpha: 0.1),
          onPrimaryContainer: deepCharcoal,
          secondary: warmOrange,
          onSecondary: textPrimary,
          secondaryContainer: warmOrange.withValues(alpha: 0.1),
          onSecondaryContainer: deepCharcoal,
          tertiary: successGreen,
          onTertiary: deepCharcoal,
          tertiaryContainer: successGreen.withValues(alpha: 0.1),
          onTertiaryContainer: deepCharcoal,
          error: errorRed,
          onError: textPrimary,
          surface: cardLight,
          onSurface: deepCharcoal,
          onSurfaceVariant: neutralGray,
          outline: dividerLight,
          outlineVariant: dividerLight.withValues(alpha: 0.5),
          shadow: shadowLight,
          scrim: shadowLight,
          inverseSurface: trueDarkSurface,
          onInverseSurface: textPrimary,
          inversePrimary: primaryGreen),
      scaffoldBackgroundColor: textPrimary,
      cardColor: cardLight,
      dividerColor: dividerLight,

      // AppBar theme for clean navigation
      appBarTheme: AppBarTheme(
          backgroundColor: textPrimary,
          foregroundColor: deepCharcoal,
          elevation: 0,
          scrolledUnderElevation: 2,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.w600, color: deepCharcoal)),

      // Card theme with subtle elevation
      cardTheme: CardTheme(
          color: cardLight,
          elevation: 2.0,
          shadowColor: shadowLight,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation for music controls
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: cardLight,
          selectedItemColor: primaryGreen,
          unselectedItemColor: neutralGray,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Floating action button for primary playback actions
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryGreen,
          foregroundColor: textPrimary,
          elevation: 4,
          focusElevation: 6,
          hoverElevation: 6,
          highlightElevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes optimized for thumb accessibility
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: textPrimary,
              backgroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w600))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: primaryGreen, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),

      // Typography using Inter for excellent mobile readability
      textTheme: _buildTextTheme(isLight: true),

      // Input decoration for search and forms
      inputDecorationTheme: InputDecorationTheme(
          fillColor: cardLight,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: primaryGreen, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorRed, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorRed, width: 2)),
          labelStyle: GoogleFonts.inter(color: neutralGray, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: neutralGray, fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: neutralGray,
          suffixIconColor: neutralGray),

      // Switch theme for settings
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryGreen;
        }
        return neutralGray;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryGreen.withValues(alpha: 0.3);
        }
        return neutralGray.withValues(alpha: 0.3);
      })),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryGreen;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(textPrimary),
          side: BorderSide(color: neutralGray, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),

      // Radio theme
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryGreen;
        }
        return neutralGray;
      })),

      // Progress indicator for loading states
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryGreen, linearTrackColor: neutralGray.withValues(alpha: 0.3), circularTrackColor: neutralGray.withValues(alpha: 0.3)),

      // Slider theme for audio controls
      sliderTheme: SliderThemeData(activeTrackColor: primaryGreen, thumbColor: primaryGreen, overlayColor: primaryGreen.withValues(alpha: 0.2), inactiveTrackColor: neutralGray.withValues(alpha: 0.3), trackHeight: 4, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8), overlayShape: const RoundSliderOverlayShape(overlayRadius: 16)),

      // Tab bar theme
      tabBarTheme: TabBarTheme(labelColor: primaryGreen, unselectedLabelColor: neutralGray, indicatorColor: primaryGreen, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400)),

      // Tooltip theme
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: deepCharcoal.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: textPrimary, fontSize: 14, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // Snackbar theme for notifications
      snackBarTheme: SnackBarThemeData(backgroundColor: deepCharcoal, contentTextStyle: GoogleFonts.inter(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w400), actionTextColor: primaryGreen, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))), dialogTheme: DialogThemeData(backgroundColor: dialogLight));

  /// Dark theme - optimized for OLED displays and battery conservation
  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: primaryGreen,
          onPrimary: pureBlack,
          primaryContainer: primaryGreen.withValues(alpha: 0.2),
          onPrimaryContainer: textPrimary,
          secondary: warmOrange,
          onSecondary: pureBlack,
          secondaryContainer: warmOrange.withValues(alpha: 0.2),
          onSecondaryContainer: textPrimary,
          tertiary: successGreen,
          onTertiary: pureBlack,
          tertiaryContainer: successGreen.withValues(alpha: 0.2),
          onTertiaryContainer: textPrimary,
          error: errorRed,
          onError: textPrimary,
          surface: trueDarkSurface,
          onSurface: textPrimary,
          onSurfaceVariant: textSecondary,
          outline: dividerDark,
          outlineVariant: dividerDark.withValues(alpha: 0.5),
          shadow: shadowDark,
          scrim: shadowDark,
          inverseSurface: cardLight,
          onInverseSurface: deepCharcoal,
          inversePrimary: primaryGreen),
      scaffoldBackgroundColor: pureBlack,
      cardColor: cardDark,
      dividerColor: dividerDark,

      // AppBar theme for immersive experience
      appBarTheme: AppBarTheme(
          backgroundColor: pureBlack,
          foregroundColor: textPrimary,
          elevation: 0,
          scrolledUnderElevation: 2,
          titleTextStyle: GoogleFonts.inter(
              fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary)),

      // Card theme with subtle elevation
      cardTheme: CardTheme(
          color: cardDark,
          elevation: 2.0,
          shadowColor: shadowDark,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),

      // Bottom navigation for music controls
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: trueDarkSurface,
          selectedItemColor: primaryGreen,
          unselectedItemColor: textSecondary,
          elevation: 8,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400)),

      // Floating action button for primary playback actions
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryGreen,
          foregroundColor: pureBlack,
          elevation: 4,
          focusElevation: 6,
          hoverElevation: 6,
          highlightElevation: 8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0))),

      // Button themes optimized for thumb accessibility
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              foregroundColor: pureBlack,
              backgroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w600))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              foregroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: BorderSide(color: primaryGreen, width: 1.5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              foregroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              textStyle: GoogleFonts.inter(
                  fontSize: 16, fontWeight: FontWeight.w500))),

      // Typography using Inter for excellent mobile readability
      textTheme: _buildTextTheme(isLight: false),

      // Input decoration for search and forms
      inputDecorationTheme: InputDecorationTheme(
          fillColor: trueDarkSurface,
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: primaryGreen, width: 2)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorRed, width: 1)),
          focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: errorRed, width: 2)),
          labelStyle: GoogleFonts.inter(color: textSecondary, fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle: GoogleFonts.inter(color: textSecondary, fontSize: 16, fontWeight: FontWeight.w400),
          prefixIconColor: textSecondary,
          suffixIconColor: textSecondary),

      // Switch theme for settings
      switchTheme: SwitchThemeData(thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryGreen;
        }
        return neutralGray;
      }), trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryGreen.withValues(alpha: 0.3);
        }
        return neutralGray.withValues(alpha: 0.3);
      })),

      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryGreen;
            }
            return Colors.transparent;
          }),
          checkColor: WidgetStateProperty.all(pureBlack),
          side: BorderSide(color: textSecondary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),

      // Radio theme
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryGreen;
        }
        return textSecondary;
      })),

      // Progress indicator for loading states
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primaryGreen, linearTrackColor: neutralGray.withValues(alpha: 0.3), circularTrackColor: neutralGray.withValues(alpha: 0.3)),

      // Slider theme for audio controls
      sliderTheme: SliderThemeData(activeTrackColor: primaryGreen, thumbColor: primaryGreen, overlayColor: primaryGreen.withValues(alpha: 0.2), inactiveTrackColor: neutralGray.withValues(alpha: 0.3), trackHeight: 4, thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8), overlayShape: const RoundSliderOverlayShape(overlayRadius: 16)),

      // Tab bar theme
      tabBarTheme: TabBarTheme(labelColor: primaryGreen, unselectedLabelColor: textSecondary, indicatorColor: primaryGreen, indicatorSize: TabBarIndicatorSize.label, labelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600), unselectedLabelStyle: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400)),

      // Tooltip theme
      tooltipTheme: TooltipThemeData(decoration: BoxDecoration(color: textPrimary.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(8)), textStyle: GoogleFonts.inter(color: pureBlack, fontSize: 14, fontWeight: FontWeight.w400), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),

      // Snackbar theme for notifications
      snackBarTheme: SnackBarThemeData(backgroundColor: trueDarkSurface, contentTextStyle: GoogleFonts.inter(color: textPrimary, fontSize: 16, fontWeight: FontWeight.w400), actionTextColor: primaryGreen, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))), dialogTheme: DialogThemeData(backgroundColor: dialogDark));

  /// Helper method to build text theme using Inter font family
  /// Optimized for mobile readability with strong character recognition
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight ? deepCharcoal : textPrimary;
    final Color textMediumEmphasis = isLight ? neutralGray : textSecondary;
    final Color textDisabled = isLight
        ? neutralGray.withValues(alpha: 0.6)
        : textSecondary.withValues(alpha: 0.6);

    return TextTheme(
        // Display styles for large headings
        displayLarge: GoogleFonts.inter(
            fontSize: 57,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: -0.25),
        displayMedium: GoogleFonts.inter(
            fontSize: 45, fontWeight: FontWeight.w400, color: textHighEmphasis),
        displaySmall: GoogleFonts.inter(
            fontSize: 36, fontWeight: FontWeight.w400, color: textHighEmphasis),

        // Headline styles for artist names and playlist titles
        headlineLarge: GoogleFonts.inter(
            fontSize: 32, fontWeight: FontWeight.w600, color: textHighEmphasis),
        headlineMedium: GoogleFonts.inter(
            fontSize: 28, fontWeight: FontWeight.w600, color: textHighEmphasis),
        headlineSmall: GoogleFonts.inter(
            fontSize: 24, fontWeight: FontWeight.w600, color: textHighEmphasis),

        // Title styles for section headers
        titleLarge: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0),
        titleMedium: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.15),
        titleSmall: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.1),

        // Body styles for lyrics and descriptions
        bodyLarge: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: 0.5),
        bodyMedium: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: textHighEmphasis,
            letterSpacing: 0.25),
        bodySmall: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: textMediumEmphasis,
            letterSpacing: 0.4),

        // Label styles for buttons and metadata
        labelLarge: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: textHighEmphasis,
            letterSpacing: 0.1),
        labelMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textMediumEmphasis,
            letterSpacing: 0.5),
        labelSmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: textDisabled,
            letterSpacing: 0.5));
  }
}
