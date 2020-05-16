import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/http_exception.dart';
import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {

  List<OrderItem> _orders = [];

  final String authToken;

  Orders(this.authToken,this._orders);

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchAndSyncOrders() async {
    final url = 'https://tarster-2c5a4.firebaseio.com/Orders.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      if (extractedData == null) throw HttpException('Null');

      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['Product'] as List<dynamic>)
              .map((productData) => CartItem(
                  id: productData['id'],
                  title: productData['title'],
                  quantity: productData['quantity'],
                  price: productData['price']))
              .toList(),
        ));

        _orders = loadedOrders;
        notifyListeners();
      });
    } catch (error) {
      //print(error.toString());
      throw error;
    }
  }

  Future<void> addOrders(
      BuildContext context, List<CartItem> cartproducts, double total) async {
    final url = 'https://tarster-2c5a4.firebaseio.com/Orders.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'amount': total,
            'dateTime': DateTime.now().toIso8601String(),
            'Product': cartproducts
                .map((cp) => {
                      'id': cp.id,
                      'title': cp.title,
                      'quantity': cp.quantity,
                      'price': cp.price,
                    })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              id: json.decode(response.body)['name'],
              amount: total,
              dateTime: DateTime.now(),
              products: cartproducts));
      Provider.of<Cart>(context).clear();
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
