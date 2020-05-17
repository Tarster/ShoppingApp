import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../model/http_exception.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _item = [];

  final String authToken;
  final String userId;
  ProductProvider(this.userId, this.authToken, this._item);

  List<Product> get fav {
    return _item.where((item) => item.isFavourite == true).toList();
  }

  // Future<void> updateFavouriteOnServer()
  // {
  //   const url = 'https://tarster-2c5a4.firebaseio.com/product.json';
  //   print(_item.where((item) => item.isFavourite == true).toList());

  //   //http.patch(url,body:json.encode({}));
  // }

  List<Product> get item {
    return [..._item];
  }

  Product findProductByID(String id) {
    return _item.firstWhere((item) => item.id == id);
  }

  Future<void> fetchAndSyncProducts([bool filterStatus =false]) async {
    final filterString = filterStatus ?'&orderBy="creatorId"&equalTo="$userId':'';
    var url =
        'https://tarster-2c5a4.firebaseio.com/product.json?auth=$authToken$filterString"';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      //print(extractedData);
      //final extractedData =null;
      if (extractedData == null) {
        //print('This is here in extracted data null check');
        throw HttpException('NULL');
      }
     // print('userId:'+userId) ;
     // print("authToken:"+authToken);
      url =
          'https://tarster-2c5a4.firebaseio.com/UserFavourites/$userId.json?auth=$authToken';

      final favouriteResponse = await http.get(url);
       // print('FavouriteResponse:'+ favouriteResponse.toString());
      final favouriteData = json.decode(favouriteResponse.body);
        //print('FavouriteData:'+favouriteData.toString());
      extractedData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          isFavourite:
              favouriteData == null ? false : favouriteData[prodId] ?? false,
        ));
        _item = loadedProduct;
        notifyListeners();
      });
    } on HttpException catch(error){
      //print('In on HttpException Null');
      
      throw HttpException(error.toString());

    }
    catch (error) {
      //print(_item);
      print('Error:' +error);
      //print(error.toString());
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://tarster-2c5a4.firebaseio.com/product.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'creatorId':userId,
          }));
      // .then((response) {
      //print(json.decode(response.body));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _item.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    // }).catchError((error){
    //   print(error.toString());
    //   throw error;
    // });
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _item.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url =
          'https://tarster-2c5a4.firebaseio.com/product/$id.json?auth=$authToken';
      try {
        await http.patch(url,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
            }));
        _item[prodIndex] = product;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    }
  }

  Future<void> deleteProduct(String productID) async {
    final url =
        'https://tarster-2c5a4.firebaseio.com/product/$productID.json?auth=$authToken';
    final existingProductIndex =
        _item.indexWhere((prod) => prod.id == productID);
    var existingProduct = _item[existingProductIndex];

    _item.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _item.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product');
    }
    existingProduct = null;
  }
}
