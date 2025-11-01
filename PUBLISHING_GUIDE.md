# Publishing Guide to pub.dev

This document explains how to publish this package to pub.dev.

## Prerequisites

1. **pub.dev Account**: Make sure you have an account on [pub.dev](https://pub.dev)
2. **Google Authentication**: You must sign in with your Google account
3. **Clean Git**: Commit all your changes before publishing

## Steps before first publication

### 1. Update URLs in `pubspec.yaml`

Replace `YOUR_USERNAME` with your actual GitHub username:

```yaml
homepage: https://github.com/YOUR_USERNAME/dynamic_height_page_view
repository: https://github.com/YOUR_USERNAME/dynamic_height_page_view
issue_tracker: https://github.com/YOUR_USERNAME/dynamic_height_page_view/issues
```

### 2. Update LICENSE

Replace `[Your Name]` in the `LICENSE` file with your actual name:

```
Copyright (c) 2025 [Your Name]
```

### 3. Create a GitHub repository

```bash
# Initialize git if not already done
git init

# Create a .gitignore
cat > .gitignore << 'EOF'
# Flutter/Dart
.dart_tool/
.packages
build/
pubspec.lock

# IDE
.idea/
.vscode/
*.iml
*.swp

# OS
.DS_Store
Thumbs.db

# Build outputs
*.so
*.dylib
*.dll
*.exe
*.apk
*.ipa
EOF

# Add all files
git add .
git commit -m "Initial commit: Dynamic Height PageView package"

# Create the repository on GitHub then:
git remote add origin https://github.com/YOUR_USERNAME/dynamic_height_page_view.git
git branch -M main
git push -u origin main
```

## Publishing

### 1. Verify the package

Before publishing, test with `--dry-run`:

```bash
fvm dart pub publish --dry-run
```

This command verifies:
- ✅ Package structure
- ✅ Required files (README, LICENSE, CHANGELOG)
- ✅ Documentation
- ✅ Dependencies
- ✅ Potential conflicts

### 2. Publish the package

If everything is OK, publish:

```bash
fvm dart pub publish
```

You will be prompted to:
1. Confirm the files that will be published
2. Authenticate with your Google account
3. Confirm the publication

### 3. Verify publication

After a few minutes, your package will be visible at:
- https://pub.dev/packages/dynamic_height_page_view
- Documentation automatically generated

## Publishing a new version

### 1. Update the code

Make your modifications in the code.

### 2. Update the version

In `pubspec.yaml`, increment the version according to [Semantic Versioning](https://semver.org/):
- **MAJOR** (1.0.0): breaking changes
- **MINOR** (0.1.0): new compatible features
- **PATCH** (0.0.1): bug fixes

```yaml
version: 0.2.0  # For example
```

### 3. Update CHANGELOG

Add a section in `CHANGELOG.md`:

```markdown
## [0.2.0] - 2025-11-XX

### Added
- New feature X

### Changed
- Improvement of Y

### Fixed
- Bug Z

[0.2.0]: https://github.com/YOUR_USERNAME/dynamic_height_page_view/releases/tag/v0.2.0
```

### 4. Commit and tag

```bash
git add .
git commit -m "Release version 0.2.0"
git tag v0.2.0
git push origin main --tags
```

### 5. Publish

```bash
fvm dart pub publish
```

## Publication checklist

- [ ] Tests pass (`fvm flutter test`)
- [ ] Documentation up to date
- [ ] CHANGELOG.md updated
- [ ] Version incremented in pubspec.yaml
- [ ] LICENSE contains your name
- [ ] GitHub URLs correct in pubspec.yaml
- [ ] Code committed and pushed to GitHub
- [ ] Git tag created
- [ ] `fvm dart pub publish --dry-run` succeeds
- [ ] Published with `fvm dart pub publish`

## Useful commands

```bash
# Analyze code
fvm flutter analyze

# Format code
fvm dart format .

# Check outdated dependencies
fvm flutter pub outdated

# Update dependencies
fvm flutter pub upgrade

# View package scores
# Visit: https://pub.dev/packages/dynamic_height_page_view/score
```

## Best practices

1. **Semantic versioning**: Strictly follow [semver.org](https://semver.org/)
2. **Detailed CHANGELOG**: Document all changes
3. **Comprehensive tests**: Add tests for each feature
4. **Documentation**: Keep README up to date with examples
5. **Breaking changes**: Document them clearly and increment MAJOR version
6. **Deprecations**: Use `@Deprecated` and document migrations

## Support and maintenance

- Respond to GitHub issues quickly
- Accept quality pull requests
- Maintain compatibility with latest Flutter versions
- Test on multiple platforms (iOS, Android, Web, Desktop)

## Resources

- [Publishing packages](https://dart.dev/tools/pub/publishing)
- [Package layout conventions](https://dart.dev/tools/pub/package-layout)
- [Verified publishers](https://dart.dev/tools/pub/verified-publishers)
- [Package scoring](https://pub.dev/help/scoring)
