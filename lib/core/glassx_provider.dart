import 'package:flutter/widgets.dart';
import '../config/glassx_config.dart';

/// An [InheritedWidget] that propagates [GlassXConfig] down the widget tree.
///
/// Wrap your app (or any subtree) with [GlassXProvider] to give all
/// descendant glass widgets access to a shared configuration.
///
/// ```dart
/// GlassXProvider(
///   config: GlassXConfig.high(),
///   child: MyApp(),
/// )
/// ```
///
/// Widgets can read the nearest config via [GlassXProvider.of(context)].
class GlassXProvider extends InheritedWidget {
  /// The active glass configuration for this subtree.
  final GlassXConfig config;

  const GlassXProvider({
    super.key,
    required this.config,
    required super.child,
  });

  // ── Static accessors ────────────────────────────────────────────────────

  /// Returns the [GlassXConfig] from the nearest [GlassXProvider] ancestor.
  ///
  /// Throws a [FlutterError] if no [GlassXProvider] is found in the tree.
  /// Use [maybeOf] for a nullable, non-throwing variant.
  static GlassXConfig of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<GlassXProvider>();
    assert(
      provider != null,
      'No GlassXProvider found in the widget tree.\n'
      'Ensure you have wrapped your app with GlassXMaterialApp or '
      'GlassXProvider.',
    );
    return provider!.config;
  }

  /// Returns the [GlassXConfig] from the nearest [GlassXProvider] ancestor,
  /// or `null` if none is present.
  static GlassXConfig? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlassXProvider>()?.config;
  }

  /// Returns the [GlassXConfig] from the nearest ancestor without registering
  /// the context for rebuild (use when you only need a one-time read).
  static GlassXConfig? readOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<GlassXProvider>()?.config;
  }

  @override
  bool updateShouldNotify(GlassXProvider oldWidget) =>
      config != oldWidget.config;
}
