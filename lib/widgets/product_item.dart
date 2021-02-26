import 'package:flutter/material.dart';
import 'package:go_shoppin/providers/auth.dart';
import 'package:go_shoppin/providers/cart.dart';
import 'package:go_shoppin/providers/product.dart';
import 'package:go_shoppin/screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // Using Consumer instead of Provider.of(context) the whole build method won't re-run when something change.
    // For running only a sub-part of a widget tree that also can be done.
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailsScreen.ROUTE_NAME,
                arguments: product.id);
          },
          child: FadeInImage(
            placeholder: AssetImage('./assets/images/product-placeholder.png'),
            image: NetworkImage(
              product.imageUrl,
            ),
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            color: Theme.of(context).accentColor,
            // Only the icon is built when product changes
            icon: Consumer<Product>(
              // child is the reference to the comsumer widget's child
              builder: (ctx, product, child) => Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
            ),
            onPressed: () {
              product.toggleFavoriteStatus(auth.token, auth.userId);
            },
          ),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart_sharp),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                product.id,
                product.price,
                product.title,
              );
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Added item to cart!',
                ),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                ),
              ));
            },
          ),
          backgroundColor: Colors.black87,
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
