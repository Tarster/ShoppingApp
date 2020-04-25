//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Import

//Widget Import

//Provider Import
import '../providers/products_provider.dart';

//Model Import
import '../model/product.dart';


class ProductDetailScreen extends StatelessWidget {
  static const String routeName = '/ProductDetailScreen';


  @override
  Widget build(BuildContext context) {
    
    final String id =ModalRoute.of(context).settings.arguments;
    final Product loadedProduct = Provider.of<ProductProvider>(context,listen: false).findProductByID(id);
    return Scaffold(
      appBar: AppBar(title: Text(loadedProduct.title),),
         body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '\$${loadedProduct.price}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}