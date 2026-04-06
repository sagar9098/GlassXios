import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Utility class for safe platform detection within GlassXios.
///
/// Always use [GlassXPlatform] rather than direct dart:io [Platform] calls
/// to avoid runtime errors on Web (where `Platform` is unavailable).
class GlassXPlatform {
  GlassXPlatform._();

  /// `true` when running on the **web** platform.
  static bool get isWeb => kIsWeb;

  /// `true` when running on **iOS** (native, not web).
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// `true` when running on **Android** (native, not web).
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// `true` when running on **macOS** (native, not web).
  static bool get isMacOS => !kIsWeb && Platform.isMacOS;

  /// `true` when running on **Windows**.
  static bool get isWindows => !kIsWeb && Platform.isWindows;

  /// `true` when running on **Linux**.
  static bool get isLinux => !kIsWeb && Platform.isLinux;

  /// Returns `true` if the current platform supports native
  /// Liquid Glass rendering via [UiKitView].
  ///
  /// Currently only iOS is supported.
  static bool get supportsNativeGlass => isIOS;

  /// Returns `true` if the current platform supports
  /// Android 12+ [RenderEffect]-based blur.
  ///
  /// Note: Runtime Android version check is required in addition.
  static bool get supportsRenderEffect => isAndroid;

  /// Returns `true` if [BackdropFilter] is the rendering strategy.
  ///
  /// This is the fallback for Android (all versions), Web, and desktops.
  static bool get usesBackdropFilter => !isIOS;

  /// Returns a human-readable platform label for debug use.
  static String get label {
    if (isWeb) return 'Web';
    if (isIOS) return 'iOS';
    if (isAndroid) return 'Android';
    if (isMacOS) return 'macOS';
    if (isWindows) return 'Windows';
    if (isLinux) return 'Linux';
    return 'Unknown';
  }
}
