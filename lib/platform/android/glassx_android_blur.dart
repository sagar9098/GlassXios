import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../config/glassx_config.dart';
import '../../config/glassx_performance.dart';
import '../../core/glassx_theme.dart';

/// Android implementation of the GlassXios blur surface.
///
/// Uses Flutter's [BackdropFilter] with [ImageFilter.blur] as the primary
/// strategy. On Android 12+ (API 31+), [RenderEffect] could be used via
/// platform channels, but [BackdropFilter] provides excellent results
/// without native bindings and is used here for full compatibility.
///
/// Performance notes:
/// - [BackdropFilter] forces its subtree into a separate compositing layer.
/// - Keep the number of simultaneous [BackdropFilter] widgets low.
/// - Use [GlassXPerformance.low] in list items or complex layouts.
class GlassXAndroidBlur extends StatelessWidget {
  /// The glass configuration to apply.
  final GlassXConfig config;

  /// Optional child widget rendered above the blur layer.
  final Widget? child;

  const GlassXAndroidBlur({
    super.key,
    required this.config,
    this.child,
  });

  /// Returns the blur sigma clamped to the performance mode's maximum.
  double get _effectiveSigma {
    final maxSigma = config.performanceMode.blurSigma;
    return config.blurStrength.clamp(0.0, maxSigma);
  }

  @override
  Widget build(BuildContext context) {
    final decoration = GlassXTheme.glassDecoration(config);

    return ClipRRect(
      borderRadius: BorderRadius.circular(config.borderRadius),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: _effectiveSigma,
          sigmaY: _effectiveSigma,
          tileMode: TileMode.clamp,
        ),
        child: DecoratedBox(
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }
}
