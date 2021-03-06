import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_store/model/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus(String token,String userId) async {
    var oldFavourite = isFavourite;
    final url = 'https://tarster-2c5a4.firebaseio.com/UserFavourites/$userId/$id.json?auth=$token';
    isFavourite = !isFavourite;
    notifyListeners();
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavourite,
          ));
      if (response.statusCode >= 400) {
        isFavourite = oldFavourite;
        notifyListeners();
        throw HttpException('Error favourite Not modified');
      }
    } catch (error) {
      isFavourite = oldFavourite;
      notifyListeners();
      throw HttpException('Error favourite Not modified');
    }
  }
}
