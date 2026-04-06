# GlassXios

A production-ready Flutter package providing a **native-powered iOS Liquid Glass UI system** with adaptive rendering for Android and Web platforms.

Write your UI once, get stunning real frosted glass on iOS via `UIVisualEffectView` using Hybrid Composition, and graceful `BackdropFilter` material fallbacks everywhere else.

![GlassXios Cover](https://via.placeholder.com/1200x600.png?text=GlassXios+-+Native+Glass+UI)

##  Features

-  **True iOS Native Glass**: Uses `UIVisualEffectView`, `UIBlurEffect`, and `UIVibrancyEffect` mapped through a Flutter `PlatformView`.
-  **Adaptive Android & Web Fallbacks**: Graceful degradation using standard Flutter `BackdropFilter` if native glass isn't available.
-  **Performance Presets**: Switch between `.low()`, `.balanced()`, and `.high()` quality depending on the device capability or layout complexity.
-  **Complete Widget Suite**: Includes drop-in replacements for standard components: `GlassXScaffold`, `GlassXAppBar`, `GlassXNavBar`, `GlassXCard`, `GlassXContainer`, etc.
-  **Global Configuration**: Set up a `GlassXConfig` theme at the root of your app using `GlassXMaterialApp` and override locally when needed.
-  **Debug Overlay**: Built-in HUD to profile blur strength, platform renderer, and performance mode.

## 🚀 Installation

Add `glassx_ios` to your `pubspec.yaml`:

```yaml
dependencies:
  glassx_ios: ^1.0.0
```

Run `flutter pub get`.

## 🛠 Usage Example

Replace your standard `MaterialApp` with `GlassXMaterialApp`, and use `GlassX...` widgets to automatically harness native blur when available!

```dart
import 'package:flutter/material.dart';
import 'package:glassx_ios/glassx.dart';

void main() {
  runApp(
    GlassXMaterialApp(
      config: GlassXConfig.high(), // Use high-quality presets
      home: MyGlassApp(),
    ),
  );
}

class MyGlassApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassXScaffold(
      // The background image will be blurred by glass widgets above it
      background: Image.network(
        'https://source.unsplash.com/random/1080x1920',
        fit: BoxFit.cover,
      ),
      appBar: GlassXAppBar(
        title: Text('GlassXios Demo', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: GlassXCard(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Native iOS Blur', style: TextStyle(fontSize: 24, color: Colors.white)),
              SizedBox(height: 12),
              Text('Write once, get liquid glass everywhere.', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GlassXNavBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
```

## ⚙️ Platform Behavior & Limitations

🚨 **IMPORTANT PERFORMANCE CONSIDERATIONS**

Because Flutter engine rendering and iOS native UI rendering use different pipelines:
1. **iOS Native (`UiKitView`)**: 
   - Produces the exact Apple authentic blur.
   - Responds to hardware iOS visual configurations.
   - **Limitation**: Hybrid Composition interpolates Flutter layers. While highly optimized in Flutter 3.0+, deeply nesting `GlassXBlur` layers inside lists might cause UI jitter on complex scroll events. Use cautiously in `ListView` elements.
2. **Android & Web (`BackdropFilter`)**:
   - Produces excellent simulated blur using standard Flutter SKIA/Impeller rendering pipeline.
   - Does *not* have the Hybrid Composition UI jitter limitation.
   - Doesn't support native `UIVibrancyEffect`.

### Performance Modes

GlassXios comes with handy modes inside `GlassXConfig`:

```dart
GlassXConfig.low()      // Blur sigma 6, no vibrancy. Best for older devices or scroll lists.
GlassXConfig.balanced() // Blur sigma 15. Default mode.
GlassXConfig.high()     // Blur sigma 25, enables UIVibrancyEffect on iOS.
```

## 📝 API Reference

Please check the source code documentation for an exhaustive API breakdown. Every widget and class is heavily annotated with DartDoc comments.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
