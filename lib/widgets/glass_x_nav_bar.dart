import 'package:flutter/material.dart';
import 'glass_x_blur.dart';

/// A glass-styled bottom navigation bar.
///
/// [GlassXNavBar] renders a frosted navigation bar that sits at the bottom
/// of the screen. It blurs the content behind it for an iOS-style appearance.
///
/// Use it with [GlassXScaffold.bottomNavigationBar]:
/// ```dart
/// GlassXScaffold(
///   bottomNavigationBar: GlassXNavBar(
///     currentIndex: _selectedIndex,
///     onTap: (i) => setState(() => _selectedIndex = i),
///     items: [
///       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///       BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
///       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
///     ],
///   ),
/// )
/// ```
class GlassXNavBar extends StatelessWidget {
  /// The navigation bar items to display.
  final List<BottomNavigationBarItem> items;

  /// Index of the currently selected item.
  final int currentIndex;

  /// Called when an item is tapped.
  final ValueChanged<int>? onTap;

  /// Override blur strength. Inherits from config if null.
  final double? blur;

  /// Override tint color.
  final Color? tintColor;

  /// Color of the selected icon and label.
  final Color? selectedItemColor;

  /// Color of unselected icons and labels.
  final Color? unselectedItemColor;

  /// Whether to show labels for all items.
  final bool showSelectedLabels;

  /// Whether to show labels for unselected items.
  final bool showUnselectedLabels;

  /// The type of bottom navigation bar.
  final BottomNavigationBarType type;

  const GlassXNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.blur,
    this.tintColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    this.type = BottomNavigationBarType.fixed,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;
    final barHeight = kBottomNavigationBarHeight + bottomPadding;
    final theme = Theme.of(context);

    return SizedBox(
      height: barHeight,
      child: GlassXBlur(
        blur: blur,
        tintColor: tintColor,
        borderRadius: 0,
        borderWidth: 0,
        height: barHeight,
        child: Theme(
          data: theme.copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: selectedItemColor ?? theme.colorScheme.primary,
            unselectedItemColor: unselectedItemColor ??
                theme.colorScheme.onSurface.withValues(alpha: 0.5),
            showSelectedLabels: showSelectedLabels,
            showUnselectedLabels: showUnselectedLabels,
            type: type,
          ),
        ),
      ),
    );
  }
}
