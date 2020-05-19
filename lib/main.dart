//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_store/helpers/custom_route.dart';

//Screen Imports
import './screen/product_detail_screen.dart';
import './screen/product_overview_screen.dart';
import './screen/cart_screen.dart';
import './screen/order_screen.dart';
import './screen/user_product_screen.dart';
import './screen/edit_product_screen.dart';
import './screen/auth_screen.dart';
import './screen/splash_screen.dart';

//Provider Import
import './providers/products_provider.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          update: (context, auth, previousProducts) => ProductProvider(
              auth.userID,
              auth.token,
              previousProducts == null ? [] : previousProducts.item),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, auth, previousOrders) => Orders(
                auth.token,
                auth.userID,
                previousOrders == null ? [] : previousOrders.orders)),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Shopping',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android:CustomPageTransitionBuilder(),
              TargetPlatform.iOS:CustomPageTransitionBuilder(),
            },)
          ),
          initialRoute: ProductOverviewScreen.routeName,
          home: auth.isAuth
              ? ProductOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, authResultsnapshot) => authResultsnapshot.connectionState==ConnectionState.waiting?SplashScreen(): AuthScreen(),
                ),
          routes: {
            ProductOverviewScreen.routeName: (context) =>ProductOverviewScreen(),
            ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            OrderScreen.routeName: (context) => OrderScreen(),
            UserProductScreen.routeName: (context) => UserProductScreen(),
            EditProductScreen.routeName: (context) => EditProductScreen(),
          },
        ),
      ),
      //create: (BuildContext context) {},
    );
  }
}
