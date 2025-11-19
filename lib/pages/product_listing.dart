import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';
import 'product_detail.dart';
import '../widgets/cart_icon.dart';
import '../widgets/access_order_button.dart'; // ← Change ça selon le VRAI nom de ton fichier

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/products.json',
      );
      final List<dynamic> data = json.decode(response);

      setState(() {
        products = data.map((jsonItem) {
          // ON MET stripePriceId = '' POUR TOUT → PLUS BESOIN DE .env
          return Product(
            id: jsonItem['id'] ?? 0,
            name: jsonItem['name'] ?? 'Produit sans nom',
            price: (jsonItem['price'] as num?)?.toDouble() ?? 0.0,
            image: jsonItem['image'] ?? 'https://via.placeholder.com/150',
            stripePriceId: '', // ← VIDE, ON S'EN FOUT
          );
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur chargement produits : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        actions: const [
          CartIcon(),
          OrdersIcon(), // ← Si ça plante encore, regarde l’étape 6
        ],
      ),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailPage(product: product),
                        ),
                      ).then((_) => setState(() {}));
                    },
                  ),
                );
              },
            ),
    );
  }
}
