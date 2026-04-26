import 'package:flutter/material.dart';
import 'cart_item.dart';
import 'cart_data.dart';
import 'cart_drawer.dart';
import 'productdetailpage.dart';

// ─── Product model ────────────────────────────────────────────────────────────
class ProductListing {
  final String id;
  final String name;
  final String image;
  final double price;
  final double? originalPrice;
  final double rating;
  final int reviewCount;
  final int sold;
  final String badge;
  final bool inStock;
  final bool freeDelivery;

  const ProductListing({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.originalPrice,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.sold = 0,
    this.badge = '',
    this.inStock = true,
    this.freeDelivery = false,
  });

  int? get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return null;
    return (((originalPrice! - price) / originalPrice!) * 100).round();
  }
}

enum _Sort { recommended, priceLow, priceHigh, rating, newest }

extension _SortLabel on _Sort {
  String get label {
    switch (this) {
      case _Sort.recommended:
        return 'Recommended';
      case _Sort.priceLow:
        return 'Price: Low to High';
      case _Sort.priceHigh:
        return 'Price: High to Low';
      case _Sort.rating:
        return 'Top Rated';
      case _Sort.newest:
        return 'Newest First';
    }
  }

  IconData get icon {
    switch (this) {
      case _Sort.recommended:
        return Icons.auto_awesome_rounded;
      case _Sort.priceLow:
        return Icons.trending_down_rounded;
      case _Sort.priceHigh:
        return Icons.trending_up_rounded;
      case _Sort.rating:
        return Icons.star_rounded;
      case _Sort.newest:
        return Icons.fiber_new_rounded;
    }
  }
}

final List<ProductListing> _sampleProducts = [
  ProductListing(
    id: '1',
    name: 'Running Sneakers',
    image: 'assets/images/shoes.png',
    price: 4999,
    originalPrice: 6999,
    rating: 4.7,
    reviewCount: 243,
    sold: 1200,
    badge: 'HOT',
    inStock: true,
    freeDelivery: true,
  ),
  ProductListing(
    id: '2',
    name: 'Travel Backpack',
    image: 'assets/images/bag.jpeg',
    price: 2999,
    originalPrice: 3999,
    rating: 4.5,
    reviewCount: 180,
    sold: 890,
    badge: 'NEW',
    inStock: true,
    freeDelivery: false,
  ),
  ProductListing(
    id: '3',
    name: 'Smart Watch Pro',
    image: 'assets/images/watch.jpeg',
    price: 9999,
    originalPrice: 14999,
    rating: 4.8,
    reviewCount: 512,
    sold: 3400,
    badge: 'SALE',
    inStock: true,
    freeDelivery: true,
  ),
  ProductListing(
    id: '4',
    name: 'Wireless Headphones',
    image: 'assets/images/bag.jpeg',
    price: 5999,
    originalPrice: 7999,
    rating: 4.6,
    reviewCount: 98,
    sold: 670,
    badge: '',
    inStock: true,
    freeDelivery: true,
  ),
  ProductListing(
    id: '5',
    name: 'Sport Sneakers',
    image: 'assets/images/shoes.png',
    price: 3999,
    rating: 4.3,
    reviewCount: 64,
    sold: 200,
    badge: '',
    inStock: false,
    freeDelivery: false,
  ),
  ProductListing(
    id: '6',
    name: 'Smartphone X12',
    image: 'assets/images/phones.jpeg',
    price: 59999,
    originalPrice: 69999,
    rating: 4.9,
    reviewCount: 1024,
    sold: 7800,
    badge: 'HOT',
    inStock: true,
    freeDelivery: true,
  ),
  ProductListing(
    id: '7',
    name: 'Leather Backpack',
    image: 'assets/images/bag.jpeg',
    price: 4499,
    rating: 4.4,
    reviewCount: 77,
    sold: 310,
    badge: 'NEW',
    inStock: true,
    freeDelivery: false,
  ),
  ProductListing(
    id: '8',
    name: 'Digital Watch',
    image: 'assets/images/watch.jpeg',
    price: 1999,
    originalPrice: 2999,
    rating: 4.2,
    reviewCount: 55,
    sold: 440,
    badge: 'SALE',
    inStock: true,
    freeDelivery: false,
  ),
];

const Map<String, Color> _badgeColor = {
  'HOT': Color(0xFFE53935),
  'NEW': Color(0xFF2E7D32),
  'SALE': Color(0xFFFF6F00),
};

const List<List<Color>> _gradients = [
  [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
  [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
  [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
  [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
  [Color(0xFFF3E5F5), Color(0xFFE1BEE7)],
  [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
  [Color(0xFFFBE9E7), Color(0xFFFFCCBC)],
  [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
];

const List<String> _filterChips = [
  'In Stock',
  'On Sale',
  'Top Rated',
  'Free Delivery',
  'Under Rs 3000',
];

// ═════════════════════════════════════════════════════════════════════════════
class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  bool _isGrid = true;
  _Sort _sort = _Sort.recommended;
  final Set<String> _activeFilters = {};
  final Set<String> _wishlist = {};
  late List<ProductListing> _products;
  late List<ProductListing> _filtered;
  final TextEditingController _search = TextEditingController();

  static const double _kWide = 900;
  static const double _kMid = 600;
  static const double _kNarrow = 400;

  int _gridCols(double w) {
    if (w >= 1200) return 5;
    if (w >= 900) return 4;
    if (w >= 600) return 3;
    if (w >= 400) return 2;
    return 2;
  }

  double _gridRatio(double w) {
    if (w >= 900) return 0.64;
    if (w >= 600) return 0.66;
    if (w >= 400) return 0.68;
    return 0.72;
  }

  double _hPad(double w) {
    if (w >= 900) return 24;
    if (w >= 600) return 16;
    return 10;
  }

  int get _cartCount => globalCart.fold(0, (s, i) => s + i.quantity);

  void _addToCart(ProductListing p) {
    setState(() {
      addToCart(CartItem(name: p.name, image: p.image, price: p.price));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${p.name} added to cart!'),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => CartDrawer(
          cart: globalCart,
          onUpdate: () {
            setS(() {});
            setState(() {});
          },
        ),
      ),
    );
  }

  void _navigateToDetail(ProductListing p) {
    final product = Product1(
      id: p.id,
      name: p.name,
      brand: 'Cartza',
      price: p.price,
      originalPrice: p.originalPrice,
      discountPercentage: p.discountPercent,
      description:
      'Premium quality ${p.name}. Crafted with care and built to last. '
          'Enjoy comfort, style and performance in one package. '
          'Perfect for everyday use and special occasions alike.',
      images: [p.image],
      rating: p.rating,
      reviewCount: p.reviewCount,
      specifications: {
        'Category': p.badge.isNotEmpty ? p.badge : 'General',
        'In Stock': p.inStock ? 'Yes' : 'No',
        'Delivery': p.freeDelivery ? 'Free Delivery' : 'Standard',
        'Rating': '${p.rating} / 5.0',
        'Sold': '${p.sold}+ units',
        'Price': 'Rs ${p.price.toStringAsFixed(0)}',
      },
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ModernProductDetailPage(
          product: product,
          onAddToCart: (prod) {
            setState(() {
              addToCart(
                CartItem(
                  name: prod.name,
                  image: prod.images.first,
                  price: prod.price,
                ),
              );
            });
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _products = List.from(_sampleProducts);
    _filtered = List.from(_products);
    _search.addListener(_apply);
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _apply() {
    final q = _search.text.toLowerCase().trim();
    List<ProductListing> r = _products.where((p) {
      if (q.isNotEmpty && !p.name.toLowerCase().contains(q)) return false;
      if (_activeFilters.contains('In Stock') && !p.inStock) return false;
      if (_activeFilters.contains('On Sale') && p.originalPrice == null)
        return false;
      if (_activeFilters.contains('Top Rated') && p.rating < 4.5) return false;
      if (_activeFilters.contains('Free Delivery') && !p.freeDelivery)
        return false;
      if (_activeFilters.contains('Under Rs 3000') && p.price >= 3000)
        return false;
      return true;
    }).toList();
    switch (_sort) {
      case _Sort.priceLow:
        r.sort((a, b) => a.price.compareTo(b.price));
        break;
      case _Sort.priceHigh:
        r.sort((a, b) => b.price.compareTo(a.price));
        break;
      case _Sort.rating:
        r.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case _Sort.newest:
        r = r.reversed.toList();
        break;
      default:
        break;
    }
    setState(() => _filtered = r);
  }

  void _showSort() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Text(
                'Sort By',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(ctx).size.height * 0.5,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _Sort.values.map((opt) {
                      final sel = _sort == opt;
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setState(() => _sort = opt);
                            _apply();
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            margin: const EdgeInsets.only(bottom: 4),
                            decoration: BoxDecoration(
                              color: sel
                                  ? const Color(0xFF2E7D32).withOpacity(0.07)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: sel
                                    ? const Color(0xFF2E7D32).withOpacity(0.3)
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  opt.icon,
                                  size: 18,
                                  color: sel
                                      ? const Color(0xFF2E7D32)
                                      : Colors.grey.shade500,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    opt.label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: sel
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: sel
                                          ? const Color(0xFF2E7D32)
                                          : const Color(0xFF1A1A2E),
                                    ),
                                  ),
                                ),
                                if (sel)
                                  const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: Color(0xFF2E7D32),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            8,
            20,
            MediaQuery.of(ctx).viewInsets.bottom + 32,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  if (_activeFilters.isNotEmpty)
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          setS(() => _activeFilters.clear());
                          _apply();
                        },
                        child: const Text(
                          'Clear All',
                          style: TextStyle(
                            color: Color(0xFFFF6F00),
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _filterChips.map((chip) {
                  final sel = _activeFilters.contains(chip);
                  return MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: FilterChip(
                      label: Text(
                        chip,
                        style: TextStyle(
                          color: sel ? Colors.white : const Color(0xFF1A1A2E),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      selected: sel,
                      selectedColor: const Color(0xFF2E7D32),
                      backgroundColor: Colors.white,
                      checkmarkColor: Colors.white,
                      showCheckmark: true,
                      side: BorderSide(
                        color: sel
                            ? const Color(0xFF2E7D32)
                            : Colors.grey.shade300,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onSelected: (v) => setS(() {
                        if (v) {
                          _activeFilters.add(chip);
                        } else {
                          _activeFilters.remove(chip);
                        }
                      }),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: ElevatedButton(
                    onPressed: () {
                      _apply();
                      Navigator.pop(ctx);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Apply${_activeFilters.isNotEmpty ? '  ·  ${_activeFilters.length} Active' : ''}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = constraints.maxWidth;
        final cols = _gridCols(w);
        final ratio = _gridRatio(w);
        final hPad = _hPad(w);
        final isNarrow = w < _kNarrow;

        return Scaffold(
          backgroundColor: const Color(0xFFF4F6F8),
          appBar: _buildAppBar(w, isNarrow),
          body: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(hPad, 12, hPad, 0),
                child: _buildHeroBanner(w),
              ),
            ),

            if (_activeFilters.isNotEmpty)
              SliverToBoxAdapter(child: _activeFilterRow(hPad)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(hPad, 10, hPad, 6),
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
                      _filtered.isEmpty
                          ? 'No products found'
                          : '${_filtered.length} Product${_filtered.length == 1 ? '' : 's'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const Spacer(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: _showSort,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!isNarrow)
                              Text(
                                _sort.label,
                                style: const TextStyle(
                                  color: Color(0xFF2E7D32),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFF2E7D32),
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _filtered.isEmpty
                ? SliverFillRemaining(child: _emptyState())
                : _isGrid
                ? SliverPadding(
              padding: EdgeInsets.fromLTRB(hPad, 4, hPad, 32),
              sliver: SliverGrid(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: cols,
                  childAspectRatio: ratio,
                  crossAxisSpacing: isNarrow ? 8 : 12,
                  mainAxisSpacing: isNarrow ? 8 : 12,
                ),
                delegate: SliverChildBuilderDelegate(
                      (_, i) => _GridCard(
                    product: _filtered[i],
                    index: i,
                    wishlisted: _wishlist.contains(_filtered[i].id),
                    onWishlist: () => setState(() {
                      if (_wishlist.contains(_filtered[i].id)) {
                        _wishlist.remove(_filtered[i].id);
                      } else {
                        _wishlist.add(_filtered[i].id);
                      }
                    }),
                    onTap: () => _navigateToDetail(_filtered[i]),
                    onAddToCart: () => _addToCart(_filtered[i]),
                    screenWidth: w,
                  ),
                  childCount: _filtered.length,
                ),
              ),
            )
                : SliverPadding(
              padding: EdgeInsets.fromLTRB(hPad, 4, hPad, 32),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (_, i) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ListCard(
                      product: _filtered[i],
                      index: i,
                      wishlisted:
                      _wishlist.contains(_filtered[i].id),
                      onWishlist: () => setState(() {
                        if (_wishlist.contains(_filtered[i].id)) {
                          _wishlist.remove(_filtered[i].id);
                        } else {
                          _wishlist.add(_filtered[i].id);
                        }
                      }),
                      onTap: () => _navigateToDetail(_filtered[i]),
                      onAddToCart: () => _addToCart(_filtered[i]),
                      screenWidth: w,
                    ),
                  ),
                  childCount: _filtered.length,
                ),
              ),
            ),
          ]),
        );
      },
    );
  }

  AppBar _buildAppBar(double w, bool isNarrow) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      toolbarHeight: isNarrow ? 52 : 56,
      leading: _appBarIconBtn(
        icon: Icons.arrow_back_rounded,
        onTap: () => Navigator.maybePop(context),
        tooltip: 'Go Back',
      ),
      title: _searchField(w),
      titleSpacing: 4,
      actions: [
        _appBarIconBtn(
          icon: Icons.sort_rounded,
          onTap: _showSort,
          tooltip: 'Sort',
          color: _sort != _Sort.recommended
              ? Colors.white
              : Colors.grey.shade600,
          bg: _sort != _Sort.recommended
              ? const Color(0xFF2E7D32)
              : const Color(0xFFF4F6F8),
          useGreenShadow: _sort != _Sort.recommended,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        ),
        _filterIconBtn(),
        _appBarIconBtn(
          icon: _isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
          onTap: () => setState(() => _isGrid = !_isGrid),
          tooltip: _isGrid ? 'List View' : 'Grid View',
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 8, bottom: 8),
          child: Tooltip(
            message: 'Cart',
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Stack(
                clipBehavior: Clip.none,
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
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.shopping_cart_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: _openCart,
                      padding: const EdgeInsets.all(8),
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                  ),
                  if (_cartCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF6F00),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '$_cartCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner(double w) {
    final small = w < _kMid;
    return Container(
      height: small ? 100 : (w >= _kWide ? 130 : 115),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFFFF6F00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2E7D32).withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
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
              horizontal: small ? 16 : 28,
              vertical: small ? 12 : 16,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _filtered.isEmpty
                            ? 'No products found'
                            : '${_filtered.length} Products Available',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: small ? 15 : (w >= _kWide ? 20 : 17),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (!small) ...[
                        const SizedBox(height: 4),
                        Text(
                          'Find the best deals for you',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        children: [
                          _heroBadge('Free Delivery'),
                          if (!small) _heroBadge('Easy Returns'),
                          if (!small) _heroBadge('Secure Pay'),
                        ],
                      ),
                    ],
                  ),
                ),
                if (_activeFilters.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border:
                      Border.all(color: Colors.white.withOpacity(0.4)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.filter_list_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${_activeFilters.length} Active',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _appBarIconBtn({
    required IconData icon,
    required VoidCallback onTap,
    String tooltip = '',
    Color color = Colors.white,
    Color bg = const Color(0xFF2E7D32),
    bool useGreenShadow = true,
    EdgeInsets margin =
    const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
  }) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            boxShadow: useGreenShadow
                ? [
              BoxShadow(
                color: const Color(0xFF4CAF50).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ]
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: IconButton(
            icon: Icon(icon, color: color, size: 20),
            onPressed: onTap,
            padding: const EdgeInsets.all(8),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ),
      ),
    );
  }

  Widget _filterIconBtn() {
    final has = _activeFilters.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color:
                has ? const Color(0xFF2E7D32) : const Color(0xFFF4F6F8),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                  has ? const Color(0xFF2E7D32) : Colors.grey.shade200,
                ),
                boxShadow: has
                    ? [
                  BoxShadow(
                    color: const Color(0xFF4CAF50).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                    : [],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.tune_rounded,
                  color: has ? Colors.white : const Color(0xFF2E7D32),
                  size: 20,
                ),
                onPressed: _showFilter,
                padding: const EdgeInsets.all(8),
                constraints:
                const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ),
            if (has)
              Positioned(
                top: -4,
                right: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6F00),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${_activeFilters.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _searchField(double w) {
    final small = w < _kNarrow;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F8),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: _search,
        style: TextStyle(fontSize: small ? 12 : 13),
        decoration: InputDecoration(
          hintText: small ? 'Search...' : 'Search products...',
          hintStyle: TextStyle(
            color: Colors.grey.shade400,
            fontSize: small ? 12 : 13,
          ),
          prefixIcon:
          Icon(Icons.search, color: Colors.grey.shade400, size: 18),
          suffixIcon: _search.text.isNotEmpty
              ? MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              icon: const Icon(Icons.clear, size: 16),
              onPressed: () {
                _search.clear();
                _apply();
              },
            ),
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _heroBadge(String text) => Container(
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

  Widget _activeFilterRow(double hPad) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.fromLTRB(hPad, 8, hPad, 0),
        children: [
          ..._activeFilters.map(
                (f) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Chip(
                  label: Text(
                    f,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: const Color(0xFF2E7D32),
                  deleteIcon: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                  onDeleted: () {
                    setState(() => _activeFilters.remove(f));
                    _apply();
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: ActionChip(
              label: const Text(
                'Clear All',
                style: TextStyle(
                  color: Color(0xFFFF6F00),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              backgroundColor: const Color(0xFFFFF3E0),
              side: const BorderSide(color: Color(0xFFFF6F00), width: 1),
              onPressed: () {
                setState(() => _activeFilters.clear());
                _apply();
              },
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState() => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.search_off_rounded,
            size: 70, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Text(
          'No products found',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Try adjusting your search or filters',
          style:
          TextStyle(fontSize: 13, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 20),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ElevatedButton(
            onPressed: () => setState(() {
              _activeFilters.clear();
              _search.clear();
              _sort = _Sort.recommended;
              _filtered = List.from(_products);
            }),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E7D32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 24, vertical: 10),
              elevation: 0,
            ),
            child: const Text(
              'Clear Filters',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ─── Grid Card ────────────────────────────────────────────────────────────────
class _GridCard extends StatefulWidget {
  final ProductListing product;
  final int index;
  final bool wishlisted;
  final VoidCallback onWishlist;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final double screenWidth;

  const _GridCard({
    required this.product,
    required this.index,
    required this.wishlisted,
    required this.onWishlist,
    required this.onTap,
    required this.onAddToCart,
    required this.screenWidth,
  });

  @override
  State<_GridCard> createState() => _GridCardState();
}

class _GridCardState extends State<_GridCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final w = widget.screenWidth;
    final gradient = _gradients[widget.index % _gradients.length];
    final small = w < 400;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(_hovered ? 0.13 : 0.07),
                blurRadius: _hovered ? 20 : 12,
                offset: Offset(0, _hovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 52,
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
                        p.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: small ? 30 : 40,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      if (!p.inStock)
                        Container(
                          color: Colors.black.withOpacity(0.45),
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'OUT OF STOCK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: small ? 7 : 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                        ),
                      if (p.badge.isNotEmpty)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _badgeColor[p.badge],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  (_badgeColor[p.badge] ?? Colors.red)
                                      .withOpacity(0.35),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              p.badge,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: small ? 7 : 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .5,
                              ),
                            ),
                          ),
                        ),
                      if (p.discountPercent != null)
                        Positioned(
                          top: 6,
                          right: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6F00)
                                  .withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '-${p.discountPercent}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: small ? 7 : 9,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: widget.onWishlist,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                    Colors.black.withOpacity(0.12),
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Icon(
                                widget.wishlisted
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                size: small ? 12 : 15,
                                color: widget.wishlisted
                                    ? Colors.red
                                    : Colors.grey.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (p.freeDelivery && p.inStock)
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 3,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(8),
                              ),
                            ),
                            child: Text(
                              'FREE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: small ? 7 : 8,
                                fontWeight: FontWeight.w800,
                                letterSpacing: .4,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 48,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    small ? 7 : 10,
                    small ? 5 : 7,
                    small ? 7 : 10,
                    small ? 5 : 7,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        p.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: small ? 11 : 13,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 11,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${p.rating}',
                            style: TextStyle(
                              fontSize: small ? 9 : 11,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A2E),
                            ),
                          ),
                          Text(
                            ' (${p.reviewCount})',
                            style: TextStyle(
                              fontSize: small ? 8 : 10,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              'Rs ${p.price.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF2E7D32),
                                fontSize: small ? 11 : 13,
                              ),
                            ),
                          ),
                          if (p.originalPrice != null) ...[
                            const SizedBox(width: 3),
                            Flexible(
                              child: Text(
                                'Rs ${p.originalPrice!.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: small ? 8 : 10,
                                  color: Colors.grey.shade400,
                                  decoration:
                                  TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      // ── SMALLER button: height 22 (small) / 26 (normal) ──
                      SizedBox(
                        width: double.infinity,
                        height: small ? 22 : 26,
                        child: MouseRegion(
                          cursor: p.inStock
                              ? SystemMouseCursors.click
                              : SystemMouseCursors.forbidden,
                          child: ElevatedButton(
                            onPressed:
                            p.inStock ? widget.onAddToCart : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              const Color(0xFF2E7D32),
                              disabledBackgroundColor:
                              Colors.grey.shade200,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              p.inStock
                                  ? (small ? 'Add' : 'Add to Cart')
                                  : 'Out',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: small ? 9 : 11,
                                color: p.inStock
                                    ? Colors.white
                                    : Colors.grey.shade600,
                              ),
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
        ),
      ),
    );
  }
}

// ─── List Card ────────────────────────────────────────────────────────────────
class _ListCard extends StatefulWidget {
  final ProductListing product;
  final int index;
  final bool wishlisted;
  final VoidCallback onWishlist;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;
  final double screenWidth;

  const _ListCard({
    required this.product,
    required this.index,
    required this.wishlisted,
    required this.onWishlist,
    required this.onTap,
    required this.onAddToCart,
    required this.screenWidth,
  });

  @override
  State<_ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<_ListCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final w = widget.screenWidth;
    final gradient = _gradients[widget.index % _gradients.length];
    final small = w < 400;
    final imgW = small ? 90.0 : (w < 600 ? 110.0 : 120.0);
    final cardH = small ? 110.0 : 130.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: cardH,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color:
                Colors.black.withOpacity(_hovered ? 0.13 : 0.07),
                blurRadius: _hovered ? 20 : 12,
                offset: Offset(0, _hovered ? 8 : 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
                child: SizedBox(
                  width: imgW,
                  height: cardH,
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
                        p.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: small ? 28 : 36,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      if (!p.inStock)
                        Container(
                          color: Colors.black.withOpacity(0.45),
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade700,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'OUT OF STOCK',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 7,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      if (p.badge.isNotEmpty)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: _badgeColor[p.badge],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              p.badge,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    small ? 8 : 12,
                    small ? 8 : 10,
                    small ? 8 : 10,
                    small ? 8 : 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              p.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: small ? 12 : 14,
                                color: const Color(0xFF1A1A2E),
                              ),
                            ),
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: widget.onWishlist,
                              child: Padding(
                                padding:
                                const EdgeInsets.only(left: 4),
                                child: Icon(
                                  widget.wishlisted
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  size: small ? 16 : 19,
                                  color: widget.wishlisted
                                      ? Colors.red
                                      : Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            size: 12,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${p.rating}',
                            style: TextStyle(
                              fontSize: small ? 11 : 12,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1A1A2E),
                            ),
                          ),
                          if (!small)
                            Text(
                              ' · ${p.reviewCount} reviews',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                            ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 4,
                        children: [
                          Text(
                            'Rs ${p.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF2E7D32),
                              fontSize: small ? 13 : 16,
                            ),
                          ),
                          if (p.originalPrice != null)
                            Text(
                              'Rs ${p.originalPrice!.toStringAsFixed(0)}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade400,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          if (p.discountPercent != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF6F00)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '-${p.discountPercent}%',
                                style: const TextStyle(
                                  color: Color(0xFFFF6F00),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              // ── SMALLER button: height 22 (small) / 26 ──
                              height: small ? 22 : 26,
                              child: MouseRegion(
                                cursor: p.inStock
                                    ? SystemMouseCursors.click
                                    : SystemMouseCursors.forbidden,
                                child: ElevatedButton.icon(
                                  onPressed: p.inStock
                                      ? widget.onAddToCart
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    const Color(0xFF2E7D32),
                                    disabledBackgroundColor:
                                    Colors.grey.shade200,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(6),
                                    ),
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                  ),
                                  icon: Icon(
                                    p.inStock
                                        ? Icons
                                        .add_shopping_cart_rounded
                                        : Icons
                                        .remove_shopping_cart_outlined,
                                    size: small ? 11 : 13,
                                    color: p.inStock
                                        ? Colors.white
                                        : Colors.grey.shade500,
                                  ),
                                  label: Text(
                                    p.inStock
                                        ? (small
                                        ? 'Add'
                                        : 'Add to Cart')
                                        : 'Unavailable',
                                    style: TextStyle(
                                      fontSize: small ? 9 : 11,
                                      fontWeight: FontWeight.w700,
                                      color: p.inStock
                                          ? Colors.white
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (p.freeDelivery && p.inStock && !small) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2E7D32)
                                    .withOpacity(0.08),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.local_shipping_outlined,
                                    size: 11,
                                    color: Color(0xFF2E7D32),
                                  ),
                                  SizedBox(width: 3),
                                  Text(
                                    'Free',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}