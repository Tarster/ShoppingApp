//Package Level Imports
import 'package:flutter/material.dart';
import 'package:shopping_store/screen/order_screen.dart';

//Screen Imports
import '../screen/order_screen.dart';
import '../screen/product_overview_screen.dart';


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
            onTap: () =>
                Navigator.pushNamed(context, ProductOverviewScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () =>
                Navigator.pushNamed(context, OrderScreen.routeName),
          )
        ],
      ),
    );
  }
}
