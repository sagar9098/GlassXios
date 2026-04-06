import 'package:flutter/material.dart';
import '../config/glassx_config.dart';
import '../core/glassx_provider.dart';
import 'glassx_blur.dart';

/// Displays a glass-styled modal bottom sheet.
///
/// Call [GlassXBottomSheet.show] as a drop-in replacement for
/// [showModalBottomSheet]. The sheet surface uses [GlassXBlur] to produce
/// a frosted background.
///
/// Example:
/// ```dart
/// GlassXBottomSheet.show(
///   context: context,
///   builder: (ctx) => Column(
///     mainAxisSize: MainAxisSize.min,
///     children: [
///       ListTile(title: Text('Option A')),
///       ListTile(title: Text('Option B')),
///     ],
///   ),
/// );
/// ```
class GlassXBottomSheet extends StatelessWidget {
  /// The child content of the bottom sheet.
  final Widget child;

  /// Override blur strength. Inherits from config if null.
  final double? blur;

  /// Override fill opacity.
  final double? opacity;

  /// Override corner radius for the top corners.
  final double? borderRadius;

  /// Override tint color.
  final Color? tintColor;

  /// Padding applied inside the sheet surface.
  final EdgeInsetsGeometry padding;

  const GlassXBottomSheet({
    super.key,
    required this.child,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.tintColor,
    this.padding = const EdgeInsets.fromLTRB(16, 8, 16, 32),
  });

  /// Shows a glass modal bottom sheet.
  ///
  /// Parameters mirror [showModalBottomSheet] with the addition of optional
  /// glass config overrides.
  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    double? blur,
    double? opacity,
    double? borderRadius,
    Color? tintColor,
    EdgeInsetsGeometry padding = const EdgeInsets.fromLTRB(16, 8, 16, 32),
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = false,
  }) {
    final config = GlassXProvider.maybeOf(context) ?? const GlassXConfig();
    final radius = borderRadius ?? config.borderRadius;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(radius),
        ),
      ),
      builder: (ctx) => GlassXBottomSheet(
        blur: blur,
        opacity: opacity,
        borderRadius: radius,
        tintColor: tintColor,
        padding: padding,
        child: builder(ctx),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inherited = GlassXProvider.maybeOf(context) ?? const GlassXConfig();
    final radius = borderRadius ?? inherited.borderRadius;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      child: GlassXBlur(
        blur: blur,
        opacity: opacity,
        tintColor: tintColor,
        borderRadius: 0,
        borderWidth: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: inherited.borderColor.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 8),
            Padding(padding: padding, child: child),
          ],
        ),
      ),
    );
  }
}
