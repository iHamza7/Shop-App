import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productID = ModalRoute.of(context)!.settings.arguments as String;
    Provider.of<Products>(context)
        .items
        .firstWhere((prod) => prod.id == productID);

    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
    );
  }
}
