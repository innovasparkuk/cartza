
// category_page.dart
import 'package:flutter/material.dart';
import 'sample_data.dart';
import 'drawer_menu.dart';
import 'cart_drawer.dart';
import 'cart_item.dart';
import 'cart_data.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String _selectedFilter = '';
  final List<String> filters = [
    'Popular', 'New Arrivals', 'Budget Picks', 'Flash Deals', 'Gift Ideas'
  ];
  final List<String> filterEmojis = ['🔥', '✨', '💰', '⚡', '🎁'];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> filteredCategories = [];
  List<CartItem> cart = [];

  final List<List<Color>> cardGradients = [
    [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
    [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
    [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
    [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
    [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
    [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
    [Color(0xFFFBE9E7), Color(0xFFFFCCBC)],
    [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
  ];

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
        final subcategoryMatch = (category['subcategories'] as List).any(
                (subcat) => subcat['name'].toString().toLowerCase().contains(searchQuery));
        final tagMatch = _selectedFilter.isEmpty ||
            (category['tags'] != null &&
                (category['tags'] as List).contains(_selectedFilter));
        return (nameMatch || subcategoryMatch) && tagMatch;
      }).toList();
    });
  }

  void _openCartDrawer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) =>
          CartDrawer(cart: cart, onUpdate: () => setState(() {})),
    );
  }

  int get _totalCartItems => cart.fold(0, (sum, item) => sum + item.quantity);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive grid columns
    int crossAxisCount = 2;
    double childAspectRatio = 0.78;
    if (screenWidth >= 1100) {
      crossAxisCount = 5;
      childAspectRatio = 0.82;
    } else if (screenWidth >= 900) {
      crossAxisCount = 4;
      childAspectRatio = 0.82;
    } else if (screenWidth >= 600) {
      crossAxisCount = 3;
      childAspectRatio = 0.80;
    }

    // Responsive horizontal padding
    final double hPad = screenWidth >= 900 ? 24 : 12;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      drawer: DrawerMenu(categories: categories),

      // ─── AppBar ───
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        leading: Builder(
          builder: (context) => Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 20),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF4F6F8),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search categories or products...',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              prefixIcon: Icon(Icons.search, color: Colors.grey.shade400, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _applyFilters();
                },
              )
                  : null,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 11),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.shopping_cart,
                        color: Colors.white, size: 20),
                    onPressed: _openCartDrawer,
                  ),
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 2,
                    top: 2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF6F00),
                        shape: BoxShape.circle,
                      ),
                      constraints:
                      const BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        '$_totalCartItems',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),

      // ─── Body: CustomScrollView (saara content scroll karta hai) ───
      body: CustomScrollView(
        slivers: [

          // ── Hero Banner (scroll ke saath jaata hai) ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 0),
              child: Container(
                height: screenWidth >= 600 ? 130 : 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1B5E20),
                      Color(0xFF2E7D32),
                      Color(0xFFFF6F00)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2E7D32).withOpacity(0.35),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      bottom: -40,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFFF6F00).withOpacity(0.15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth >= 600 ? 28 : 20,
                          vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Shop Smarter ✨',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth >= 600 ? 22 : 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Thousands of products at your fingertips',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: [
                              _heroBadge('Free Delivery'),
                              _heroBadge('Easy Returns'),
                              _heroBadge('Secure Pay'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Filter Chips ──
          SliverToBoxAdapter(
            child: SizedBox(
              height: 52,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 8),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(
                        '${filterEmojis[index]} $filter',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey.shade700,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: const Color(0xFF2E7D32),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF2E7D32)
                              : Colors.grey.shade200,
                        ),
                      ),
                      elevation: isSelected ? 3 : 1,
                      onSelected: (_) {
                        setState(() {
                          _selectedFilter = isSelected ? '' : filter;
                          _applyFilters(
                              searchQuery: _searchController.text.toLowerCase());
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ),

          // ── Section Header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(hPad, 4, hPad, 8),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    filteredCategories.isEmpty
                        ? 'No results found'
                        : 'Shop by Category (${filteredCategories.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilter = '';
                        _searchController.clear();
                        filteredCategories = List.from(categories);
                      });
                    },
                    child: const Text(
                      'View All →',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // ── Category Grid ya Empty State ──
          filteredCategories.isEmpty
              ? SliverFillRemaining(child: _buildEmptyState())
              : SliverPadding(
            padding:
            EdgeInsets.fromLTRB(hPad, 0, hPad, 24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final category = filteredCategories[index];
                  final subcategories =
                  category['subcategories'] as List<dynamic>;

                  double lowestPrice = double.infinity;
                  for (var subcat in subcategories) {
                    final price = (subcat['price'] as num).toDouble();
                    if (price < lowestPrice) lowestPrice = price;
                  }
                  if (lowestPrice == double.infinity) lowestPrice = 0;

                  final tags = category['tags'] as List? ?? [];
                  String badgeLabel = '';
                  Color badgeColor = const Color(0xFFFF6F00);
                  if (tags.contains('Popular')) {
                    badgeLabel = 'HOT';
                    badgeColor = const Color(0xFFE53935);
                  } else if (tags.contains('New Arrivals')) {
                    badgeLabel = 'NEW';
                    badgeColor = const Color(0xFF4CAF50);
                  } else if (tags.contains('Flash Deals')) {
                    badgeLabel = 'SALE';
                    badgeColor = const Color(0xFFFF6F00);
                  } else if (tags.contains('Gift Ideas')) {
                    badgeLabel = 'GIFT';
                    badgeColor = const Color(0xFF8E24AA);
                  }

                  final gradient =
                  cardGradients[index % cardGradients.length];

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/subcategory',
                          arguments: category);
                    },
                    child: _buildCategoryCard(
                      category: category,
                      subcategories: subcategories,
                      lowestPrice: lowestPrice,
                      badgeLabel: badgeLabel,
                      badgeColor: badgeColor,
                      gradient: gradient,
                    ),
                  );
                },
                childCount: filteredCategories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard({
    required Map<String, dynamic> category,
    required List<dynamic> subcategories,
    required double lowestPrice,
    required String badgeLabel,
    required Color badgeColor,
    required List<Color> gradient,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Image.asset(
                    category['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(Icons.image_outlined,
                          size: 40, color: Colors.grey.shade400),
                    ),
                  ),
                  if (badgeLabel.isNotEmpty)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: badgeColor.withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Text(
                          badgeLabel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'From Rs ${lowestPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color:
                              const Color(0xFFFF6F00).withOpacity(0.3)),
                        ),
                        child: Text(
                          '${subcategories.length} items',
                          style: const TextStyle(
                            color: Color(0xFFFF6F00),
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heroBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded,
              size: 70, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No categories found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try a different search or filter',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedFilter = '';
                _searchController.clear();
                filteredCategories = List.from(categories);
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 11),
            ),
            child: const Text('Clear Filters',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

