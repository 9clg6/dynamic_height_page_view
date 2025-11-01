import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A [PageView] widget that automatically adjusts its height based on the
/// current page's content.
///
/// This widget wraps Flutter's [PageView] and uses a [TweenAnimationBuilder]
/// to smoothly animate height changes when switching between pages.
///
/// {@tool snippet}
/// Example usage:
///
/// ```dart
/// DynamicHeightPageView<String>(
///   children: ['Page 1', 'Page 2', 'Page 3'],
///   childPattern: (text) => Container(
///     padding: EdgeInsets.all(20),
///     child: Text(text),
///   ),
/// )
/// ```
/// {@end-tool}
class DynamicHeightPageView<T> extends StatefulWidget {
  /// Creates a [DynamicHeightPageView].
  ///
  /// The [children] and [childPattern] parameters are required.
  const DynamicHeightPageView({
    required this.children,
    required this.childPattern,
    super.key,
    this.onSizeChange,
    this.onChildTap,
  });

  /// Callback invoked when the size of any child changes.
  ///
  /// This can be useful for triggering additional UI updates or analytics.
  final VoidCallback? onSizeChange;

  /// Callback invoked when a child is tapped.
  ///
  /// This is triggered by the [GestureDetector] wrapping each child widget.
  final VoidCallback? onChildTap;

  /// The list of data items to display in the page view.
  ///
  /// Each item of type [T] will be converted to a [Widget] using [childPattern].
  final List<T> children;

  /// A function that converts each data item of type [T] into a [Widget].
  ///
  /// This is called for each item in [children] to build the visual
  /// representation of that page.
  final Widget Function(T) childPattern;

  @override
  State<DynamicHeightPageView<T>> createState() =>
      _DynamicHeightPageViewState<T>();
}

class _DynamicHeightPageViewState<T> extends State<DynamicHeightPageView<T>> {
  late PageController _pageController;
  late List<double> _heights;
  late int _currentPage;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();

    _currentPage = 0;

    _heights = List<double>.filled(widget.children.length, 0, growable: true);
    _pageController = PageController(viewportFraction: 0.9)
      ..addListener(() {
        final double? page = _pageController.page;
        if (page == null) return;
        final int newPage = page.round();
        if (_currentPage != newPage) {
          setState(() => _currentPage = newPage);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: TweenAnimationBuilder<double>(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 100),
        tween: Tween<double>(begin: 0, end: _currentHeight),
        builder: (_, double value, Widget? child) => SizedBox(
          height: value,
          width: MediaQuery.of(context).size.width,
          child: child,
        ),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: const <PointerDeviceKind>{
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
            },
          ),
          child: PageView(
            controller: _pageController,
            physics: const PageScrollPhysics(),
            onPageChanged: (int index) {
              debugPrint(index.toString());
            },
            children: _sizeReportingChildren
                .asMap() //
                .map(MapEntry.new)
                .values
                .toList(),
          ),
        ),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map((int index, T item) {
        return MapEntry<int, Widget>(
          index,
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                widget.onChildTap?.call();
              },
              child: DecoratedBox(
                decoration: const BoxDecoration(color: Colors.white),
                child: OverflowBox(
                  minHeight: 10,
                  maxHeight: double.infinity,
                  alignment: Alignment.bottomCenter,
                  child: SizeReportingWidget(
                    onSizeChange: (Size size) {
                      if (_heights.length < widget.children.length) {
                        for (
                          int i = 0;
                          i < widget.children.length - _heights.length;
                          i++
                        ) {
                          _heights.add(0);
                        }
                      }
                      widget.onSizeChange?.call();
                      setState(() => _heights[index] = size.height);
                    },
                    child: widget.childPattern(item),
                  ),
                ),
              ),
            ),
          ),
        );
      })
      .values
      .toList();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

/// A widget that reports its size whenever it changes.
///
/// This widget measures its child's size after each build and notifies
/// the parent via [onSizeChange] callback when the size differs from
/// the previous measurement.
///
/// This is used internally by [DynamicHeightPageView] to track each
/// page's height and adjust the container accordingly.
class SizeReportingWidget extends StatefulWidget {
  /// Creates a [SizeReportingWidget].
  ///
  /// Both [child] and [onSizeChange] are required.
  const SizeReportingWidget({
    required this.child,
    required this.onSizeChange,
    super.key,
  });

  /// The child widget whose size will be measured.
  final Widget child;

  /// Callback invoked when the child's size changes.
  ///
  /// Receives the new [Size] of the child widget.
  final ValueChanged<Size> onSizeChange;

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    if (!mounted) {
      return;
    }
    final Size? size = context.size;
    if (_oldSize != size && size != null) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}
