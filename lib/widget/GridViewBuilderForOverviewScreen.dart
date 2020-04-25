//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widget Import
import './product_item.dart';

//Provider Import
import '../providers/products_provider.dart';
//import '../providers/cart.dart';

//Model Import
import '../model/product.dart';



class GridViewBuilderForOverviewScreen extends StatelessWidget {
  final bool selectFav;

  GridViewBuilderForOverviewScreen(this.selectFav);
  
  @override
  Widget build(BuildContext context) {
    
    final productProviderInstance = Provider.of<ProductProvider>(context);
    
    List<Product> loadedProduct = selectFav ? productProviderInstance.fav : productProviderInstance.item;
    
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      itemCount: loadedProduct.length,
      itemBuilder: (context, i) => ChangeNotifierProvider.value(
        value: loadedProduct[i],
        child:  ProductItem(),
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


