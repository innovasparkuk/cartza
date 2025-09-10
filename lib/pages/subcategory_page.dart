import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/cart_drawer.dart';
import '../models/cart_item.dart';
import 'package:card_swiper/card_swiper.dart';

class SubcategoryPage extends StatefulWidget {
  const SubcategoryPage({super.key});

  @override
  State<SubcategoryPage> createState() => _SubcategoryPageState();
}

// 🛒 Cart state (local for this page)
List<Map<String, dynamic>> cart = [];

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
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          expand: false,
          builder: (_, controller) {
            return StatefulBuilder(
              builder: (context, setSheetState) {
                return CartDrawer(
                  cart: cart
                      .map((item) => CartItem(
                    name: item['name'],
                    image: item['image'],
                    price: item['price'].toDouble(),
                    quantity: item['quantity'],
                  ))
                      .toList(),
                  onUpdate: () {
                    setState(() {}); // refresh main page
                    setSheetState(() {}); // refresh bottom sheet
                  },
                );
              },
            );
          },
        );
      },
    );
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
              if (cart.isNotEmpty)
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
                      '${cart.length}',
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
              itemCount: 1 + (subcategories.length > 2 ? 2 : subcategories.length),
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
                  return _buildBannerCard(subcat['image'], subcat['name']);
                }
              },
            ),
          ),

          // 🛍️ Subcategory Grid
          Expanded(

            child: GridView.builder(
              padding:  EdgeInsets.all(12),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
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
                    Navigator.pushNamed(context, '/productDetail',
                        arguments: subcategory);
                  },

                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final screenHeight = MediaQuery.of(context).size.height;
                        final cardHeight = screenHeight * 0.45; // Responsive height

                        return SizedBox(
                          height: cardHeight,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    topRight: Radius.circular(8),
                                  ),
                                  child: SizedBox(
                                    height: cardHeight * 0.30,
                                    width: double.infinity,
                                    child: Image.asset(
                                      subcategory['image'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subcategory['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Rs ${subcategory['price']}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF4CAF50),
                                                fontSize: 14,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFF6F00),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Stock: ${subcategory['stock']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: subcategory['stock'] > 0
                                              ? () {
                                            setState(() {
                                              final existing = cart.indexWhere(
                                                    (item) => item['name'] == subcategory['name'],
                                              );
                                              if (existing != -1) {
                                                cart[existing]['quantity'] += 1;
                                              } else {
                                                cart.add({
                                                  'name': subcategory['name'],
                                                  'image': subcategory['image'],
                                                  'price': subcategory['price'],
                                                  'quantity': 1,
                                                });
                                              }
                                            });
                                          }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF4CAF50),
                                            minimumSize: const Size(90, 35),
                                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(19),
                                            ),
                                          ),
                                          child: const FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              'Add to Cart',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
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
                    )


                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
