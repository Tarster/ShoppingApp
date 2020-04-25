import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item ={};

  Map<String, CartItem> get item {
    return {..._item};
  }

  int get itemcount{
    return _item.length;
  }

  double get totalAmount{
    var total =0.0;
    _item.forEach((key,cartItem){
        total +=cartItem.price *cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_item.containsKey(productId)) {
      //Update Quantity
      _item.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity+1,
              price: existingCartItem.price+price));
    } else {
      _item.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeItem(String id)
  {
    _item.remove(id);
    notifyListeners();
  }

  void clear()
  {
    _item={};
    notifyListeners();
  }
}
