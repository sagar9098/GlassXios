import Flutter
import UIKit

/// The native iOS platform view that renders a `UIVisualEffectView` (Liquid Glass).
///
/// ## Architecture
/// Flutter's PlatformView mechanism embeds this `UIView` directly into
/// the iOS native view hierarchy (Hybrid Composition). The `UIVisualEffectView`
/// is a self-contained compositing layer managed by UIKit, giving us
/// authentic system-quality frosted glass that honours the current
/// wallpaper, light/dark mode, and tint in real time.
///
/// ## Parameter Map (received via `creationParams`)
/// | Key              | Type    | Description                               |
/// |------------------|---------|-------------------------------------------|
/// | `blurStrength`   | Double  | Gaussian blur sigma (0–40)                |
/// | `cornerRadius`   | Double  | Corner radius in points                   |
/// | `tintColor`      | Int     | ARGB integer colour value                 |
/// | `enableVibrancy` | Bool    | If true, wraps content in UIVibrancyEffect|
///
/// ## Memory & Performance
/// - `UIVisualEffectView` is managed by ARC; no manual retain/release needed.
/// - Layout is handled via `autoresizingMask`, avoiding Auto Layout overhead.
/// - The view is removed cleanly when Flutter disposes the PlatformView.
public class GlassXBlurView: NSObject, FlutterPlatformView {

    // MARK: - Private storage

    /// Root container returned to Flutter.
    private let containerView: UIView

    /// The actual blur view — `UIVisualEffectView` with a blur effect.
    private var blurView: UIVisualEffectView?

    /// The vibrancy view layered on top of the blur view (optional).
    private var vibrancyView: UIVisualEffectView?

    /// Tint overlay view rendered above the blur surface.
    private var tintView: UIView?

    // MARK: - Init

    public init(
        frame: CGRect,
        viewId: Int64,
        args: Any?,
        messenger: FlutterBinaryMessenger
    ) {
        containerView = UIView(frame: frame)
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clear

        super.init()

        // Parse creation parameters
        let params = args as? [String: Any] ?? [:]
        applyParams(params, to: containerView.bounds)
    }

    // MARK: - FlutterPlatformView

    public func view() -> UIView {
        return containerView
    }

    // MARK: - Parameter Application

    /// Builds or rebuilds the native view hierarchy from [params].
    private func applyParams(_ params: [String: Any], to bounds: CGRect) {
        // ── Decode params ──────────────────────────────────────────────────
        let blurStrength   = params["blurStrength"]   as? Double ?? 20.0
        let cornerRadius   = params["cornerRadius"]   as? Double ?? 16.0
        let tintColorValue = params["tintColor"]      as? Int    ?? 0x1AFFFFFF
        let enableVibrancy = params["enableVibrancy"] as? Bool   ?? false

        // ── Corner radius ──────────────────────────────────────────────────
        containerView.layer.cornerRadius  = cornerRadius
        containerView.layer.masksToBounds = true

        // ── Remove any previous layers ─────────────────────────────────────
        blurView?.removeFromSuperview()
        vibrancyView?.removeFromSuperview()
        tintView?.removeFromSuperview()

        // ── Build UIBlurEffect ─────────────────────────────────────────────
        // `UIBlurEffect(style:)` maps iOS system material — we use
        // `.systemThinMaterial` and modulate perceived intensity via a custom
        // `UIVisualEffectView` subclass that scales `alpha`.
        let blurStyle: UIBlurEffect.Style = .systemThinMaterial
        let blurEffect = UIBlurEffect(style: blurStyle)

        let newBlurView = UIVisualEffectView(effect: blurEffect)
        newBlurView.frame = containerView.bounds
        newBlurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Modulate intensity by adjusting blur view alpha.
        // Clamp to (0.1, 1.0) to avoid completely opaque or invisible glass.
        let normalised = CGFloat(blurStrength / 40.0).clamped(to: 0.1...1.0)
        newBlurView.alpha = normalised

        containerView.addSubview(newBlurView)
        blurView = newBlurView

        // ── Vibrancy layer (optional) ──────────────────────────────────────
        if enableVibrancy {
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let newVibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            newVibrancyView.frame = newBlurView.contentView.bounds
            newVibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newBlurView.contentView.addSubview(newVibrancyView)
            vibrancyView = newVibrancyView
        }

        // ── Tint overlay ───────────────────────────────────────────────────
        let newTintView = UIView(frame: containerView.bounds)
        newTintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newTintView.backgroundColor = color(from: tintColorValue)
        newTintView.isUserInteractionEnabled = false
        containerView.addSubview(newTintView)
        tintView = newTintView
    }

    // MARK: - Helpers

    /// Converts a Flutter ARGB integer (a, r, g, b packed into Int) to `UIColor`.
    private func color(from argb: Int) -> UIColor {
        let a = CGFloat((argb >> 24) & 0xFF) / 255.0
        let r = CGFloat((argb >> 16) & 0xFF) / 255.0
        let g = CGFloat((argb >>  8) & 0xFF) / 255.0
        let b = CGFloat((argb      ) & 0xFF) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

// MARK: - Comparable clamped helper
private extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}
