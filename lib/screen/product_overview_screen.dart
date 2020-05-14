//Package Level Imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Widget Import
import '../widget/GridViewBuilderForOverviewScreen.dart';
import '../widget/badge.dart';
import '../widget/drawer.dart';

//Screen Imports
import 'cart_screen.dart';

//Provider Import
import '../providers/cart.dart';
import '../providers/products_provider.dart';

enum DisplayPopMenuButton {
  favourite,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  static const String routeName = '/ProductOverViewScreen';

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _selectFav = false;
  var _isInit = true;
  var _isLoading = false;
  var _isNull =false;

  @override
  void initState() {
    // Provider.of<ProductProvider>(context).fetchAndSyncProducts();
    // Future.delayed(Duration.zero).then((_){
    //     Provider.of<ProductProvider>(context).fetchAndSyncProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isInit = false;
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchAndSyncProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      }).catchError((error){
        print(error.toString());
        
        if(error.toString() =='Null')
          {
              setState(() {
                _isNull =true;
              });
          }       
        print('this is another error:'+error);
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectFav ? 'Favourites' : 'My Shop'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, child) =>
                Badge(child: child, value: cart.itemcount.toString()),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routeName);
                }),
          ),
          PopupMenuButton(
            onSelected: (DisplayPopMenuButton selected) {
              setState(() {
                if (selected == DisplayPopMenuButton.favourite)
                  _selectFav = true;
                else
                  _selectFav = false;
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Row(
                  children: <Widget>[Icon(Icons.favorite), Text('Favourite')],
                ),
                value: DisplayPopMenuButton.favourite,
              ),
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.account_balance_wallet),
                    Text('All')
                  ],
                ),
                value: DisplayPopMenuButton.all,
              ),
            ],
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: RefreshIndicator(
              onRefresh: (){
                  return Provider.of<ProductProvider>(context).fetchAndSyncProducts();
              },
              child: _isNull ? Center(child: Text('There is no product in the server'),):_isLoading
            ? Center(child: CircularProgressIndicator())
            : GridViewBuilderForOverviewScreen(_selectFav),
      ),
    );
  }
}

// //Package Level Imports
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// //Screen Imports
// import './product_detail_screen.dart';
// import './product_overview_screen.dart';

// //Provider Import
// import '../providers/products_provider.dart';

// //Model Import

// //Widget Import
