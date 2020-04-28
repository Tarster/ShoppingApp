//Package Level Imports
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

//Screen Imports

//Provider Import
// import '../providers/products_provider.dart';
// import '../providers/cart.dart';
// import '../providers/orders.dart';

//Widget Imports
// import '../widget/userProductItem.dart';
// import '../widget/drawer.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProduct';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Form(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _priceFocusNode,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(
                      top: 8,
                      right: 10), //TODO:Static margin convert to dynamic
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: Container(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Image Url'),
                  
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
