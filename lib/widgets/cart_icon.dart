import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../pages/cart_page.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({super.key});

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  void initState() {
    super.initState();
  }

  int get totalItems =>
      Cart.instance.items.fold(0, (sum, item) => sum + item.quantity);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            ).then((_) => setState(() {}));
          },
        ),
        if (totalItems > 0)
          Positioned(
            right: 25,
            top: 6,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: Text(
                '$totalItems',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
