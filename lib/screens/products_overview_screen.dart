import 'package:flutter/material.dart';
import 'package:go_shoppin/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyShop',
        ),
      ),
      body: ProductsGrid(),
    );
  }
}
