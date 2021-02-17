import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const ROUTE_NAME = '/product-details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final product = Provider.of<Products>(
      context,
      listen:
          false, // Listen set to false would prevent it from listening to the notify received on any future data updates
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
    );
  }
}
