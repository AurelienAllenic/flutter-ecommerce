# E_Commerce Flutter

Une application Flutter e-commerce simple avec gestion de panier, historique des commandes, et authentification via Firebase. Cette application fonctionne sur mobile (Android/iOS) et Web avec des fonctionnalités spécifiques à chaque plateforme.

---

## Fonctionnalités principales

### Gestion des produits

- Les produits sont stockés dans un fichier JSON local (`assets/products.json`).
- Affichage de la liste des produits avec image, nom et prix.
- Recherche dynamique d’un produit précis dans la liste.
- Possibilité de consulter le détail d’un produit.

### Panier

- Ajouter des produits au panier avec choix de la quantité.
- Modification de la quantité directement dans le panier.
- Suppression de produits du panier.
- Total du panier affiché en temps réel.

### Commandes

- Paiement **mocké** (pas de Stripe ni API réelle).
- Historique des commandes précédentes avec détails des produits commandés.
- Possibilité de **re-commander** un produit depuis l’historique.

### Authentification

- Inscription et connexion via **Firebase Authentication**.
- Gestion des comptes utilisateurs.
- Champs mot de passe avec option de **montrer/cacher le mot de passe**.
- Confirmation du mot de passe lors de l’inscription.

### Partage

- Fonction **Web Share** pour partager la liste des produits sur le web.
- Support des **Intents Android** pour partager un produit.
- Support du **CupertinoPageScaffold** sur iOS pour l’affichage natif.

### Interface

- Design responsive avec largeur maximale pour web/grands écrans.
- Listes et formulaires stylés avec `Card` et `TextField`.
- Feedback utilisateur avec `SnackBar` et `CupertinoDialog` selon la plateforme.

---

## Installation

1. Clonez le dépôt :

```bash
git clone https://github.com/AurelienAllenic/flutter-ecommerce.git
cd e_commerce_flutter
flutter pub get
flutter run
```

## Arcitecture

lib/
├── main.dart
├── pages/
│ ├── login.dart
│ ├── register.dart
│ ├── product_listing.dart
│ ├── product_detail.dart
│ ├── cart_page.dart
│ └── orders_page.dart
├── models/
│ ├── product.dart
│ ├── cart.dart
│ ├── cart_item.dart
│ └── order.dart
├── services/
│ └── order_service.dart
├── widgets/
│ ├── cart_icon.dart
│ ├── access_order_button.dart
│ └── logout_icon.dart
assets/
└── products.json

## Dépendances principales

- flutter
- firebase_auth
- url_launcher
- share_plus

## Notes

Le paiement est simulé, aucune transaction réelle n’est effectuée.

L’application est conçue pour être responsive et fonctionne sur Web, Android et iOS.

Les produits peuvent être facilement modifiés via le fichier JSON sans toucher au code.

Authentification Firebase requise pour l’accès aux commandes et au panier.

## Auteurs

Projet réalisé par Aurélien Allenic, étudiant à l’IIM Digital School du pôle Léonard de Vinci.
Lien GitHub : https://github.com/AurelienAllenic

## Licence

MIT
