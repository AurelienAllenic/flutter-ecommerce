import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../models/product.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../widgets/cart_icon.dart';
import '../widgets/access_order_button.dart';
import '../widgets/logout_icon.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;

  void addToCart() {
    final cartItem = CartItem(product: widget.product, quantity: quantity);
    Cart.instance.addItem(cartItem);

    final message = '${widget.product.name} ajouté au panier (x$quantity)';

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Ajouté'),
          content: Text(message),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }

    setState(() {});
  }

  Future<void> shareProduct() async {
    final text =
        '${widget.product.name} — ${widget.product.price.toStringAsFixed(2)}\nDécouvrez-le !';
    try {
      await Share.share(text);
    } catch (e) {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Partage impossible'),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur partage : $e')));
      }
    }
  }

  Widget buildActions() {
    final List<Widget> actions = [];

    if (kIsWeb) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: shareProduct,
          tooltip: 'Partager (Web)',
        ),
      );
    }

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      actions.add(
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: shareProduct,
          tooltip: 'Partager (Android)',
        ),
      );
    }

    // Cart / Orders / Logout (toujours présents)
    actions.addAll(const [CartIcon(), OrdersIcon(), LogoutIcon()]);

    return Row(mainAxisSize: MainAxisSize.min, children: actions);
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.product.image,
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) => Container(
              height: 250,
              color: Colors.grey[200],
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image, size: 48),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.product.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "\$${widget.product.price.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 20, color: Colors.green),
          ),
          const SizedBox(height: 16),
          const Text(
            "Description du produit :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Pour l'instant, aucune description détaillée disponible.",
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Quantité :",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    setState(() {
                      quantity--;
                    });
                  }
                },
              ),
              Text(quantity.toString(), style: const TextStyle(fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    quantity++;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: addToCart,
              child: const Text("Ajouter au panier"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.product.name),
          trailing: buildActions(),
        ),
        child: SafeArea(child: SingleChildScrollView(child: buildContent())),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [buildActions()],
      ),
      body: SingleChildScrollView(child: buildContent()),
    );
  }
}
