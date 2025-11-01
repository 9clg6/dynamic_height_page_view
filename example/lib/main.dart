import 'package:dynamic_height_page_view/dynamic_height_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Height PageView Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Dynamic Height PageView Demo'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Swipe horizontally to see different pages with dynamic heights',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: DynamicHeightPageView<int>(
              children: const <int>[1, 2, 3, 4, 5],
              childPattern: (int item) {
                final List<Color> colors = [
                  Colors.blue,
                  Colors.green,
                  Colors.orange,
                  Colors.purple,
                  Colors.red,
                ];
                return Container(
                  height: item.toDouble() * item * 50,
                  decoration: BoxDecoration(
                    color: colors[item - 1].withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colors[item - 1],
                      width: 3,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Page $item',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: colors[item - 1],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Height: ${item * item * 50}px',
                          style: TextStyle(
                            fontSize: 20,
                            color: colors[item - 1].withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              onChildTap: () {
                debugPrint('Page tapped!');
              },
              onSizeChange: () {
                debugPrint('Height changed!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
