//Package Level Imports
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

//Screen Import
import '../screen/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  final Function deleteproduct;

  UserProductItem(this.title, this.imageUrl,this.id,this.deleteproduct);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.amberAccent,
              ),
              onPressed: ()=>Navigator.of(context).pushNamed(EditProductScreen.routeName,arguments: id),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: deleteproduct,
            ),
          ],
        ),
      ),
    );
  }
}
