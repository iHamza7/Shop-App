// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badges.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavoriteOnly = false;
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        _showFavoriteOnly ? productsData.favoriteItems : productsData.items;
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.Favorite,
                child: Text(
                  'Only Favories',
                ),
              ),
              const PopupMenuItem(
                value: FilterOptions.All,
                child: Text(
                  'Show All',
                ),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
          Badges(
            value: cart.itemCount.toString(),
            color: Colors.deepOrange,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart,
              ),
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: products[index],
          child: const ProductItem(),
        ),
        itemCount: products.length,
      ),
    );
  }
}
