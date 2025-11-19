import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/product.dart';
import 'product_detail.dart';
import '../widgets/cart_icon.dart';
import '../widgets/access_order_button.dart'; // Ajoutez cet import (ajustez le chemin)

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
          String stripePriceId;

          switch (jsonItem['name']) {
            case 'Chaussures':
              stripePriceId = dotenv.env['STRIPE_PRICE_ID_SHOES'] ?? '';
              break;
            case 'T-shirt':
              stripePriceId = dotenv.env['STRIPE_PRICE_ID_TSHIRT'] ?? '';
              break;
            case 'Sac à dos':
              stripePriceId = dotenv.env['STRIPE_PRICE_ID_BAG'] ?? '';
              break;
            default:
              stripePriceId = '';
          }

          return Product(
            id: jsonItem['id'] ?? 0,
            name: jsonItem['name'] ?? 'Produit sans nom',
            price: (jsonItem['price'] as num?)?.toDouble() ?? 0.0,
            image: jsonItem['image'] ?? 'https://via.placeholder.com/150',
            stripePriceId: stripePriceId,
          );
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des produits : $e')),
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
          OrdersIcon(), // Votre widget ajouté juste après le CartIcon
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
