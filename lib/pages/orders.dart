import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pour formater la date (ajoutez au pubspec.yaml si besoin : intl: ^0.18.0)

import '../models/order.dart';
import '../models/cart_item.dart';
import '../services/order_service.dart'; // Ajustez le chemin si nécessaire

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = OrderService.instance.orders;

    return Scaffold(
      appBar: AppBar(title: const Text('Mes Commandes Précédentes')),
      body: orders.isEmpty
          ? const Center(child: Text('Aucune commande pour le moment.'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final formattedDate = DateFormat(
                  'dd/MM/yyyy HH:mm',
                ).format(order.date);
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text('Commande du $formattedDate'),
                    subtitle: Text(
                      'Total : \$${order.total.toStringAsFixed(2)}',
                    ),
                    children: [
                      ...order.items.map(
                        (item) => ListTile(
                          leading: Image.network(
                            item.product.image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                          title: Text(item.product.name),
                          subtitle: Text(
                            'Quantité : ${item.quantity} | Prix : \$${item.product.price.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
