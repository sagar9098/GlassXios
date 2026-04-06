/// Defines the rendering performance target for the GlassXios blur system.
///
/// Each mode adjusts blur quality, GPU cost, and animation fidelity.
/// Select based on your target device capabilities.
enum GlassXPerformance {
  /// Reduces blur samples and disables vibrancy for maximum efficiency.
  /// Best for older devices, complex list views, or debug builds.
  low,

  /// Balanced quality and performance. Suitable for the majority of devices.
  /// This is the default mode.
  balanced,

  /// Maximum blur fidelity. Enables vibrancy on iOS and smooth
  /// animated transitions. Recommended for flagship devices only.
  high,
}

/// Extension helpers on [GlassXPerformance].
extension GlassXPerformanceX on GlassXPerformance {
  /// Returns the sigma (standard deviation) for the Gaussian blur kernel.
  double get blurSigma => switch (this) {
        GlassXPerformance.low => 6.0,
        GlassXPerformance.balanced => 15.0,
        GlassXPerformance.high => 25.0,
      };

  /// Returns the tile size used for Android RenderEffect (lower = better quality).
  int get androidTileSize => switch (this) {
        GlassXPerformance.low => 4,
        GlassXPerformance.balanced => 2,
        GlassXPerformance.high => 1,
      };

  /// Whether smooth animated transitions are enabled for this mode.
  bool get animationsEnabled => this != GlassXPerformance.low;

  /// Human-readable label.
  String get label => switch (this) {
        GlassXPerformance.low => 'Low',
        GlassXPerformance.balanced => 'Balanced',
        GlassXPerformance.high => 'High',
      };
}
