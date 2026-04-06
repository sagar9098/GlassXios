import 'package:flutter/material.dart';
import '../config/glassx_config.dart';
import '../core/glassx_provider.dart';
import 'glassx_blur.dart';

/// A glass-styled alert dialog.
///
/// Call [GlassXDialog.show] as a drop-in replacement for [showDialog].
/// The dialog surface uses [GlassXBlur] to produce a frosted background.
///
/// Example:
/// ```dart
/// GlassXDialog.show(
///   context: context,
///   title: Text('Confirm'),
///   content: Text('Are you sure?'),
///   actions: [
///     TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
///     TextButton(onPressed: () => Navigator.pop(context, true), child: Text('OK')),
///   ],
/// );
/// ```
class GlassXDialog extends StatelessWidget {
  /// Optional dialog title widget.
  final Widget? title;

  /// Optional dialog content widget.
  final Widget? content;

  /// Action buttons shown at the bottom of the dialog.
  final List<Widget>? actions;

  /// Override blur strength. Inherits from config if null.
  final double? blur;

  /// Override fill opacity.
  final double? opacity;

  /// Override corner radius.
  final double? borderRadius;

  /// Override tint color.
  final Color? tintColor;

  const GlassXDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.tintColor,
  });

  /// Shows a glass alert dialog.
  ///
  /// [title], [content], and [actions] mirror [AlertDialog] parameters.
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    double? blur,
    double? opacity,
    double? borderRadius,
    Color? tintColor,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: Colors.black38,
      builder: (ctx) => GlassXDialog(
        title: title,
        content: content,
        actions: actions,
        blur: blur,
        opacity: opacity,
        borderRadius: borderRadius,
        tintColor: tintColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final config = GlassXProvider.maybeOf(context) ?? const GlassXConfig();
    final radius = borderRadius ?? config.borderRadius;

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: GlassXBlur(
          blur: blur,
          opacity: opacity,
          tintColor: tintColor,
          borderRadius: radius,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    child: title!,
                  ),
                if (title != null && content != null)
                  const SizedBox(height: 12),
                if (content != null)
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.bodyMedium!,
                    child: content!,
                  ),
                if (actions != null && actions!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions!
                        .map((a) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: a,
                            ))
                        .toList(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
