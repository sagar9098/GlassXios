import Flutter
import UIKit

/// GlassXios Flutter plugin — registers the native blur PlatformView factory.
///
/// This class is instantiated by the Flutter engine via the plugin registrar.
/// It registers `GlassXBlurViewFactory` under the view-type identifier
/// `io.glassx/blur_view`, which matches the constant used on the Dart side.
public class GlassXPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = GlassXBlurViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "io.glassx/blur_view")
    }
}
