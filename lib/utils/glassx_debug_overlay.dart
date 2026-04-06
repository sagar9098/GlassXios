import 'package:flutter/material.dart';
import 'package:glassx_ios/config/glassx_performance.dart';
import '../config/glassx_config.dart';
import '../platform/glassx_platform.dart';

/// A debug overlay that displays GlassXios diagnostics on top of a widget.
///
/// Only rendered when [GlassXConfig.debugMode] is `true`. Displays:
/// - Current platform
/// - Blur strength in use
/// - Performance mode
/// - Whether native glass is active
///
/// This widget adds zero overhead in release builds because it should only
/// be used when [GlassXConfig.debugMode] is true, which you control.
class GlassXDebugOverlay extends StatelessWidget {
  /// The widget to annotate with debug information.
  final Widget child;

  /// The active config being debugged.
  final GlassXConfig config;

  const GlassXDebugOverlay({
    super.key,
    required this.child,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (!config.debugMode) return child;

    return Stack(
      children: [
        child,
        Positioned(
          top: 4,
          left: 4,
          child: _DebugBadge(config: config),
        ),
      ],
    );
  }
}

class _DebugBadge extends StatelessWidget {
  final GlassXConfig config;

  const _DebugBadge({required this.config});

  @override
  Widget build(BuildContext context) {
    final native =
        GlassXPlatform.supportsNativeGlass ? '✅ Native' : '🔄 Fallback';
    final lines = [
      '🪟 GlassXios Debug',
      'Platform: ${GlassXPlatform.label}',
      'Renderer: $native',
      'Blur: ${config.blurStrength.toStringAsFixed(1)}σ',
      'Mode: ${config.performanceMode.label}',
      'Vibrancy: ${config.enableVibrancy}',
    ];

    return IgnorePointer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: lines
              .map(
                (l) => Text(
                  l,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
