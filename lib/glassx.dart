/// GlassXios — Native-powered iOS Liquid Glass UI System for Flutter.
///
/// Core exports:
/// - [GlassXMaterialApp] — root app widget with global glass configuration
/// - [GlassXScaffold] — glass-aware scaffold
/// - [GlassXAppBar] — transparent glass app bar
/// - [GlassXContainer] — composable glass container
/// - [GlassXCard] — elevated glass card
/// - [GlassXBlur] — low-level blur primitive
/// - [GlassXNavBar] — glass bottom navigation bar
/// - [GlassXBottomSheet] — glass modal bottom sheet helper
/// - [GlassXDialog] — glass alert dialog helper
/// - [GlassXConfig] — global configuration model
/// - [GlassXPerformance] — performance mode enum
/// - [GlassXProvider] — InheritedWidget config accessor
library glassx_ios;

// Config
export 'config/glassx_config.dart';
export 'config/glassx_performance.dart';

// Core
export 'core/glassx_provider.dart';
export 'core/glassx_theme.dart';

// Platform
export 'platform/glassx_platform.dart';

// Widgets
export 'widgets/glassx_material_app.dart';
export 'widgets/glassx_scaffold.dart';
export 'widgets/glassx_app_bar.dart';
export 'widgets/glassx_container.dart';
export 'widgets/glassx_card.dart';
export 'widgets/glassx_blur.dart';
export 'widgets/glassx_nav_bar.dart';
export 'widgets/glassx_bottom_sheet.dart';
export 'widgets/glassx_dialog.dart';

// Utils
export 'utils/glassx_color_utils.dart';
export 'utils/glassx_debug_overlay.dart';
