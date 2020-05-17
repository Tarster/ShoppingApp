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

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSyncProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<ProductProvider>(context);
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (context, snapshot) => snapshot.connectionState ==ConnectionState.waiting ? 
        Center(child: CircularProgressIndicator()):RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Consumer<ProductProvider>(
            
                      builder:(context,product,_)=> Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemBuilder: (context, index) => UserProductItem(
                  product.item[index].title,
                  product.item[index].imageUrl,
                  product.item[index].id,
                ),
                itemCount: product.item.length,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
