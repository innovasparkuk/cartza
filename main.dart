import 'package:flutter/material.dart';
import 'login_page.dart';
import 'category_page.dart';
import 'product_listing.dart';
import 'subcategory_page.dart';
import 'productdetailpage.dart';
void main() {
  runApp(const CartzaApp());
}

class CartzaApp extends StatelessWidget {
  const CartzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cartza",
      theme: ThemeData(
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          primary: const Color(0xFF4CAF50),
          secondary: const Color(0xFFFF6F00),
        ),
      ),
      home: const ProductListingPage(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const CategoryPage(),
      //   '/subcategory': (context) => const SubcategoryPage(),
      //   '/productListing': (context) => const ProductListingPage(),
      // },
      onGenerateRoute: (settings) {
        // ── Product Detail ──────────────────────────────────────────────────
        if (settings.name == '/productDetail') {
          final args = settings.arguments;

          // Convert ProductListing → Product1
          if (args is ProductListing) {
            final product = Product1(
              id: args.id,
              name: args.name,
              brand: 'Cartza',           // default brand
              price: args.price,
              originalPrice: args.originalPrice,
              discountPercentage: args.discountPercent,
              description:
              'Premium quality ${args.name}. '
                  'Crafted with care and built to last. '
                  'Enjoy comfort, style and performance in one package. '
                  'Perfect for everyday use and special occasions alike.',
              images: [args.image],      // single image wrapped in list
              rating: args.rating,
              reviewCount: args.reviewCount,
              specifications: {
                'Category':  args.badge.isNotEmpty ? args.badge : 'General',
                'In Stock':  args.inStock ? 'Yes' : 'No',
                'Delivery':  args.freeDelivery ? 'Free Delivery' : 'Standard',
                'Rating':    '${args.rating} / 5.0',
                'Sold':      '${args.sold}+ units',
                'Price':     'Rs ${args.price.toStringAsFixed(0)}',
              },
            );
            return MaterialPageRoute(
              builder: (_) => ModernProductDetailPage(product: product),
              settings: settings,
            );
          }

          // Already a Product1 (navigated from elsewhere)
          if (args is Product1) {
            return MaterialPageRoute(
              builder: (_) => ModernProductDetailPage(product: args),
              settings: settings,
            );
          }
        }
        return null; // let Flutter handle unknown routes
      },
    );
  }
}

// ─── Role tabs (login) ────────────────────────────────────────────────────────
class RoleTabs extends StatelessWidget {
  const RoleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: const Color(0xFF4CAF50),
            title: const Text('Cartza Login',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              indicatorWeight: 3,
              tabs: [Tab(text: 'User'), Tab(text: 'Seller')],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            AuthForm(role: 'User'),
            AuthForm(role: 'Seller'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('User Home',
            style: TextStyle(color: Colors.black87)),
        elevation: 0,
      ),
      body: const Center(
          child: Text('Welcome User!', style: TextStyle(fontSize: 18))),
    );
  }
}

class SellerPage extends StatelessWidget {
  const SellerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Seller Dashboard',
            style: TextStyle(color: Colors.black87)),
        elevation: 0,
      ),
      body: const Center(
          child: Text('Welcome Seller!', style: TextStyle(fontSize: 18))),
    );
  }
}