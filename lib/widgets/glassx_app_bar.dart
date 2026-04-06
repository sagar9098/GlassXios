import 'package:flutter/material.dart';
import '../config/glassx_config.dart';
import '../core/glassx_provider.dart';
import 'glassx_blur.dart';

/// A glass-surfaced [AppBar] replacement.
///
/// [GlassXAppBar] renders a translucent, blurred navigation bar that floats
/// above the page content. On iOS, the native blur provides system-quality
/// transparency matching the iOS design language.
///
/// It implements [PreferredSizeWidget] so it can be used directly in
/// [Scaffold.appBar] and [GlassXScaffold.appBar].
///
/// Example:
/// ```dart
/// GlassXScaffold(
///   appBar: GlassXAppBar(title: Text('My Page')),
///   body: ...,
/// )
/// ```
class GlassXAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar. Typically a [Text].
  final Widget? title;

  /// Widgets to display after the [title].
  final List<Widget>? actions;

  /// Leading widget (typically a back button or menu icon).
  final Widget? leading;

  /// Whether to automatically include the appropriate leading widget.
  final bool automaticallyImplyLeading;

  /// Override blur strength. Inherits from config if null.
  final double? blur;

  /// Override fill opacity. Inherits from config if null.
  final double? opacity;

  /// Override tint color.
  final Color? tintColor;

  /// The app bar's preferred height. Defaults to [kToolbarHeight].
  final double? toolbarHeight;

  /// Whether to draw a border at the bottom of the app bar.
  final bool showBottomBorder;

  const GlassXAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.blur,
    this.opacity,
    this.tintColor,
    this.toolbarHeight,
    this.showBottomBorder = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final inherited = GlassXProvider.maybeOf(context) ?? const GlassXConfig();
    final mediaQuery = MediaQuery.of(context);
    final statusBarHeight = mediaQuery.padding.top;
    final barHeight = (toolbarHeight ?? kToolbarHeight) + statusBarHeight;

    return SizedBox(
      height: barHeight,
      child: GlassXBlur(
        blur: blur,
        opacity: opacity,
        tintColor: tintColor,
        borderRadius: 0,
        borderWidth: 0,
        height: barHeight,
        child: Column(
          children: [
            SizedBox(height: statusBarHeight),
            SizedBox(
              height: toolbarHeight ?? kToolbarHeight,
              child: NavigationToolbar(
                leading: leading ??
                    (automaticallyImplyLeading ? _buildLeading(context) : null),
                middle: title != null
                    ? DefaultTextStyle(
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                        child: title!,
                      )
                    : null,
                trailing: actions != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      )
                    : null,
              ),
            ),
            if (showBottomBorder)
              Divider(
                height: 1,
                color: inherited.borderColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
    final canPop = parentRoute?.canPop ?? false;
    if (canPop) {
      return IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.maybePop(context),
      );
    }
    return null;
  }
}
