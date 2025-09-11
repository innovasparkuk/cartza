import 'package:flutter/material.dart';
import '../data/sample_data.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/cart_drawer.dart';
import '../models/cart_item.dart';
import '../data/cart_data.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _selectedFilter = '';
  final List<String> filters = ['Popular', 'New Arrivals', 'Budget Picks', 'Flash Deals', 'Gift Ideas'];
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredCategories = [];
  List<CartItem> cart = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _applyFilters(searchQuery: _searchController.text.toLowerCase());
  }

  void _applyFilters({String searchQuery = ''}) {
    setState(() {
      filteredCategories = categories.where((category) {
        final nameMatch = category['name'].toLowerCase().contains(searchQuery);
        final subcategoryMatch = (category['subcategories'] as List).any((subcat) =>
            subcat['name'].toString().toLowerCase().contains(searchQuery));
        final tagMatch = _selectedFilter.isEmpty ||
            (category['tags'] != null && (category['tags'] as List).contains(_selectedFilter));
        return (nameMatch || subcategoryMatch) && tagMatch;
      }).toList();
    });
  }

  void _addToCart(String name, String image, double price) {
    setState(() {
      final existing = cart.firstWhere(
            (item) => item.name == name,
        orElse: () => CartItem(name: '', image: '', price: 0),
      );
      if (existing.name.isNotEmpty) {
        existing.quantity += 1;
      } else {
        cart.add(CartItem(name: name, image: image, price: price));
      }
    });
  }

  void _openCartDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CartDrawer(cart: cart, onUpdate: () => setState(() {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(categories: categories),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(8)),
          child: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search categories or products',
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Color(0xFF4CAF50)),
                onPressed: _openCartDrawer,
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
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: ChoiceChip(
                    label: Text(filter, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                    selected: isSelected,
                    selectedColor: const Color(0xFF4CAF50),
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = isSelected ? '' : filter;
                        _applyFilters(searchQuery: _searchController.text.toLowerCase());
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: filteredCategories.length,
              itemBuilder: (context, index) {
                final category = filteredCategories[index];
                final subcategories = category['subcategories'] as List<dynamic>;
                double lowestPrice = double.infinity;

                for (var subcat in subcategories) {
                  final price = (subcat['price'] as num).toDouble();
                  if (price < lowestPrice) lowestPrice = price;
                }
                if (lowestPrice == double.infinity) lowestPrice = 0;

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/subcategory', arguments: category);
                  },
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image.asset(
                              category['image'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                category['name'],
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "From Rs ${lowestPrice.toStringAsFixed(0)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4CAF50),
                                        fontSize: 14,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF6F00),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      '${subcategories.length} items',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
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
