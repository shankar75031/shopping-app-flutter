import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/cart.dart';
import 'package:go_shoppin/providers/orders.dart';
import 'package:go_shoppin/providers/products.dart';
import 'package:go_shoppin/screens/cart_screen.dart';
import 'package:go_shoppin/screens/edit_product_screen.dart';
import 'package:go_shoppin/screens/orders_screen.dart';
import 'package:go_shoppin/screens/product_details_screen.dart';
import 'package:go_shoppin/screens/products_overview_screen.dart';
import 'package:go_shoppin/screens/user_products_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.ROUTE_NAME: (ctx) => ProductDetailsScreen(),
          OrdersScreen.ROUTE_NAME: (ctx) => OrdersScreen(),
          CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
          UserProductsScreeen.ROUTE_NAME: (ctx) => UserProductsScreeen(),
          EditProductScreen.ROUTE_NAME: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
