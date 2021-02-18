import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/orders.dart' show Orders;
import 'package:go_shoppin/widgets/app_drawer.dart';
import 'package:go_shoppin/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const ROUTE_NAME = '/orders';
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: ordersProvider.orders.length,
        itemBuilder: (ctx, index) => OrderItem(ordersProvider.orders[index]),
      ),
    );
  }
}
