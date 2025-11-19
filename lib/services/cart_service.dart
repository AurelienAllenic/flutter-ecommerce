/*import 'cart_item.dart';
import 'product.dart';

class CartService {
  CartService._private();
  static final CartService instance = CartService._private();

  final List<CartItem> items = [];

  void addToCart(Product product, int qty) {
    final existing = items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem(product: product, quantity: 0),
    );

    if (existing.quantity == 0) {
      items.add(CartItem(product: product, quantity: qty));
    } else {
      existing.quantity += qty;
    }
  }

  int get totalItems => items.length;
}
*/
