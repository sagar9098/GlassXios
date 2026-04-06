import 'package:flutter/material.dart';
import 'glassx_app_bar.dart';

/// A glass-aware [Scaffold] replacement.
///
/// [GlassXScaffold] wraps Flutter's standard [Scaffold] and sets
/// `extendBodyBehindAppBar: true` and `backgroundColor: Colors.transparent`
/// by default, so that [GlassXAppBar] and glass widgets can see the
/// content (or image/gradient) behind them.
///
/// Example:
/// ```dart
/// GlassXScaffold(
///   background: Image.asset('assets/bg.jpg', fit: BoxFit.cover),
///   appBar: GlassXAppBar(title: Text('Home')),
///   body: Center(child: GlassXContainer(child: Text('Hello'))),
/// )
/// ```
class GlassXScaffold extends StatelessWidget {
  /// Optional glass app bar. Accepts any [PreferredSizeWidget].
  final PreferredSizeWidget? appBar;

  /// The primary body content of the scaffold.
  final Widget? body;

  /// Background widget rendered behind all content (e.g., an image or gradient).
  /// When provided, it is stacked beneath [body] so glass widgets can blur it.
  final Widget? background;

  /// Background color. Defaults to transparent so the [background] shows.
  final Color? backgroundColor;

  /// Floating action button.
  final Widget? floatingActionButton;

  /// Floating action button location.
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// Bottom navigation bar or equivalent.
  final Widget? bottomNavigationBar;

  /// Drawer widget.
  final Widget? drawer;

  /// End drawer widget.
  final Widget? endDrawer;

  /// Whether the scaffold resizes when the keyboard appears.
  final bool? resizeToAvoidBottomInset;

  /// Whether the body extends behind the app bar.
  /// Defaults to `true` to enable glass app bar transparency.
  final bool extendBodyBehindAppBar;

  /// Whether the body extends behind the bottom navigation bar.
  final bool extendBody;

  const GlassXScaffold({
    super.key,
    this.appBar,
    this.body,
    this.background,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.resizeToAvoidBottomInset,
    this.extendBodyBehindAppBar = true,
    this.extendBody = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget? effectiveBody = body;

    if (background != null) {
      effectiveBody = Stack(
        fit: StackFit.expand,
        children: [
          background!,
          if (body != null) body!,
        ],
      );
    }

    return Scaffold(
      appBar: appBar,
      body: effectiveBody,
      backgroundColor: backgroundColor ?? Colors.transparent,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
      endDrawer: endDrawer,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      extendBody: extendBody,
    );
  }
}
