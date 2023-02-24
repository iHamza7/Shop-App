import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/products_provider.dart';

class UserProduct extends StatelessWidget {
  const UserProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_ , i) => ,
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
