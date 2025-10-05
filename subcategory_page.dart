import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/drawer_menu.dart';
import '../models/cart_item.dart';
import '../widgets/cart_drawer.dart'; // ✅ use shared drawer
import '../data/cart_data.dart'; // ✅ use globalCart
import 'package:card_swiper/card_swiper.dart';

class SubcategoryPage extends StatefulWidget {
  const SubcategoryPage({super.key});

  @override
  State<SubcategoryPage> createState() => _SubcategoryPageState();
}

class _SubcategoryPageState extends State<SubcategoryPage> {
  final TextEditingController _searchController = TextEditingController();
  late Map<String, dynamic> category;
  late List<Map<String, dynamic>> subcategories;
  late List<Map<String, dynamic>> filteredSubcategories;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    category =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    subcategories = List<Map<String, dynamic>>.from(category['subcategories']);
    filteredSubcategories = List.from(subcategories);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredSubcategories = subcategories.where((subcat) {
        final nameMatch = subcat['name'].toLowerCase().contains(query);
        final categoryMatch = category['name'].toLowerCase().contains(query);
        return nameMatch || categoryMatch;
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // 🖼️ Banner card builder
  Widget _buildBannerCard(String imagePath, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [Shadow(color: Colors.black, blurRadius: 4)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return CartDrawer(
              cart: globalCart, // ✅ shared global cart
              onUpdate: () {
                setState(() {}); // refresh main page
                setSheetState(() {}); // refresh cart drawer
              },
            );
          },
        );
      },
    );
  }

  /// ✅ total quantity for badge
  int _cartQuantity() {
    return globalCart.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(categories: categories),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF4CAF50)),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: SizedBox(
          height: 40,
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search categories or products',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: const Icon(Icons.search),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: _openCart,
              ),
              if (globalCart.isNotEmpty)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${_cartQuantity()}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),

          // 🔥 Carousel Section
          SizedBox(
            height: 180,
            child: Swiper(
              itemCount:
              1 + (subcategories.length > 2 ? 2 : subcategories.length),
              autoplay: true,
              viewportFraction: 0.9,
              scale: 0.95,
              pagination: const SwiperPagination(),
              control: const SwiperControl(
                color: Colors.black,
                size: 28,
                iconNext: Icons.arrow_forward_ios,
                iconPrevious: Icons.arrow_back_ios,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildBannerCard(category['image'], category['name']);
                } else {
                  final subcat = subcategories[index - 1];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/productListing',
                        arguments: subcat,
                      );
                    },
                    child: _buildBannerCard(subcat['image'], subcat['name']),
                  );
                }
              },
            ),
          ),

          // 🛍️ Subcategory Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredSubcategories.length,
              itemBuilder: (context, index) {
                final subcategory = filteredSubcategories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/productListing',
                      arguments: subcategory,
                    );
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(8),
                          ),
                          child: SizedBox(
                            height: 100,
                            width: double.infinity,
                            child: Image.asset(
                              subcategory['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(subcategory['name'],
                                  style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              const SizedBox(height: 4),
                              Text("Rs ${subcategory['price']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4CAF50))),
                              const SizedBox(height: 6),
                              Center(
                                child: ElevatedButton(
                                  onPressed: subcategory['stock'] > 0
                                      ? () {
                                    setState(() {
                                      final existing = globalCart.indexWhere(
                                              (item) =>
                                          item.name ==
                                              subcategory['name']);
                                      if (existing != -1) {
                                        globalCart[existing].quantity++;
                                      } else {
                                        globalCart.add(CartItem(
                                          name: subcategory['name'],
                                          image: subcategory['image'],
                                          price: (subcategory['price'] as num)
                                              .toDouble(),
                                          quantity: 1,
                                        ));
                                      }
                                    });
                                  }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4CAF50),
                                  ),
                                  child: const Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
