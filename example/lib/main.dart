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
              'Swipez horizontalement pour voir les différentes pages avec des hauteurs dynamiques',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: DynamicHeightPageView<PageData>(
              children: _pages,
              childPattern: (pageData) => _PageCard(pageData: pageData),
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

class PageData {
  const PageData({
    required this.title,
    required this.description,
    required this.color,
    required this.itemCount,
  });

  final String title;
  final String description;
  final Color color;
  final int itemCount;
}

final List<PageData> _pages = const [
  PageData(
    title: 'Page Courte',
    description: 'Ceci est une page avec peu de contenu.',
    color: Colors.blue,
    itemCount: 2,
  ),
  PageData(
    title: 'Page Moyenne',
    description:
        'Cette page contient un peu plus de contenu et devrait avoir une hauteur différente de la première page.',
    color: Colors.green,
    itemCount: 4,
  ),
  PageData(
    title: 'Page Longue',
    description:
        'Cette page est beaucoup plus longue et contient beaucoup plus de contenu. Elle devrait s\'adapter automatiquement pour afficher tout son contenu.',
    color: Colors.orange,
    itemCount: 6,
  ),
  PageData(
    title: 'Page Très Courte',
    description: 'Minimal!',
    color: Colors.purple,
    itemCount: 1,
  ),
];

class _PageCard extends StatelessWidget {
  const _PageCard({required this.pageData});

  final PageData pageData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: pageData.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: pageData.color,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pageData.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: pageData.color.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            pageData.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            'Éléments de la liste:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            pageData.itemCount,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 8, color: pageData.color),
                  const SizedBox(width: 8),
                  Text('Élément ${index + 1}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Bouton de ${pageData.title} pressé!'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: pageData.color,
              foregroundColor: Colors.white,
            ),
            child: const Text('Action'),
          ),
        ],
      ),
    );
  }
}

