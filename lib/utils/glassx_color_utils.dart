import 'package:flutter/material.dart';

/// Color utility functions used across the GlassXios widget library.
class GlassXColorUtils {
  GlassXColorUtils._();

  /// Blends [foreground] over [background] at the given [opacity].
  static Color blend(Color background, Color foreground, double opacity) {
    return Color.lerp(background, foreground, opacity.clamp(0.0, 1.0))!;
  }

  /// Returns true if [color] is considered "dark" (luminance < 0.5).
  static bool isDark(Color color) => color.computeLuminance() < 0.5;

  /// Returns a contrasting text color (white or black) for [background].
  static Color contrastingTextColor(Color background) {
    return isDark(background) ? Colors.white : Colors.black;
  }

  /// Creates a radial gradient overlay suitable for a glass surface.
  static RadialGradient glassRadialGradient({
    Color color = Colors.white,
    double opacity = 0.08,
  }) {
    return RadialGradient(
      center: Alignment.topLeft,
      radius: 1.5,
      colors: [
        color.withValues(alpha: opacity),
        color.withValues(alpha: 0.0),
      ],
    );
  }

  /// Creates a linear gradient that mimics specular highlight on glass.
  static LinearGradient specularGradient({
    Color color = Colors.white,
    double startOpacity = 0.25,
    double endOpacity = 0.0,
  }) {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color.withValues(alpha: startOpacity),
        color.withValues(alpha: endOpacity),
      ],
    );
  }

  /// Converts a [Color] to an ARGB hex string (e.g. `#FFAABBCC`).
  static String toHex(Color color) {
    return '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  /// Parses a hex color string with optional leading `#`.
  /// Supports 6-digit (RGB) and 8-digit (ARGB) formats.
  static Color fromHex(String hex) {
    final cleaned = hex.replaceAll('#', '');
    final value = int.parse(
      cleaned.length == 6 ? 'FF$cleaned' : cleaned,
      radix: 16,
    );
    return Color(value);
  }

  /// Returns a darkened version of [color] by [amount] (0.0–1.0).
  static Color darken(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }

  /// Returns a lightened version of [color] by [amount] (0.0–1.0).
  static Color lighten(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0))
        .toColor();
  }
}
