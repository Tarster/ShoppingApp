//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Imports
import '../screen/edit_product_screen.dart';

//Provider Import
import '../providers/products_provider.dart';
// import '../providers/cart.dart';
// import '../providers/orders.dart';

//Widget Imports
import '../widget/userProductItem.dart';
import '../widget/drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProductScreen';
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (context, index) => UserProductItem(
              product.item[index].title,
              product.item[index].imageUrl,
              product.item[index].id,
              ()=>product.deleteProduct(product.item[index].id)),
          itemCount: product.item.length,
        ),
      ),
    );
  }
}
