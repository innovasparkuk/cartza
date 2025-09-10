import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../data/cart_data.dart';
import '../models/cart_item.dart';
import '../widgets/cart_drawer.dart';
import '../widgets/drawer_menu.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> relatedProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Map<String, dynamic> product =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      for (var name in product['related']) {
        for (var cat in categories) {
          for (var sub in cat['subcategories']) {
            if (sub['name'] == name) {
              relatedProducts.add(sub);
            }
          }
        }
      }

      setState(() {
        filteredProducts = List.from(relatedProducts);
      });
    });

    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredProducts = relatedProducts.where((product) {
        final name = product['name'].toLowerCase();
        return name.contains(query);
      }).toList();
    });
  }

  void _showCartDrawer() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => CartDrawer(
        cart: globalCart,
        onUpdate: () => setState(() {}),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> product =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        drawer: DrawerMenu(categories: categories),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.black),
              onPressed: () => Scaffold.of(context).openDrawer(),
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
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFF4CAF50), width: 2),
                ),
              ),
            ),
          ),
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.black),
                  onPressed: _showCartDrawer,
                ),
                if (getCartCount() > 0)
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
                        '${getCartCount()}',
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (value) {
                if (value == 'home') {
                  Navigator.pushNamed(context, '/');
                } else if (value == 'help') {
                  Navigator.pushNamed(context, '/help');
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'home', child: Text('Home')),
                PopupMenuItem(value: 'search', child: Text('Search')),
                PopupMenuItem(value: 'help', child: Text('Help')),
              ],
            ),
          ],
        ),
        body: Stack(
            children: [
        SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Image.asset(
        product['image'],
          height: 350,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Rs ${product['price']}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star, color: Colors.orange, size: 20),
                  Icon(Icons.star_half, color: Colors.orange, size: 20),
                  Icon(Icons.star_border, color: Colors.orange, size: 20),
                ],
              ),
              const SizedBox(width: 16),
              Text("${product['stock']} sold"),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text("Easy return in 10 days"),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Description", style: Theme.of(context).textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(product['description']),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text("Related Products", style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(height: 8),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final item = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/productDetail', arguments: item);
                    },
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: Column(
                          children: [
                      ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Image.asset(
                        item['image'],
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
                  item['name'],
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(
                  "Rs ${item['price']}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                  Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                  "Stock: ${item['stock']}",
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  ),
                  ],
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
        ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            addToCart(CartItem(
                              name: product['name'],
                              image: product['image'],
                              price: product['price'].toDouble(),
                              quantity: 1,
                            ));
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/checkout');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Order Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/chat');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.chat_bubble_outline, color: Colors.black, size: 22),
                            SizedBox(height: 4),
                            Text("Chat", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/store');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.storefront, color: Colors.black, size: 22),
                            SizedBox(height: 4),
                            Text("Store", style: TextStyle(fontSize: 12)),

                          ],

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
        ),
    );
  }
}
