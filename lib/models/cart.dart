import 'cart_item.dart';

class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  double get totalPrice {
    return items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  int get totalItems {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
}
