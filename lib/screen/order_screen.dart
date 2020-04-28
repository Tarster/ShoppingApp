//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//Widget Import
import '../widget/OrderItem.dart';
import '../widget/drawer.dart';
// //Screen Imports
// import 'cart_screen.dart';

//Provider Import
import '../providers/orders.dart' show Orders;

class OrderScreen extends StatelessWidget {
  static const routeName = '/Orders';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, index) => OrderItem(orderData.orders[index])),
    );
  }
}
