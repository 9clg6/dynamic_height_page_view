# Dynamic Height PageView

[![pub package](https://img.shields.io/pub/v/dynamic_height_page_view.svg)](https://pub.dev/packages/dynamic_height_page_view)

A Flutter widget that provides a `PageView` with automatic height adaptation based on the current page content.

## Features

- ✅ Automatic height adaptation based on each page's content
- ✅ Smooth animation during height changes
- ✅ Support for touch, mouse, and stylus scrolling
- ✅ Generic type support for any data type
- ✅ Customizable callbacks for size change and tap events
- ✅ Configurable `viewportFraction` (default 0.9)

## Installation

Add this dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  dynamic_height_page_view: ^0.1.0
```

Then run:

```bash
flutter pub get
```

## Basic Usage

```dart
import 'package:dynamic_height_page_view/dynamic_height_page_view.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Height PageView Demo'),
      ),
      body: DynamicHeightPageView<int>(
        children: const <int>[1, 2, 3, 4, 5],
        childPattern: (int item) => Container(
          height: item.toDouble() * item * 50,
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue, width: 3),
          ),
          child: Center(
            child: Text(
              'Page $item\nHeight: ${item * item * 50}px',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
```

## Advanced Usage

### With custom objects

```dart
class Product {
  final String name;
  final String description;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

// In your widget
DynamicHeightPageView<Product>(
  children: products,
  childPattern: (product) => ProductCard(product: product),
  onChildTap: () {
    print('Product tapped!');
  },
  onSizeChange: () {
    print('Height changed!');
  },
)
```

### With complex dynamic content

```dart
DynamicHeightPageView<Widget>(
  children: [
    Column(
      children: [
        Image.network('https://example.com/image1.jpg'),
        const Text('Short description'),
      ],
    ),
    Column(
      children: [
        Image.network('https://example.com/image2.jpg'),
        const Text('Much longer description with multiple lines...'),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Action'),
        ),
      ],
    ),
  ],
  childPattern: (widget) => widget,
)
```

## Parameters

| Parameter | Type | Description | Required |
|-----------|------|-------------|----------|
| `children` | `List<T>` | List of items to display | ✅ Yes |
| `childPattern` | `Widget Function(T)` | Function to convert an item to a Widget | ✅ Yes |
| `onSizeChange` | `VoidCallback?` | Callback invoked when size changes | No |
| `onChildTap` | `VoidCallback?` | Callback invoked when a child is tapped | No |

## How it works

The widget uses:
1. A `PageController` with `viewportFraction: 0.9` for a peek effect
2. A custom `SizeReportingWidget` that measures each page's height
3. A `TweenAnimationBuilder` to animate height transitions
4. An `OverflowBox` to allow children to define their own height

## Contributing

Contributions are welcome! Feel free to:
- 🐛 Report bugs
- 💡 Propose new features
- 🔧 Submit pull requests

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## Author

Created with ❤️ for the Flutter community

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history.
