import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart items'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Items ',
                    style: TextStyle(fontSize: 20),
                  ),
                  Chip(
                    label: Text('\$${totalCart.totalAmount}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    textColor: Theme.of(context).primaryColor,
                    child: const Text(
                      'Order Now',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: totalCart.items.length,
              itemBuilder: (context, index) => CartItem(
                totalCart.items.values.toList()[index].id,
                totalCart.items.values.toList()[index].title,
                totalCart.items.values.toList()[index].quantity,
                totalCart.items.values.toList()[index].price,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
