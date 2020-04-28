//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Imports
import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';
import './screen/cart_screen.dart';
import './screen/order_screen.dart';
import './screen/user_product_screen.dart';
import './screen/edit_product_screen.dart';


//Provider Import
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ProductProvider()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(value: Orders())
      ],
      child: MaterialApp(
        title: 'Shopping',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          ProductOverviewScreen.routeName: (context) => ProductOverviewScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName:(context) =>CartScreen(), 
          OrderScreen.routeName:(context)=>OrderScreen(),
          UserProductScreen.routeName:(context)=>UserProductScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen(),
        },
      ),
      //create: (BuildContext context) {},
    );
  }
}
