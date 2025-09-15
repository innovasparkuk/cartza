import 'package:flutter/material.dart';
import 'pages/category_page.dart';
import 'pages/product_detail_page.dart';
import 'pages/subcategory_page.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cartza',
      theme: ThemeData(
        primaryColor: const Color(0xFFFF6F00), // Orange
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ).copyWith(
          secondary: const Color(0xFF212121), // Dark Gray
        ),
      ),
      home: const CategoryPage(),
      routes: {
        '/productDetail': (context) => const ProductDetailPage(),
        '/subcategory': (context) => const SubcategoryPage(),
      },
    );
  }
}