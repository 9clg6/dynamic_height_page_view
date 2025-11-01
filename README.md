# Dynamic Height PageView

[![pub package](https://img.shields.io/pub/v/dynamic_height_page_view.svg)](https://pub.dev/packages/dynamic_height_page_view)

Un widget Flutter qui fournit un `PageView` avec adaptation automatique de la hauteur en fonction du contenu de la page actuelle.

## Fonctionnalités

- ✅ Adaptation automatique de la hauteur selon le contenu de chaque page
- ✅ Animation fluide lors du changement de hauteur
- ✅ Support du défilement tactile, souris et stylet
- ✅ Type générique pour tout type de données
- ✅ Callbacks personnalisables pour les événements de changement de taille et de tap
- ✅ Configuration du `viewportFraction` (par défaut 0.9)

## Installation

Ajoutez cette dépendance à votre fichier `pubspec.yaml`:

```yaml
dependencies:
  dynamic_height_page_view: ^0.1.0
```

Puis exécutez:

```bash
flutter pub get
```

## Utilisation de base

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
      body: DynamicHeightPageView<String>(
        children: const [
          'Page courte',
          'Page moyenne avec plus de contenu',
          'Page très longue avec beaucoup de contenu qui nécessite plus d\'espace',
        ],
        childPattern: (text) => Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
```

## Utilisation avancée

### Avec des objets personnalisés

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

// Dans votre widget
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

### Avec un contenu dynamique complexe

```dart
DynamicHeightPageView<Widget>(
  children: [
    Column(
      children: [
        Image.network('https://example.com/image1.jpg'),
        const Text('Description courte'),
      ],
    ),
    Column(
      children: [
        Image.network('https://example.com/image2.jpg'),
        const Text('Description beaucoup plus longue avec plusieurs lignes...'),
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

## Paramètres

| Paramètre | Type | Description | Requis |
|-----------|------|-------------|--------|
| `children` | `List<T>` | Liste des éléments à afficher | ✅ Oui |
| `childPattern` | `Widget Function(T)` | Fonction de conversion d'un élément en Widget | ✅ Oui |
| `onSizeChange` | `VoidCallback?` | Callback appelé quand la taille change | Non |
| `onChildTap` | `VoidCallback?` | Callback appelé quand un enfant est tapé | Non |

## Comment ça fonctionne

Le widget utilise:
1. Un `PageController` avec `viewportFraction: 0.9` pour un effet de peek
2. Un `SizeReportingWidget` personnalisé qui mesure la hauteur de chaque page
3. Un `TweenAnimationBuilder` pour animer les transitions de hauteur
4. Un `OverflowBox` pour permettre aux enfants de définir leur propre hauteur

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- 🐛 Signaler des bugs
- 💡 Proposer de nouvelles fonctionnalités
- 🔧 Soumettre des pull requests

## License

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

## Auteur

Créé avec ❤️ pour la communauté Flutter

## Changelog

Voir [CHANGELOG.md](CHANGELOG.md) pour l'historique des versions.
