import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}

class CartProvider with ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      title: 'Headphone',
      price: 500000,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500',
    ),
    Product(
      id: '2',
      title: 'SmartWatch',
      price: 1000000,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500',
    ),
    Product(
      id: '3',
      title: 'Laptop RPL Pro',
      price: 12500000,
      imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=500',
    ),
    Product(
      id: '4',
      title: 'Keyboard Mechanical',
      price: 500000,
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=500',
    ),
  ];

  final Map<String, CartItem> _cartItems = {};

  List<Product> get items => [..._products];
  Map<String, CartItem> get cartItems => {..._cartItems};

  int get itemCount {
    int total = 0;
    _cartItems.forEach((key, item) {
      total += item.quantity;
    });
    return total;
  }

  double get totalAmount {
    double total = 0.0;
    _cartItems.forEach((key, item) {
      total += item.price * item.quantity;
    });
    return total;
  }

  void addToCart(Product product) {
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
        product.id,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          imageUrl: existing.imageUrl,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _cartItems.putIfAbsent(
        product.id,
        () => CartItem(
          id: product.id,
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void reduceQuantity(String productId) {
    if (!_cartItems.containsKey(productId)) return;
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          imageUrl: existing.imageUrl,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void addQuantity(String productId) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          title: existing.title,
          price: existing.price,
          imageUrl: existing.imageUrl,
          quantity: existing.quantity + 1,
        ),
      );
      notifyListeners();
    }
  }

  void addProduct(String title, double price, String imageUrl) {
    _products.add(
      Product(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        imageUrl: imageUrl.isEmpty
            ? 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=500'
            : imageUrl,
      ),
    );
    notifyListeners();
  }
}