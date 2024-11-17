import 'package:flutter/material.dart';

class ShippingProvider with ChangeNotifier {
  final Map<String, int> _items = {}; // id товара и его количество

  Map<String, int> get items => _items;

  // Получить текущее количество товара
  int getQuantity(String itemId) {
    return _items[itemId] ?? 0;
  }

  // Добавить товар
  void addItem(String itemId) {
    if (_items.containsKey(itemId)) {
      _items[itemId] = _items[itemId]! + 1;
    } else {
      _items[itemId] = 1;
    }
    notifyListeners();
  }

  // Добавить товар с конкретным количеством
  void addItemWithQuantity(String itemId, int quantity) {
    if (_items.containsKey(itemId)) {
      _items[itemId] = _items[itemId]! + quantity;
    } else {
      _items[itemId] = quantity;
    }
    notifyListeners();
  }

  // Удалить товар
  void removeItem(String itemId) {
    if (_items.containsKey(itemId)) {
      if (_items[itemId]! > 1) {
        _items[itemId] = _items[itemId]! - 1;
      } else {
        _items.remove(itemId); // Удалить товар, если количество становится 0
      }
      notifyListeners();
    }
  }

  // Очистить все товары
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
