import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/orders.dart' show Orders;
import 'package:go_shoppin/widgets/app_drawer.dart';
import 'package:go_shoppin/widgets/order_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const ROUTE_NAME = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // var _isInit = false;
  // var _isLoading = false;

  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   await Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });

    // _isLoading = true;
    // Provider.of<Orders>(context, listen: false).fetchAndSetOrders().then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center();
              } else {
                return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                          itemCount: ordersProvider.orders.length,
                          itemBuilder: (ctx, index) =>
                              OrderItem(ordersProvider.orders[index]),
                        ));
              }
            }
          },
        ));
  }
}
