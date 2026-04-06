import 'package:flutter/material.dart';
import '../config/glassx_config.dart';
import '../core/glassx_provider.dart';

/// The root application widget for GlassXios-powered apps.
///
/// [GlassXMaterialApp] wraps Flutter's [MaterialApp] and injects a
/// [GlassXProvider] into the widget tree, making the [GlassXConfig]
/// globally accessible to all descendant glass widgets.
///
/// It is a direct drop-in replacement for [MaterialApp] — all standard
/// [MaterialApp] parameters are fully supported.
///
/// Example:
/// ```dart
/// void main() => runApp(
///   GlassXMaterialApp(
///     config: GlassXConfig.high(),
///     title: 'My App',
///     theme: ThemeData.dark(),
///     home: HomeScreen(),
///   ),
/// );
/// ```
class GlassXMaterialApp extends StatelessWidget {
  // ── GlassX-specific ──────────────────────────────────────────────────────

  /// The global glass rendering configuration.
  ///
  /// Defaults to [GlassXConfig.balanced()] if not provided.
  final GlassXConfig config;

  // ── Standard MaterialApp parameters ─────────────────────────────────────

  /// {@macro flutter.widgets.widgetsApp.title}
  final String title;

  /// {@macro flutter.material.materialApp.theme}
  final ThemeData? theme;

  /// {@macro flutter.material.materialApp.darkTheme}
  final ThemeData? darkTheme;

  /// {@macro flutter.material.materialApp.themeMode}
  final ThemeMode? themeMode;

  /// {@macro flutter.widgets.widgetsApp.home}
  final Widget? home;

  /// {@macro flutter.widgets.widgetsApp.routes}
  final Map<String, WidgetBuilder>? routes;

  /// {@macro flutter.widgets.widgetsApp.initialRoute}
  final String? initialRoute;

  /// {@macro flutter.widgets.widgetsApp.onGenerateRoute}
  final RouteFactory? onGenerateRoute;

  /// {@macro flutter.widgets.widgetsApp.onUnknownRoute}
  final RouteFactory? onUnknownRoute;

  /// {@macro flutter.widgets.widgetsApp.navigatorObservers}
  final List<NavigatorObserver>? navigatorObservers;

  /// {@macro flutter.widgets.widgetsApp.debugShowCheckedModeBanner}
  final bool debugShowCheckedModeBanner;

  /// {@macro flutter.widgets.widgetsApp.localizationsDelegates}
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// Supported locales for the app.
  final Iterable<Locale>? supportedLocales;

  /// Custom scroll behaviour.
  final ScrollBehavior? scrollBehavior;

  /// Whether to show the Material performance overlay.
  final bool showPerformanceOverlay;

  const GlassXMaterialApp({
    super.key,
    this.config = const GlassXConfig(),
    this.title = '',
    this.theme,
    this.darkTheme,
    this.themeMode,
    this.home,
    this.routes,
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers,
    this.debugShowCheckedModeBanner = true,
    this.localizationsDelegates,
    this.supportedLocales,
    this.scrollBehavior,
    this.showPerformanceOverlay = false,
  });

  @override
  Widget build(BuildContext context) {
    return GlassXProvider(
      config: config,
      child: MaterialApp(
        title: title,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: themeMode,
        home: home,
        routes: routes ?? const {},
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
        onUnknownRoute: onUnknownRoute,
        navigatorObservers: navigatorObservers ?? const [],
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales ?? const [Locale('en', 'US')],
        scrollBehavior: scrollBehavior,
        showPerformanceOverlay: showPerformanceOverlay,
      ),
    );
  }
}
