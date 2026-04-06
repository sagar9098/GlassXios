import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glassx_ios/glass_x.dart';

void main() {
  group('GlassX Widgets', () {
    testWidgets('GlassXMaterialApp provides config to descendants', (WidgetTester tester) async {
      final customConfig = GlassXConfig.high().copyWith(blurStrength: 42.0);

      await tester.pumpWidget(
        GlassXMaterialApp(
          config: customConfig,
          home: Scaffold(
            body: Builder(
              builder: (context) {
                // Read from nearest provider
                final config = GlassXProvider.of(context);
                expect(config.blurStrength, 42.0);
                return const Text('Test');
              },
            ),
          ),
        ),
      );

      expect(find.text('Test'), findsOneWidget);
    });

    testWidgets('GlassXBlur fallback renders BackdropFilter when not iOS', (WidgetTester tester) async {
      // Platform defaults to Android visually in standard tests unless spoofed
      await tester.pumpWidget(
        const GlassXMaterialApp(
          home: GlassXScaffold(
            body: Center(
              child: GlassXBlur(
                blur: 10,
                child: Text('Blur Child'),
              ),
            ),
          ),
        ),
      );

      // Verify child renders
      expect(find.text('Blur Child'), findsOneWidget);
      // Since it's not iOS in the test environment natively, we expect BackdropFilter fallback.
      expect(find.byType(BackdropFilter), findsWidgets);
    });
  });
}
