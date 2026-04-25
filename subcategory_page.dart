
// subcategory_page.dart
import 'package:flutter/material.dart';
import 'sample_data.dart';
import 'drawer_menu.dart';
import 'cart_item.dart';
import 'cart_drawer.dart';
import 'cart_data.dart';
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
  bool _initialized = false;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      category =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      subcategories =
      List<Map<String, dynamic>>.from(category['subcategories']);
      filteredSubcategories = List.from(subcategories);
      _searchController.addListener(_onSearchChanged);
      _initialized = true;
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredSubcategories = subcategories.where((subcat) {
        return subcat['name'].toLowerCase().contains(query) ||
            category['name'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => CartDrawer(
          cart: globalCart,
          onUpdate: () {
            setState(() {});
            setSheetState(() {});
          },
        ),
      ),
    );
  }

  int get _cartQuantity =>
      globalCart.fold<int>(0, (sum, item) => sum + item.quantity);

  Widget _buildBannerCard(String imagePath, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.image, size: 50, color: Colors.grey),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.55), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            left: 14,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                shadows: [Shadow(color: Colors.black, blurRadius: 6)],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive grid
    int crossAxisCount = 2;
    double childAspectRatio = 0.75;
    if (screenWidth >= 1100) {
      crossAxisCount = 5;
      childAspectRatio = 0.80;
    } else if (screenWidth >= 900) {
      crossAxisCount = 4;
      childAspectRatio = 0.80;
    } else if (screenWidth >= 600) {
      crossAxisCount = 3;
      childAspectRatio = 0.78;
    }

    final double hPad = screenWidth >= 900 ? 24 : 12;
    final int swiperCount =
        1 + (subcategories.length > 2 ? 2 : subcategories.length);

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
              hintText: 'Search in ${category['name']}...',
              hintStyle:
              TextStyle(color: Colors.grey.shade400, fontSize: 13),
              prefixIcon:
              Icon(Icons.search, color: Colors.grey.shade400, size: 20),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _searchController.clear();
                  _onSearchChanged();
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
                    onPressed: _openCart,
                  ),
                ),
                if (globalCart.isNotEmpty)
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
                        '$_cartQuantity',
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

      // ─── Body: CustomScrollView ───
      body: CustomScrollView(
        slivers: [

          // ── Category Hero Banner (scroll ke saath) ──
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth >= 600 ? 28 : 20,
                          vertical: 16),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth >= 600 ? 80 : 70,
                            height: screenWidth >= 600 ? 80 : 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                category['image'],
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => const Icon(
                                    Icons.category,
                                    color: Colors.white,
                                    size: 30),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category['name'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth >= 600 ? 20 : 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${subcategories.length} products available',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 6,
                                  children: [
                                    _heroBadge('Free Delivery'),
                                    _heroBadge('Easy Returns'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Swiper Banner (scroll ke saath) ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: screenWidth >= 600 ? 200 : 160,
                child: Swiper(
                  itemCount: swiperCount,
                  autoplay: true,
                  viewportFraction: 0.88,
                  scale: 0.95,
                  pagination: const SwiperPagination(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _buildBannerCard(
                          category['image'], category['name']);
                    } else {
                      final subcat = subcategories[index - 1];
                      return GestureDetector(
                        onTap: () => Navigator.pushNamed(
                            context, '/productListing',
                            arguments: subcat),
                        child: _buildBannerCard(
                            subcat['image'], subcat['name']),
                      );
                    }
                  },
                ),
              ),
            ),
          ),

          // ── Section Header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 8),
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
                    filteredSubcategories.isEmpty
                        ? 'No results found'
                        : '${category['name']} (${filteredSubcategories.length})',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Subcategory Grid ya Empty State ──
          filteredSubcategories.isEmpty
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
                  final subcat = filteredSubcategories[index];
                  final gradient =
                  cardGradients[index % cardGradients.length];
                  final bool inStock = (subcat['stock'] ?? 1) > 0;

                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, '/productListing',
                        arguments: subcat),
                    child: _buildSubcategoryCard(
                        subcat, gradient, inStock),
                  );
                },
                childCount: filteredSubcategories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubcategoryCard(
      Map<String, dynamic> subcat,
      List<Color> gradient,
      bool inStock) {
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
                    subcat['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Center(
                      child: Icon(Icons.image_outlined,
                          size: 40, color: Colors.grey.shade400),
                    ),
                  ),
                  if (!inStock)
                    Container(
                      color: Colors.black.withOpacity(0.45),
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.shade700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'OUT OF STOCK',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subcat['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: Color(0xFF1A1A2E),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Rs ${subcat['price']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E7D32),
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: inStock
                          ? () {
                        setState(() {
                          final existing = globalCart.indexWhere(
                                  (item) => item.name == subcat['name']);
                          if (existing != -1) {
                            globalCart[existing].quantity++;
                          } else {
                            globalCart.add(CartItem(
                              name: subcat['name'],
                              image: subcat['image'],
                              price:
                              (subcat['price'] as num).toDouble(),
                              quantity: 1,
                            ));
                          }
                        });
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.zero,
                        elevation: 0,
                      ),
                      child: Text(
                        inStock ? 'Add to Cart' : 'Unavailable',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color:
                          inStock ? Colors.white : Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
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
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
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
          Text('No products found',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey.shade500)),
          const SizedBox(height: 8),
          Text('Try a different search',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}

