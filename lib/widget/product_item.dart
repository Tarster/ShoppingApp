import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(
        'Null',
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black38,
        leading: IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
        title: Text(
          'Hello',
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
      ),
    );
  }
}
