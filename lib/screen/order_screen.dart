//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//Widget Import
import '../widget/OrderItem.dart'as ot;
import '../widget/drawer.dart';
// //Screen Imports
// import 'cart_screen.dart';

//Provider Import
import '../providers/orders.dart';
//import '../providers/orders.dart';


class OrderScreen extends StatefulWidget {
  static const routeName = '/Orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_){
      Provider.of<Orders>(context,listen: false).fetchAndSyncOrders();
    });
    super.initState();
  }
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
          itemBuilder: (context, index) => ot.OrderItem(orderData.orders[index])),
    );
  }
}
