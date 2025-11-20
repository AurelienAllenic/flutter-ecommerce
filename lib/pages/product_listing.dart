import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:share_plus/share_plus.dart';

import '../models/product.dart';
import 'product_detail.dart';
import '../widgets/cart_icon.dart';
import '../widgets/access_order_button.dart';
import '../widgets/logout_icon.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  List<Product> allProducts = [];
  List<Product> displayedProducts = [];
  String searchQuery = '';

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

      final loadedProducts = data.map((jsonItem) {
        return Product(
          id: jsonItem['id'] ?? 0,
          name: jsonItem['name'] ?? 'Produit sans nom',
          price: (jsonItem['price'] as num?)?.toDouble() ?? 0.0,
          image: jsonItem['image'] ?? 'https://via.placeholder.com/150',
          stripePriceId: '',
        );
      }).toList();

      setState(() {
        allProducts = loadedProducts;
        displayedProducts = loadedProducts;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur chargement produits : $e')),
      );
    }
  }

  void updateSearch(String query) {
    final filtered = allProducts
        .where(
          (product) => product.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    setState(() {
      searchQuery = query;
      displayedProducts = filtered;
    });
  }

  void shareAllProducts() {
    final text = allProducts.map((p) => p.name).join(", ");
    Share.share("Découvrez nos produits : $text");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des produits'),
        actions: [
          if (kIsWeb)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: shareAllProducts,
              tooltip: "Partager (Web Share)",
            ),

          if (!kIsWeb && Platform.isAndroid)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: shareAllProducts,
              tooltip: "Partager sur Android",
            ),

          const CartIcon(),
          const OrdersIcon(),
          const LogoutIcon(),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: updateSearch,
            ),
          ),
          Expanded(
            child: displayedProducts.isEmpty
                ? const Center(child: Text("Aucun produit trouvé"))
                : ListView.builder(
                    itemCount: displayedProducts.length,
                    itemBuilder: (context, index) {
                      final product = displayedProducts[index];
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
                          subtitle: Text(
                            '\$${product.price.toStringAsFixed(2)}',
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailPage(product: product),
                              ),
                            ).then((_) => setState(() {}));
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
