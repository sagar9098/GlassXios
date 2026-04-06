import 'package:flutter/material.dart';
import 'package:glassx_ios/glass_x.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap your app with GlassXMaterialApp to provide global config
    return GlassXMaterialApp(
      title: 'GlassXios Demo',
      // Provide a high quality config profile, and enable debug mode
      config: GlassXConfig.high().copyWith(debugMode: true),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // 2. Use GlassXScaffold to allow content under the AppBar
    return GlassXScaffold(
      // The background will be blurred by glass widgets floating above it
      background: _buildColorfulBackground(),
      appBar: GlassXAppBar(
        title: const Text('GlassXios'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // 3. Show a glass dialog
              GlassXDialog.show(
                context: context,
                title: const Text('About GlassXios'),
                content: const Text(
                  'This is a native-powered liquid glass UI. '
                  'On iOS, it uses UIVisualEffectView via PlatformViews. '
                  'On Android/Web, it falls back to BackdropFilter.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close',
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              );
            },
          )
        ],
      ),
      body: _buildBody(),
      // 4. Use GlassXNavBar for bottom navigation tracking app bar style
      bottomNavigationBar: GlassXNavBar(
        currentIndex: _currentIndex,
        onTap: (idx) => setState(() => _currentIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        top: kToolbarHeight + MediaQuery.of(context).padding.top + 20,
        bottom: 40,
        left: 20,
        right: 20,
      ),
      children: [
        const Text(
          'Liquid Glass Components',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),

        // 5. Use GlassXCard for floating panels
        GlassXCard(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.apple, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'True Native Blur',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                'Notice how the background gradients smoothly blend through the glass surface.',
                style: TextStyle(color: Colors.white70, height: 1.5),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // 6. Use GlassXBottomSheet for sleek modals
                  GlassXBottomSheet.show(
                    context: context,
                    builder: (ctx) => const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Text(
                        'This is a Glass Bottom Sheet surfacing above the main content.',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Show Bottom Sheet'),
              )
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 7. Use GlassXContainer for simple boxed wraps
        GlassXContainer(
          borderRadius: 20,
          child: const Center(
            child: Text(
              'A standard Glass Container',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ],
    );
  }

  /// Builds a highly colorful and moving background to clearly demonstrate
  /// the blurring capabilities. The more colorful, the more obvious the glass.
  Widget _buildColorfulBackground() {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purple.withValues(alpha: 0.6),
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          right: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withValues(alpha: 0.5),
            ),
          ),
        ),
        Positioned(
          top: 300,
          left: 100,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink.withValues(alpha: 0.4),
            ),
          ),
        ),
      ],
    );
  }
}
