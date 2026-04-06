import 'package:flutter/material.dart';
import '../config/glassx_config.dart';

/// Provides GlassX-aware [ThemeData] helpers so that glass widgets
/// automatically adapt to the app's light / dark theme.
class GlassXTheme {
  GlassXTheme._();

  // ── Tint colours for each brightness level ──────────────────────────────

  /// Returns an appropriate glass tint colour based on [brightness].
  static Color tintForBrightness(
    Brightness brightness, {
    double opacity = 0.15,
  }) {
    return brightness == Brightness.dark
        ? Color.fromRGBO(255, 255, 255, opacity)
        : Color.fromRGBO(255, 255, 255, opacity + 0.05);
  }

  /// Returns an appropriate glass border colour based on [brightness].
  static Color borderForBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? const Color(0x33FFFFFF)
        : const Color(0x4DFFFFFF);
  }

  // ── Config derivation ───────────────────────────────────────────────────

  /// Derives a [GlassXConfig] from the provided [ThemeData], preserving all
  /// other fields from [base].
  static GlassXConfig fromTheme(ThemeData theme, {GlassXConfig? base}) {
    final cfg = base ?? const GlassXConfig();
    final brightness = theme.brightness;
    return cfg.copyWith(
      tintColor: tintForBrightness(brightness, opacity: cfg.opacity),
      borderColor: borderForBrightness(brightness),
    );
  }

  // ── Standard glass decoration ───────────────────────────────────────────

  /// Creates a [BoxDecoration] representing the glass surface using [config].
  static BoxDecoration glassDecoration(GlassXConfig config) {
    return BoxDecoration(
      color: config.tintColor,
      borderRadius: BorderRadius.circular(config.borderRadius),
      border: Border.all(
        color: config.borderColor,
        width: config.borderWidth,
      ),
    );
  }

  /// Creates a [BoxDecoration] for an elevated glass card (includes shadow).
  static BoxDecoration cardDecoration(GlassXConfig config) {
    return BoxDecoration(
      color: config.tintColor,
      borderRadius: BorderRadius.circular(config.borderRadius),
      border: Border.all(
        color: config.borderColor,
        width: config.borderWidth,
      ),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 24,
          spreadRadius: -4,
          offset: Offset(0, 8),
        ),
      ],
    );
  }
}
