import 'package:flutter/foundation.dart'; // Optional, for better debugging
import 'cart_item.dart'; // Assuming CartItem is in models/cart_item.dart or adjust path

class Order {
  final List<CartItem> items;
  final double total;
  final DateTime date;

  Order({required this.items, required this.total, required this.date});
}
