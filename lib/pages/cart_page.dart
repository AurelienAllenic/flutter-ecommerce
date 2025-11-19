import 'package:flutter/material.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../services/order_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final Cart cart = Cart.instance;

  Future<void> _removeItem(CartItem item) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirmation"),
        content: Text(
          "Voulez-vous vraiment supprimer '${item.product.name}' ?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Annuler"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Supprimer"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        cart.removeItem(item);
      });
    }
  }

  void _updateQuantity(CartItem item, int quantity) {
    if (quantity <= 0) return;
    setState(() {
      item.quantity = quantity;
    });
  }

  // 🔥 PAIEMENT MOCKÉ : aucun Stripe, aucune API
  Future<void> _checkout() async {
    if (cart.items.isEmpty) return;

    await Future.delayed(const Duration(seconds: 1));

    final order = Order(
      items: List.from(cart.items),
      total: cart.totalPrice,
      date: DateTime.now(),
    );

    OrderService.instance.addOrder(order);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Paiement réussi 🎉"),
        content: const Text("Votre commande a bien été enregistrée."),
        actions: [
          TextButton(
            onPressed: () {
              cart.clear();
              Navigator.of(context).pop();
              setState(() {});
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Votre Panier')),
      body: cart.items.isEmpty
          ? const Center(child: Text("Votre panier est vide"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: ListTile(
                          leading: Image.network(
                            item.product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.name),
                          subtitle: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () =>
                                    _updateQuantity(item, item.quantity - 1),
                              ),
                              Text('${item.quantity}'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                    _updateQuantity(item, item.quantity + 1),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '\$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _removeItem(item),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _checkout,
                        child: const Text('Commander'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
