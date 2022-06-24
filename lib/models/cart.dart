// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shopping/models/cart_item.dart';
import 'package:shopping/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (newItem) => CartItem(
          id: newItem.id,
          productId: newItem.productId,
          name: newItem.name,
          quantity: newItem.quantity + 1,
          price: newItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productId: product.id,
          name: product.name,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (newItem) => CartItem(
          id: newItem.id,
          productId: newItem.productId,
          name: newItem.name,
          quantity: newItem.quantity - 1,
          price: newItem.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
