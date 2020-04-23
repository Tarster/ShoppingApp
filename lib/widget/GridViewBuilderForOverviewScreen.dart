//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widget Import
import './product_item.dart';

//Provider Import
import '../providers/products_provider.dart';

//Model Import
import '../model/product.dart';



class GridViewBuilderForOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final productProviderInstance = Provider.of<ProductProvider>(context);
    List<Product> loadedProduct = productProviderInstance.item;
    
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: loadedProduct.length,
      itemBuilder: (context, i) => ChangeNotifierProvider(
        builder: (c) => loadedProduct[i],
        child:  ProductItem(
        // id: loadedProduct[i].id,
        // title: loadedProduct[i].title,
        // imageUrl: loadedProduct[i].imageUrl,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        ),
    );
  }
}


