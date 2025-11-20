import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';
import '../models/cart.dart';
import '../models/cart_item.dart';
import '../services/order_service.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  void _reorderItem(BuildContext context, CartItem item) {
    final cart = Cart.instance;
    cart.addItem(CartItem(product: item.product, quantity: item.quantity));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "'${item.product.name}' ajouté au panier (x${item.quantity})",
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final orders = OrderService.instance.orders;
    final maxWidth = 600.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Commandes Précédentes')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: orders.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('Aucune commande pour le moment.'),
                  ),
                )
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final formattedDate = DateFormat(
                      'dd/MM/yyyy HH:mm',
                    ).format(order.date);

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: ExpansionTile(
                          title: Text(
                            'Commande du $formattedDate',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Total : \$${order.total.toStringAsFixed(2)}',
                            style: const TextStyle(color: Colors.green),
                          ),
                          children: order.items.map((item) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[200],
                                    child: Image.network(
                                      item.product.image,
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stack) =>
                                          const Icon(
                                            Icons.broken_image,
                                            size: 24,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Quantité : ${item.quantity} | Prix unitaire : \$${item.product.price.toStringAsFixed(2)}',
                                        ),
                                        Text(
                                          'Sous-total : \$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: ElevatedButton.icon(
                                            onPressed: () =>
                                                _reorderItem(context, item),
                                            icon: const Icon(
                                              Icons.shopping_cart,
                                            ),
                                            label: const Text(
                                              'Commander à nouveau',
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
