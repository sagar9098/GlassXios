import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../../config/glassx_config.dart';

/// The platform-view type identifier registered in the Swift plugin.
const String _kGlassXViewType = 'io.glassx/blur_view';

/// Renders a native iOS `UIVisualEffectView` via a [UiKitView] platform view.
///
/// This widget is **only** instantiated on iOS. Use [GlassXBlur] which
/// automatically selects the correct implementation.
///
/// Parameters passed to the native view:
/// - `blurStrength` — Gaussian sigma for `UIBlurEffect`
/// - `cornerRadius` — Corner radius in points
/// - `tintColor` — ARGB integer of the tint overlay
/// - `enableVibrancy` — Whether to wrap content in `UIVibrancyEffect`
class GlassXIosBlur extends StatelessWidget {
  /// The glass configuration to apply.
  final GlassXConfig config;

  /// Widget to render on top of the native blur layer.
  final Widget? child;

  const GlassXIosBlur({
    super.key,
    required this.config,
    this.child,
  });

  Map<String, dynamic> _creationParams() => {
        'blurStrength': config.blurStrength,
        'cornerRadius': config.borderRadius,
        'tintColor': config.tintColor.toARGB32(),
        'enableVibrancy': config.enableVibrancy,
      };

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        UiKitView(
          viewType: _kGlassXViewType,
          layoutDirection: Directionality.of(context),
          creationParams: _creationParams(),
          creationParamsCodec: const StandardMessageCodec(),
          // Gesture recogniser factory – pass all gestures through to Flutter
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          onPlatformViewCreated: _onViewCreated,
        ),
        if (child != null) child!,
      ],
    );
  }

  void _onViewCreated(int id) {
    // Reserved for future method-channel based parameter updates.
    if (kDebugMode) {
      debugPrint('[GlassXios] iOS native blur view created (id=$id)');
    }
  }
}
