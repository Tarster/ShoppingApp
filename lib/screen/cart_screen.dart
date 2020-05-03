//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// //Screen Imports
// import './product_detail_screen.dart';
// import './product_overview_screen.dart';

//Provider Import
import '../providers/cart.dart' show Cart;
import '../providers/orders.dart';

//Model Import

//Widget Import
import '../widget/cart_items.dart' as ci;

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Consumer<Cart>(
                    builder: (_, cart, __) => Chip(
                      label: Text(cart.totalAmount.toStringAsFixed(2),
                          style: TextStyle(
                            color:
                                Theme.of(context).primaryTextTheme.title.color,
                          )),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  FlatButton(
                    onPressed: cart.totalAmount <= 0
                        ? null
                        : () async {
                            try {
                              Provider.of<Orders>(context).addOrders(context,
                                  cart.item.values.toList(), cart.totalAmount);
                            } catch (error) {
                              final scaffold = Scaffold.of(context);
                              scaffold.removeCurrentSnackBar();
                              scaffold.showSnackBar(
                                SnackBar(
                                  content: Text('Error Placing Order'),
                                ),
                              );
                            }
                          },
                    child: Text(
                      'ORDER NOW',
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ), //TODO :Change this to dynamic
          Expanded(
              child: Consumer<Cart>(
                  builder: (_, cart, __) => ListView.builder(
                        itemBuilder: (context, index) => ci.CartItems(
                          id: cart.item.values.toList()[index].id,
                          productId: cart.item.keys.toList()[index],
                          title: cart.item.values.toList()[index].title,
                          price: cart.item.values.toList()[index].price,
                          quantity: cart.item.values.toList()[index].quantity,
                        ),
                        itemCount: cart.itemcount,
                      )))
        ],
      ),
    );
  }
}
