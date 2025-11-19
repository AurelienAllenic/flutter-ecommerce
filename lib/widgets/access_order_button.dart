import 'package:flutter/material.dart';
import '../pages/orders.dart';

class OrdersIcon extends StatelessWidget {
  const OrdersIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.history),
      tooltip: 'Voir mes commandes précédentes',
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrdersPage()),
        );
      },
    );
  }
}
