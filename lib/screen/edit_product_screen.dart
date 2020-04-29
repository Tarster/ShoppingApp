//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Imports

//Provider Import
import '../model/product.dart';
import '../providers/products_provider.dart';
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
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isInit = true;
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var _editedproduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit == true) {
      var productId = ModalRoute.of(context).settings.arguments;
      if (productId != null) {
        _editedproduct = Provider.of<ProductProvider>(context, listen: false)
            .findProductByID(productId);
        _initValues = {
          'title': _editedproduct.title,
          'description': _editedproduct.description,
          'price': _editedproduct.price.toString(),
          //'imageUrl': _editedproduct.imageUrl,
        };
        _imageUrlController.text = _editedproduct.imageUrl;
      }
    }
    //print('dependencies:'+_editedproduct.description);
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      var value = _imageUrlController.text;
      if (value.isEmpty ||
          (!value.startsWith('http') && !value.startsWith('https')) ||
          (!value.endsWith('.jpg') &&
              !value.endsWith('.jpeg') &&
              !value.endsWith('.png'))) return;

      setState(() {});
    }
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm() {
    _form.currentState.save();
    _form.currentState.validate();
    if (_editedproduct.id != null) {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editedproduct.id, _editedproduct);
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .addProduct(_editedproduct);
    }
    // print('Savefrom Function:'+_editedproduct.description);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
        ],
      ),
      body: Form(
        key: _form,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  _editedproduct = Product(
                      id: _editedproduct.id,
                      isFavourite: _editedproduct.isFavourite,
                      title: value,
                      description: _editedproduct.description,
                      price: _editedproduct.price,
                      imageUrl: _editedproduct.imageUrl);
                      // print('title:'+_editedproduct.description);
                },
                validator: (value) {
                  if (value.isEmpty) return 'Enter a value';

                  return null;
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                validator: (value) {
                  if (value.isEmpty)
                    return 'Enter a value';
                  else if (double.parse(value) == null)
                    return 'Enter a valid number';
                  else if (double.parse(value) >= 0)
                    return 'Price should be greater than 0';

                  return null;
                },
                onSaved: (value) {
                  _editedproduct = Product(
                      id: _editedproduct.id,
                      isFavourite: _editedproduct.isFavourite,
                      title: _editedproduct.title,
                      description: _editedproduct.description,
                      price: double.parse(value),
                      imageUrl: _editedproduct.imageUrl);
                      // print('price:'+_editedproduct.description);
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                validator: (value) {
                  if (value.isEmpty)
                    return 'Enter a value';
                  else if (value.length >= 10)
                    return 'description must be greater than 10 characters';

                  return null;
                },
                onSaved: (value) {
                  _editedproduct = Product(
                      id: _editedproduct.id,
                      isFavourite: _editedproduct.isFavourite,
                      title: _editedproduct.title,
                      description: value,
                      price: _editedproduct.price,
                      imageUrl: _editedproduct.imageUrl);
                      // print('actual description:'+_editedproduct.description);
                      // print('INIt description:'+_initValues['description']);
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
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
                  child: Container(
                    child: _imageUrlController.text.isEmpty
                        ? Text('Enter the url')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Image Url',
                    ),
                    validator: (value) {
                      if (value.isEmpty)
                        return 'Enter a value';
                      else if (!value.startsWith('http') &&
                          !value.startsWith('https'))
                        return 'Enter a valid URL with http or https';
                      else if (!value.endsWith('.jpg') &&
                          !value.endsWith('.jpeg') &&
                          !value.endsWith('.png'))
                        return 'Enter a valid URL with address ending in jjpg,jpeg or png.';
                      return null;
                    },
                    //textInputAction: TextInputAction.done,
                    controller: _imageUrlController,
                    focusNode: _imageUrlFocusNode,
                    onSaved: (value) {
                      _editedproduct = Product(
                          id: _editedproduct.id,
                          isFavourite: _editedproduct.isFavourite,
                          title: _editedproduct.title,
                          description: _editedproduct.description,
                          price: _editedproduct.price,
                          imageUrl: value);
                          // print('ImageUrl:'+_editedproduct.description);
                    },
                    onFieldSubmitted: (_) => _saveForm(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
