# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [0.1.0] - 2025-11-01

### Added
- `DynamicHeightPageView` widget with automatic height adaptation
- Generic type support for any data type
- Smooth height transition animations with `TweenAnimationBuilder`
- Support for touch, mouse, stylus, and unknown device scrolling
- `onSizeChange` and `onChildTap` callbacks
- Internal `SizeReportingWidget` to measure page heights
- `viewportFraction` configuration set to 0.9 for peek effect
- Comprehensive code documentation
- Usage examples in README

### Features
- PageView with dynamic height based on content
- Height animations with `easeInOutCubic` curve (100ms)
- 12px spacing between pages
- SafeArea support

[0.1.0]: https://github.com/9clg6/dynamic_height_page_view/releases/tag/v0.1.0
