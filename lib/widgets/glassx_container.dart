import 'package:flutter/material.dart';
import '../core/glassx_provider.dart';
import 'glassx_blur.dart';

/// A glass-surfaced container that blurs its background content.
///
/// [GlassXContainer] is the primary building block for glass UI layouts.
/// It is equivalent to a regular [Container] with a [BackdropFilter] /
/// native blur applied, plus a semi-transparent frosted-glass decoration.
///
/// Config is inherited from the nearest [GlassXProvider] and can be
/// overridden per-instance.
///
/// Example:
/// ```dart
/// GlassXContainer(
///   blur: 20,
///   padding: EdgeInsets.all(16),
///   child: Text('Glass content'),
/// )
/// ```
class GlassXContainer extends StatelessWidget {
  /// Override blur strength (0–40). Inherits from config if null.
  final double? blur;

  /// Override fill opacity (0.0–1.0). Inherits from config if null.
  final double? opacity;

  /// Override corner radius. Inherits from config if null.
  final double? borderRadius;

  /// Override tint color.
  final Color? tintColor;

  /// Override border color.
  final Color? borderColor;

  /// Override border width.
  final double? borderWidth;

  /// The child widget to display inside this container.
  final Widget? child;

  /// Container width.
  final double? width;

  /// Container height.
  final double? height;

  /// Padding applied inside the glass surface.
  final EdgeInsetsGeometry padding;

  /// Margin applied outside the glass surface.
  final EdgeInsetsGeometry? margin;

  /// Alignment of [child] within the container.
  final AlignmentGeometry alignment;

  const GlassXContainer({
    super.key,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.tintColor,
    this.borderColor,
    this.borderWidth,
    this.child,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = GlassXBlur(
      blur: blur,
      opacity: opacity,
      borderRadius: borderRadius,
      tintColor: tintColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      width: width,
      height: height,
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (margin != null) {
      result = Padding(padding: margin!, child: result);
    }

    return result;
  }
}
