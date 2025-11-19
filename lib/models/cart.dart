import 'cart_item.dart';

class Cart {
  Cart._privateConstructor();

  static final Cart instance = Cart._privateConstructor();

  final List<CartItem> items = [];

  void addItem(CartItem item) {
    final index = items.indexWhere((i) => i.product.id == item.product.id);
    if (index >= 0) {
      items[index].quantity += item.quantity;
    } else {
      items.add(item);
    }
  }

  void removeItem(CartItem item) {
    items.remove(item);
  }

  void clear() {
    items.clear();
  }

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.product.price * item.quantity);
}
