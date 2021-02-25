import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/products.dart';
import 'package:go_shoppin/screens/edit_product_screen.dart';
import 'package:go_shoppin/widgets/app_drawer.dart';
import 'package:go_shoppin/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProductsScreeen extends StatelessWidget {
  static const ROUTE_NAME = '/user/products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.ROUTE_NAME);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, products, child) => Padding(
                        padding: EdgeInsets.all(8),
                        child: ListView.builder(
                          itemCount: products.items.length,
                          itemBuilder: (ctx, index) => Column(
                            children: [
                              UserProductItem(
                                products.items[index].title,
                                products.items[index].imageUrl,
                                products.items[index].id,
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
