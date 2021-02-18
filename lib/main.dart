import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/cart.dart';
import 'package:go_shoppin/providers/products.dart';
import 'package:go_shoppin/screens/product_details_screen.dart';
import 'package:go_shoppin/screens/products_overview_screen.dart';
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
        },
      ),
    );
  }
}
