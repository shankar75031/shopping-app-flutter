import 'package:flutter/material.dart';
import 'package:go_shoppin/helpers/custom_route.dart';
import 'package:go_shoppin/providers/auth.dart';
import 'package:go_shoppin/providers/cart.dart';
import 'package:go_shoppin/providers/orders.dart';
import 'package:go_shoppin/providers/products.dart';
import 'package:go_shoppin/screens/auth_screen.dart';
import 'package:go_shoppin/screens/cart_screen.dart';
import 'package:go_shoppin/screens/edit_product_screen.dart';
import 'package:go_shoppin/screens/orders_screen.dart';
import 'package:go_shoppin/screens/product_details_screen.dart';
import 'package:go_shoppin/screens/products_overview_screen.dart';
import 'package:go_shoppin/screens/splash_screen.dart.dart';
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
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, products) =>
              products..update(auth.token, auth.userId),
        ),
        ChangeNotifierProxyProvider<Auth, Cart>(
          create: (_) => Cart(),
          update: (_, auth, cart) => cart..update(auth.token),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, orders) => orders..update(auth.token, auth.userId),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          title: '',
          theme: ThemeData(
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            }),
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) => authResultSnapshot
                              .connectionState ==
                          ConnectionState.waiting
                      ? SplashScreen()
                      // No need to check for authDataSnapshot data is true or false because the widget will reload on auth change
                      : AuthScreen(),
                ),
          routes: {
            ProductDetailsScreen.ROUTE_NAME: (ctx) => ProductDetailsScreen(),
            OrdersScreen.ROUTE_NAME: (ctx) => OrdersScreen(),
            AuthScreen.ROUTE_NAME: (ctx) => AuthScreen(),
            CartScreen.ROUTE_NAME: (ctx) => CartScreen(),
            UserProductsScreeen.ROUTE_NAME: (ctx) => UserProductsScreeen(),
            EditProductScreen.ROUTE_NAME: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
