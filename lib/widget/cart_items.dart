//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widget Import
// import '../widget/GridViewBuilderForOverviewScreen.dart';
// import '../widget/badge.dart';

// //Screen Imports
// import 'cart_screen.dart';

//Provider Import
import '../providers/cart.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItems({this.id, this.productId, this.price, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    final double total = price * quantity;
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Are you Sure'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: <Widget>[
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(true) , child: Text('Yes')),
                    FlatButton(onPressed: ()=>Navigator.of(context).pop(false), child: Text('No')),
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text('\$$price.'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$' + total.toStringAsFixed(2)),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
