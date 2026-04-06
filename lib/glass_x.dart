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
export 'widgets/glass_x_material_app.dart';
export 'widgets/glass_x_scaffold.dart';
export 'widgets/glass_x_app_bar.dart';
export 'widgets/glass_x_container.dart';
export 'widgets/glass_x_card.dart';
export 'widgets/glass_x_blur.dart';
export 'widgets/glass_x_nav_bar.dart';
export 'widgets/glass_x_bottom_sheet.dart';
export 'widgets/glass_x_dialog.dart';

// Utils
export 'utils/glassx_color_utils.dart';
export 'utils/glassx_debug_overlay.dart';
