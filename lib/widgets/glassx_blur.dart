import 'package:flutter/material.dart';
import '../config/glassx_config.dart';
import '../core/glassx_provider.dart';
import '../platform/glassx_platform.dart';
import '../platform/ios/glassx_ios_blur.dart';
import '../platform/android/glassx_android_blur.dart';
import '../utils/glassx_debug_overlay.dart';

/// The fundamental glass blur primitive in GlassXios.
///
/// [GlassXBlur] renders a surface that blurs the content behind it,
/// adapting automatically to the current platform:
///
/// - **iOS:** Uses a native `UIVisualEffectView` via [UiKitView] for
///   authentic system-quality frosted glass.
/// - **Android / Web / Desktop:** Uses Flutter's [BackdropFilter] with
///   [ImageFilter.blur] for a consistent cross-platform fallback.
///
/// The widget inherits its default settings from the nearest [GlassXProvider]
/// ancestor, which is set up by [GlassXMaterialApp]. Any parameter passed
/// directly to this widget takes precedence over the inherited config.
///
/// Example:
/// ```dart
/// GlassXBlur(
///   blur: 20,
///   borderRadius: 16,
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Hello Glass'),
///   ),
/// )
/// ```
class GlassXBlur extends StatelessWidget {
  /// Override blur strength for this widget only (0–40).
  /// Falls back to [GlassXConfig.blurStrength] if null.
  final double? blur;

  /// Override tint opacity (0.0–1.0) for this widget only.
  /// Falls back to [GlassXConfig.opacity] if null.
  final double? opacity;

  /// Override corner radius for this widget only.
  /// Falls back to [GlassXConfig.borderRadius] if null.
  final double? borderRadius;

  /// Override tint color for this widget only.
  final Color? tintColor;

  /// Override border color for this widget only.
  final Color? borderColor;

  /// Override border width for this widget only.
  final double? borderWidth;

  /// Whether to enable vibrancy on iOS for this widget only.
  final bool? enableVibrancy;

  /// The child widget rendered inside the glass surface.
  final Widget? child;

  /// Explicit width. If null, the widget sizes itself to its child.
  final double? width;

  /// Explicit height. If null, the widget sizes itself to its child.
  final double? height;

  /// Alignment for the [child] within this widget.
  final AlignmentGeometry alignment;

  /// Internal padding applied between the blur surface and [child].
  final EdgeInsetsGeometry? padding;

  const GlassXBlur({
    super.key,
    this.blur,
    this.opacity,
    this.borderRadius,
    this.tintColor,
    this.borderColor,
    this.borderWidth,
    this.enableVibrancy,
    this.child,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.padding,
  });

  GlassXConfig _resolve(GlassXConfig base) {
    return base.copyWith(
      blurStrength: blur ?? base.blurStrength,
      opacity: opacity ?? base.opacity,
      borderRadius: borderRadius ?? base.borderRadius,
      tintColor: tintColor ??
          (opacity != null
              ? Color.fromRGBO(255, 255, 255, opacity!)
              : base.tintColor),
      borderColor: borderColor ?? base.borderColor,
      borderWidth: borderWidth ?? base.borderWidth,
      enableVibrancy: enableVibrancy ?? base.enableVibrancy,
    );
  }

  @override
  Widget build(BuildContext context) {
    final inherited = GlassXProvider.maybeOf(context) ?? const GlassXConfig();
    final config = _resolve(inherited);

    Widget blur = SizedBox(
      width: width,
      height: height,
      child: _buildBlurLayer(config, context),
    );

    if (config.debugMode) {
      blur = GlassXDebugOverlay(config: config, child: blur);
    }

    return blur;
  }

  Widget _buildBlurLayer(GlassXConfig config, BuildContext context) {
    final child = this.child == null
        ? null
        : padding != null
            ? Padding(padding: padding!, child: this.child)
            : this.child;

    if (GlassXPlatform.isIOS) {
      return GlassXIosBlur(config: config, child: child);
    }

    // Android, Web, Desktop — BackdropFilter fallback
    return GlassXAndroidBlur(config: config, child: child);
  }
}
