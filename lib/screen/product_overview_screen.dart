//Package Level Imports
import 'package:flutter/material.dart';

//Widget Import
import '../widget/GridViewBuilderForOverviewScreen.dart';

class ProductOverviewScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: GridViewBuilderForOverviewScreen(),
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

