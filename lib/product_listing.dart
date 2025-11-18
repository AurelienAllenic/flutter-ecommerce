import 'package:flutter/material.dart';

class ProductListingPage extends StatelessWidget {
  const ProductListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produits')),
      body: const Center(child: Text('Vous êtes bien connecté !')),
    );
  }
}
