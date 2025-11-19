import 'package:flutter/material.dart';
import '../pages/orders.dart'; // Ajustez le chemin vers OrdersPage

class OrdersIcon extends StatelessWidget {
  const OrdersIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.history,
      ), // Icône pour "historique/commandes", changez si besoin (e.g., Icons.list)
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
