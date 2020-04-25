//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widget Import
import '../widget/GridViewBuilderForOverviewScreen.dart';
import '../widget/badge.dart';
import '../widget/drawer.dart';


//Screen Imports
import 'cart_screen.dart';

//Provider Import
import '../providers/cart.dart';

enum DisplayPopMenuButton {
  favourite,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _selectFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectFav ?'Favourites':'My Shop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, child) =>
                Badge(child: child, value: cart.itemcount.toString()),
            child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){
              Navigator.pushNamed(context, CartScreen.routeName);
            }),
          ),
          PopupMenuButton(
            onSelected: (DisplayPopMenuButton selected) {
              setState(() {
                if (selected == DisplayPopMenuButton.favourite)
                  _selectFav = true;
                else
                  _selectFav = false;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: <Widget>[Icon(Icons.favorite), Text('Favourite')],
                ),
                value: DisplayPopMenuButton.favourite,
              ),
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_balance_wallet),
                    Text('All')
                  ],
                ),
                value: DisplayPopMenuButton.all,
              ),
            ],
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: GridViewBuilderForOverviewScreen(_selectFav),
    );
  }
}

// //Package Level Imports
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //Screen Imports
// import './product_detail_screen.dart';
// import './product_overview_screen.dart';

// //Provider Import
// import '../providers/products_provider.dart';

// //Model Import

// //Widget Import
