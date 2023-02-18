import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final int quantity;
  final double price;
  const CartItem(this.id, this.title, this.quantity, this.price, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              child: Text('\$$price'),
            ),
          ),
          title: Text(title),
          subtitle: Text('total \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
