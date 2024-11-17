import 'package:flutter/material.dart';
import '../models/order.dart';

class OrdersProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final order = _orders.firstWhere((order) => order.id == orderId);
    order.status = newStatus;
    notifyListeners();
  }
}
