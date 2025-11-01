import 'package:dynamic_height_page_view/dynamic_height_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DynamicHeightPageView', () {
    testWidgets('should render with string children', (
      WidgetTester tester,
    ) async {
      final List<String> items = ['Item 1', 'Item 2', 'Item 3'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DynamicHeightPageView<String>(
              children: items,
              childPattern: (text) => Container(
                padding: const EdgeInsets.all(20),
                child: Text(text),
              ),
            ),
          ),
        ),
      );

      // Verify that the first item is rendered
      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('should handle empty children list', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DynamicHeightPageView<String>(
              children: [],
              childPattern: _buildTextWidget,
            ),
          ),
        ),
      );

      // Should not throw any errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('should call onChildTap when child is tapped', (
      WidgetTester tester,
    ) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DynamicHeightPageView<String>(
              children: const ['Item 1'],
              childPattern: (text) => Text(text),
              onChildTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      // Wait for the widget to be built
      await tester.pumpAndSettle();

      // Tap on the child
      await tester.tap(find.text('Item 1'));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('should work with custom objects', (WidgetTester tester) async {
      final List<TestItem> items = [
        const TestItem(id: 1, name: 'First'),
        const TestItem(id: 2, name: 'Second'),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DynamicHeightPageView<TestItem>(
              children: items,
              childPattern: (item) => Text(item.name),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('First'), findsOneWidget);
    });

    testWidgets('should render PageView with correct controller', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DynamicHeightPageView<String>(
              children: const ['Page 1', 'Page 2', 'Page 3'],
              childPattern: (text) => Text(text),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify PageView exists
      expect(find.byType(PageView), findsOneWidget);
    });
  });

  group('SizeReportingWidget', () {
    testWidgets('should report size changes', (WidgetTester tester) async {
      Size? reportedSize;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizeReportingWidget(
              onSizeChange: (Size size) {
                reportedSize = size;
              },
              child: const SizedBox(
                width: 100,
                height: 200,
                child: Text('Test'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The size should be reported after the frame
      expect(reportedSize, isNotNull);
      expect(reportedSize!.width, 100);
      expect(reportedSize!.height, 200);
    });

    testWidgets('should handle child widget correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizeReportingWidget(
              onSizeChange: (Size size) {},
              child: const Text('Child Widget'),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Child Widget'), findsOneWidget);
    });
  });
}

// Helper function for const constructor
Widget _buildTextWidget(String text) {
  return Text(text);
}

// Test class for custom object testing
class TestItem {
  const TestItem({required this.id, required this.name});

  final int id;
  final String name;
}
