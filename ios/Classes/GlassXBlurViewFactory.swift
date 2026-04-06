import Flutter
import UIKit

/// Factory that creates [GlassXBlurView] instances for the Flutter engine.
///
/// Registered in [GlassXPlugin.register] under the view-type identifier
/// `io.glassx/blur_view`. The Flutter engine calls [create] whenever a
/// `UiKitView` with the matching `viewType` is inserted into the widget tree.
public class GlassXBlurViewFactory: NSObject, FlutterPlatformViewFactory {

    private let messenger: FlutterBinaryMessenger

    public init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    // MARK: - FlutterPlatformViewFactory

    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return GlassXBlurView(
            frame: frame,
            viewId: viewId,
            args: args,
            messenger: messenger
        )
    }

    /// Declare the codec used to decode the `creationParams` map sent from Dart.
    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}
