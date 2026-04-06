import 'package:flutter/material.dart';
import '../config/glassx_config.dart';
import '../core/glassx_provider.dart';
import 'glass_x_blur.dart';

/// A glass-styled card with elevated shadow and a frosted blur surface.
///
/// Use [GlassXCard] as you would a Material [Card], but with automatic
/// glass rendering on all platforms.
///
/// Example:
/// ```dart
/// GlassXCard(
///   child: ListTile(
///     title: Text('Glass Card'),
///     subtitle: Text('Native blur on iOS'),
///   ),
/// )
/// ```
class GlassXCard extends StatelessWidget {
  /// The widget shown inside the glass card.
  final Widget child;

  /// Override blur strength. Inherits from config if null.
  final double? blur;

  /// Override fill opacity (0.0–1.0). Inherits from config if null.
  final double? opacity;

  /// Override corner radius. Inherits from config if null.
  final double? borderRadius;

  /// Override tint color.
  final Color? tintColor;

  /// Override border color.
  final Color? borderColor;

  /// Padding applied inside the card.
  final EdgeInsetsGeometry padding;

  /// Margin applied outside the card.
  final EdgeInsetsGeometry? margin;

  const GlassXCard({
    super.key,
    required this.child,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.tintColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = GlassXProvider.maybeOf(context) ?? const GlassXConfig();
    final radius = borderRadius ?? inherited.borderRadius;

    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: GlassXBlur(
        blur: blur,
        opacity: opacity,
        borderRadius: radius,
        tintColor: tintColor,
        borderColor: borderColor,
        child: Padding(padding: padding, child: child),
      ),
    );

    // Wrap with outer shadow container
    card = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 24,
            spreadRadius: -4,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: card,
    );

    return card;
  }
}
