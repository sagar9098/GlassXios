import 'package:flutter/material.dart';
import 'glassx_performance.dart';

/// Defines the global visual configuration for the GlassXios system.
///
/// Pass an instance to [GlassXMaterialApp] via the `config` parameter,
/// or override it locally on any individual glass widget.
///
/// Example:
/// ```dart
/// GlassXMaterialApp(
///   config: GlassXConfig.high(),
///   home: ...,
/// )
/// ```
class GlassXConfig {
  /// The blur radius applied to the glass surface.
  /// Higher values increase the frosted-glass effect.
  /// Range: 0–40. Default: 20.
  final double blurStrength;

  /// Background fill opacity of the glass layer.
  /// 0.0 = fully transparent, 1.0 = fully opaque.
  /// Default: 0.15.
  final double opacity;

  /// Corner radius of the glass surface in logical pixels.
  /// Default: 16.
  final double borderRadius;

  /// Rendering performance target.
  /// See [GlassXPerformance] for available modes.
  final GlassXPerformance performanceMode;

  /// Whether to enable UIVibrancyEffect on iOS.
  /// Vibrancy makes text/icons inside the view adapt to the blurred content.
  /// Has no effect on Android or Web.
  final bool enableVibrancy;

  /// Tint color blended over the glass surface.
  /// Typically a semi-transparent white or system colour.
  /// Default: white at 10% opacity.
  final Color tintColor;

  /// Border color drawn around the glass surface edge.
  /// Default: white at 30% opacity.
  final Color borderColor;

  /// Width of the border stroke in logical pixels.
  /// Default: 1.0.
  final double borderWidth;

  /// Whether to show the debug performance overlay.
  /// Useful during development to monitor GPU/CPU impact.
  final bool debugMode;

  const GlassXConfig({
    this.blurStrength = 20.0,
    this.opacity = 0.15,
    this.borderRadius = 16.0,
    this.performanceMode = GlassXPerformance.balanced,
    this.enableVibrancy = false,
    this.tintColor = const Color(0x1AFFFFFF),
    this.borderColor = const Color(0x4DFFFFFF),
    this.borderWidth = 1.0,
    this.debugMode = false,
  });

  // ── Factory presets ──────────────────────────────────────────────────────

  /// Low-performance preset. Reduces blur quality for older or budget devices.
  /// Blur: 8, opacity: 0.20, no vibrancy.
  factory GlassXConfig.low() => const GlassXConfig(
        blurStrength: 8.0,
        opacity: 0.20,
        borderRadius: 12.0,
        performanceMode: GlassXPerformance.low,
        enableVibrancy: false,
      );

  /// Balanced preset (default). Good visual quality with moderate GPU cost.
  factory GlassXConfig.balanced() => const GlassXConfig(
        blurStrength: 20.0,
        opacity: 0.15,
        borderRadius: 16.0,
        performanceMode: GlassXPerformance.balanced,
        enableVibrancy: false,
      );

  /// High-quality preset. Maximum blur fidelity, vibrancy enabled on iOS.
  /// Suitable for flagship devices.
  factory GlassXConfig.high() => const GlassXConfig(
        blurStrength: 30.0,
        opacity: 0.10,
        borderRadius: 20.0,
        performanceMode: GlassXPerformance.high,
        enableVibrancy: true,
      );

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Returns a copy of this config with the specified fields overridden.
  GlassXConfig copyWith({
    double? blurStrength,
    double? opacity,
    double? borderRadius,
    GlassXPerformance? performanceMode,
    bool? enableVibrancy,
    Color? tintColor,
    Color? borderColor,
    double? borderWidth,
    bool? debugMode,
  }) {
    return GlassXConfig(
      blurStrength: blurStrength ?? this.blurStrength,
      opacity: opacity ?? this.opacity,
      borderRadius: borderRadius ?? this.borderRadius,
      performanceMode: performanceMode ?? this.performanceMode,
      enableVibrancy: enableVibrancy ?? this.enableVibrancy,
      tintColor: tintColor ?? this.tintColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      debugMode: debugMode ?? this.debugMode,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlassXConfig &&
          runtimeType == other.runtimeType &&
          blurStrength == other.blurStrength &&
          opacity == other.opacity &&
          borderRadius == other.borderRadius &&
          performanceMode == other.performanceMode &&
          enableVibrancy == other.enableVibrancy &&
          tintColor == other.tintColor &&
          borderColor == other.borderColor &&
          borderWidth == other.borderWidth &&
          debugMode == other.debugMode;

  @override
  int get hashCode => Object.hash(
        blurStrength,
        opacity,
        borderRadius,
        performanceMode,
        enableVibrancy,
        tintColor,
        borderColor,
        borderWidth,
        debugMode,
      );

  @override
  String toString() => 'GlassXConfig('
      'blur: $blurStrength, '
      'opacity: $opacity, '
      'radius: $borderRadius, '
      'mode: $performanceMode, '
      'vibrancy: $enableVibrancy'
      ')';
}
