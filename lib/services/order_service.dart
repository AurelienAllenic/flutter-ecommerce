import '../models/order.dart';

class OrderService {
  static final OrderService instance = OrderService._internal();
  final List<Order> _orders = [];

  OrderService._internal();

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
  }
}
