import 'package:flutter_test/flutter_test.dart';
import 'package:glassx_ios/glassx.dart';

void main() {
  group('GlassXConfig', () {
    test('default constructor creates balanced config', () {
      const config = GlassXConfig();
      expect(config.blurStrength, 20.0);
      expect(config.opacity, 0.15);
      expect(config.performanceMode, GlassXPerformance.balanced);
      expect(config.enableVibrancy, false);
    });

    test('low() factory creates low performance config', () {
      final config = GlassXConfig.low();
      expect(config.blurStrength, 8.0);
      expect(config.opacity, 0.20);
      expect(config.performanceMode, GlassXPerformance.low);
      expect(config.enableVibrancy, false);
    });

    test('high() factory creates high performance config', () {
      final config = GlassXConfig.high();
      expect(config.blurStrength, 30.0);
      expect(config.opacity, 0.10);
      expect(config.performanceMode, GlassXPerformance.high);
      expect(config.enableVibrancy, true);
    });

    test('copyWith updates specified fields only', () {
      const config = GlassXConfig();
      final updated = config.copyWith(
        blurStrength: 10.0,
        enableVibrancy: true,
      );

      expect(updated.blurStrength, 10.0);
      expect(updated.enableVibrancy, true);
      // Ensure others are unchanged
      expect(updated.opacity, config.opacity);
      expect(updated.performanceMode, config.performanceMode);
    });
  });

  group('GlassXPerformance', () {
    test('extension returns correct values', () {
      expect(GlassXPerformance.low.blurSigma, 6.0);
      expect(GlassXPerformance.balanced.blurSigma, 15.0);
      expect(GlassXPerformance.high.blurSigma, 25.0);

      expect(GlassXPerformance.low.animationsEnabled, false);
      expect(GlassXPerformance.high.animationsEnabled, true);
    });
  });
}
