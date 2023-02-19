import 'package:flutter/material.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/detail_screen.dart';

import 'providers/cart.dart';
import 'providers/orders.dart';
import 'screens/cart_screen.dart';
import 'screens/product_overvie_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (contex) => Products(),
        ),
        ChangeNotifierProvider(
          create: (contex) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (contex) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
        ),
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetail.routeName: (context) => const ProductDetail(),
          CartScreen.routeName: (context) => const CartScreen(),
        },
      ),
    );
  }
}
