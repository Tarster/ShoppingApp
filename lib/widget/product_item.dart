//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Import
import '../screen/product_detail_screen.dart';

// //Widget Import
// import './product_item.dart';

// //Provider Import
// import '../providers/products_provider.dart';

//Model Import
import '../model/product.dart';

class ProductItem extends StatelessWidget {

  void onClickSendProductID(BuildContext context, String id) {
    Navigator.pushNamed(context, ProductDetailScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final product =Provider.of<Product>(context);
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => onClickSendProductID(context,product.id),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
              icon: Icon(product.isFavourite ? Icons.favorite:Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () {
                product.toggleFavouriteStatus();
              }),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {}),
        ),
      ),
    );
  }
}
