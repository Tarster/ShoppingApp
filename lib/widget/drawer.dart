//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Imports
import '../screen/order_screen.dart';
import '../screen/product_overview_screen.dart';
import '../screen/user_product_screen.dart';

//Provider Import
import '../providers/auth.dart';

import '../helpers/custom_route.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              'Menu',
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () => Navigator.pushReplacementNamed(
                context, ProductOverviewScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () =>Navigator.of(context).pushReplacement(CustomRoute(builder: (context)=>OrderScreen()),),
                //Navigator.pushReplacementNamed(context, OrderScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Manage Items'),
            onTap: () => Navigator.pushReplacementNamed(
                context, UserProductScreen.routeName),
          ),
          Divider(),
          Consumer<Auth>(
            builder:(context,auth,_) =>
            ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              auth.logout();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
            ),
          ),
        ],
      ),
    );
  }
}
