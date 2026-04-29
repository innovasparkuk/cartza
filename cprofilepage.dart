import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ─────────────────────────────────────────────
// THEME / CONSTANTS
// ─────────────────────────────────────────────

const kOrange = Color(0xFFFF6B35);
const kGreen = Color(0xFF22C55E);
const kOrangeSoft = Color(0xFFFF8C5A);
const kGreenSoft = Color(0xFF4ADE80);
const kBg = Color(0xFFF5F5F5);

const kGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kOrange, Color(0xFFFF9A5A), Color(0xFF5DCC7A), kGreen],
  stops: [0.0, 0.35, 0.65, 1.0],
);

const kGradientShort = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [kOrange, kGreen],
);

// ─────────────────────────────────────────────
// APP
// ─────────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kOrange,
        fontFamily: 'Roboto',
      ),
      home: const ProfilePage(),
    );
  }
}

// ─────────────────────────────────────────────
// MODELS
// ─────────────────────────────────────────────

class OrderItem {
  final String id;
  final String productName;
  final String emoji;
  final double price;
  String status;
  final String date;
  final int quantity;

  OrderItem({
    required this.id,
    required this.productName,
    required this.emoji,
    required this.price,
    required this.status,
    required this.date,
    required this.quantity,
  });

  Color get statusColor {
    switch (status) {
      case 'Delivered': return kGreen;
      case 'In Transit': return const Color(0xFFF59E0B);
      case 'Processing': return const Color(0xFF3B82F6);
      case 'Cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
}

class WishlistItem {
  final String name;
  final double price;
  final double? originalPrice;
  final String emoji;
  final Color bg;
  bool inCart;

  WishlistItem({
    required this.name,
    required this.price,
    this.originalPrice,
    required this.emoji,
    required this.bg,
    this.inCart = false,
  });

  int get discountPct => originalPrice != null
      ? (((originalPrice! - price) / originalPrice!) * 100).round()
      : 0;
}

// ─────────────────────────────────────────────
// SAMPLE DATA
// ─────────────────────────────────────────────

List<OrderItem> buildOrders() => [
  OrderItem(id: '#ORD-2025-001', productName: 'Wireless Bluetooth Headphones Pro', emoji: '🎧', price: 4599, status: 'Delivered', date: 'Apr 20, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-002', productName: 'Samsung 65" 4K QLED Smart TV', emoji: '📺', price: 89999, status: 'In Transit', date: 'Apr 22, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-003', productName: 'Nike Air Max Sneakers', emoji: '👟', price: 12500, status: 'Processing', date: 'Apr 25, 2025', quantity: 2),
  OrderItem(id: '#ORD-2025-004', productName: 'Organic Skincare Set', emoji: '🧴', price: 2299, status: 'Cancelled', date: 'Apr 18, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-005', productName: 'Apple Watch Series 9', emoji: '⌚', price: 159999, status: 'Delivered', date: 'Apr 15, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-006', productName: 'iPad Pro 12.9"', emoji: '📱', price: 239999, status: 'In Transit', date: 'Apr 23, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-007', productName: 'Canon EOS R50', emoji: '📷', price: 189999, status: 'Processing', date: 'Apr 24, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-008', productName: 'Bose QC45 Headphones', emoji: '🎧', price: 49999, status: 'Delivered', date: 'Apr 19, 2025', quantity: 2),
  OrderItem(id: '#ORD-2025-009', productName: 'LG 27" Monitor', emoji: '🖥️', price: 79999, status: 'In Transit', date: 'Apr 21, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-010', productName: 'Logitech MX Master 3S', emoji: '🖱️', price: 18999, status: 'Delivered', date: 'Apr 18, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-011', productName: 'Microsoft Surface Laptop', emoji: '💻', price: 189999, status: 'Processing', date: 'Apr 26, 2025', quantity: 1),
  OrderItem(id: '#ORD-2025-012', productName: 'JBL Flip 6 Speaker', emoji: '🔊', price: 24999, status: 'In Transit', date: 'Apr 22, 2025', quantity: 1),
];

List<WishlistItem> buildWishlist() => [
  WishlistItem(name: 'iPhone 15 Pro Max', price: 279999, originalPrice: 299999, emoji: '📱', bg: const Color(0xFFEEF2FF)),
  WishlistItem(name: 'MacBook Air M3', price: 199999, originalPrice: 219999, emoji: '💻', bg: const Color(0xFFFFF0F0)),
  WishlistItem(name: 'Sony PlayStation 5', price: 89999, emoji: '🎮', bg: const Color(0xFFF0FFF4)),
  WishlistItem(name: 'DJI Mini 4 Pro', price: 149999, originalPrice: 169999, emoji: '🚁', bg: const Color(0xFFFFFAF0)),
  WishlistItem(name: 'Dyson V15 Vacuum', price: 79999, emoji: '🌀', bg: const Color(0xFFF5F0FF)),
  WishlistItem(name: 'KitchenAid Mixer', price: 54999, originalPrice: 64999, emoji: '🍰', bg: const Color(0xFFFFF5F5)),
  WishlistItem(name: 'Nintendo Switch OLED', price: 89999, originalPrice: 99999, emoji: '🎮', bg: const Color(0xFFEEF2FF)),
  WishlistItem(name: 'Samsung Galaxy S24 Ultra', price: 249999, originalPrice: 269999, emoji: '📱', bg: const Color(0xFFFFF0F0)),
  WishlistItem(name: 'GoPro Hero 12', price: 79999, originalPrice: 89999, emoji: '📷', bg: const Color(0xFFF0FFF4)),
  WishlistItem(name: 'Kindle Paperwhite', price: 29999, emoji: '📚', bg: const Color(0xFFFFFAF0)),
  WishlistItem(name: 'Echo Dot 5th Gen', price: 9999, originalPrice: 14999, emoji: '🔊', bg: const Color(0xFFF5F0FF)),
  WishlistItem(name: 'Ring Video Doorbell', price: 39999, emoji: '🚪', bg: const Color(0xFFFFF5F5)),
];

// ─────────────────────────────────────────────
// PROFILE PAGE
// ─────────────────────────────────────────────

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  int _tab = 0;
  late List<OrderItem> _orders;
  late List<WishlistItem> _wishlist;
  String _activeFilter = 'All';
  bool _darkMode = false;
  bool _pushNotif = true;
  bool _emailNotif = false;
  bool _smsAlerts = true;
  bool _biometric = false;
  String _language = 'English';
  int _cartCount = 0;

  // Pagination variables
  int _ordersCurrentPage = 1;
  int _wishlistCurrentPage = 1;
  static const int _itemsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _orders = buildOrders();
    _wishlist = buildWishlist();
  }

  // Get paginated orders
  List<OrderItem> get _paginatedOrders {
    final filtered = _getFilteredOrders();
    final start = (_ordersCurrentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    if (start >= filtered.length) return [];
    return filtered.sublist(start, end > filtered.length ? filtered.length : end);
  }

  // Get filtered orders
  List<OrderItem> _getFilteredOrders() {
    return _activeFilter == 'All'
        ? _orders
        : _orders.where((o) => o.status == _activeFilter).toList();
  }

  // Get total pages for orders
  int get _ordersTotalPages {
    final filteredCount = _getFilteredOrders().length;
    return (filteredCount / _itemsPerPage).ceil();
  }

  // Get paginated wishlist items
  List<WishlistItem> get _paginatedWishlist {
    final start = (_wishlistCurrentPage - 1) * _itemsPerPage;
    final end = start + _itemsPerPage;
    if (start >= _wishlist.length) return [];
    return _wishlist.sublist(start, end > _wishlist.length ? _wishlist.length : end);
  }

  // Get total pages for wishlist
  int get _wishlistTotalPages {
    return (_wishlist.length / _itemsPerPage).ceil();
  }

  void _show(String msg, {bool success = true}) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(children: [
        Icon(success ? Icons.check_circle : Icons.info, color: Colors.white, size: 18),
        const SizedBox(width: 8),
        Expanded(child: Text(msg, style: const TextStyle(fontSize: 13))),
      ]),
      backgroundColor: success ? kGreen : kOrange,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: const Duration(seconds: 2),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= 1024;
    final isTablet = w >= 600 && w < 1024;

    return Scaffold(
      backgroundColor: kBg,
      body: isDesktop
          ? Center(
        child: SizedBox(
          width: 1400,
          child: Row(
            children: [
              Container(
                width: 270,
                height: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
                ),
                child: Column(
                  children: [
                    Container(height: 4, decoration: const BoxDecoration(gradient: kGradientShort)),
                    _sidebarHeader(),
                    const Divider(height: 1),
                    const SizedBox(height: 8),
                    _navItem(0, Icons.shopping_bag_outlined, Icons.shopping_bag, 'My Orders', badge: '${_orders.length}'),
                    _navItem(1, Icons.favorite_border, Icons.favorite, 'Wishlist', badge: '${_wishlist.length}'),
                    _navItem(2, Icons.settings_outlined, Icons.settings, 'Settings'),
                    const Spacer(),
                    _logoutButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      backgroundColor: Colors.white,
                      elevation: 1,
                      title: ShaderMask(
                        shaderCallback: (b) => kGradientShort.createShader(b),
                        child: Text(_tabTitle(_tab), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white)),
                      ),
                      actions: [
                        Stack(
                          children: [
                            IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black87), onPressed: () => _show('Cart has $_cartCount item(s)')),
                            if (_cartCount > 0)
                              Positioned(top: 6, right: 6, child: Container(
                                width: 16, height: 16,
                                decoration: const BoxDecoration(color: kOrange, shape: BoxShape.circle),
                                child: Center(child: Text('$_cartCount', style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
                              )),
                          ],
                        ),
                        IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.black87), onPressed: () => _show('No new notifications', success: false)),
                        const SizedBox(width: 8),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: _tabContent(isDesktop: true),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
          : _mobileLayout(isTablet),
    );
  }

  Widget _sidebarHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 80, height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: kGradient,
                ),
                child: const Center(
                  child: Text('AK', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              Positioned(
                bottom: 0, right: 0,
                child: GestureDetector(
                  onTap: () => _showEditProfile(),
                  child: Container(
                    width: 24, height: 24,
                    decoration: BoxDecoration(
                      gradient: kGradientShort,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.edit, color: Colors.white, size: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Ahmed Khan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('ahmed.khan@email.com', style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 10),
          ShaderMask(
            shaderCallback: (b) => kGradientShort.createShader(b),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: kOrange.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.star, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text('Gold Member', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, IconData activeIcon, String label, {String? badge}) {
    final sel = _tab == index;
    return GestureDetector(
      onTap: () => setState(() => _tab = index),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          gradient: sel ? kGradientShort : null,
          color: sel ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(sel ? activeIcon : icon, color: sel ? Colors.white : Colors.grey[600], size: 21),
            const SizedBox(width: 12),
            Text(label, style: TextStyle(
              color: sel ? Colors.white : Colors.grey[700],
              fontWeight: sel ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            )),
            if (badge != null) ...[
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: sel ? Colors.white.withOpacity(0.3) : kOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(badge, style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold,
                  color: sel ? Colors.white : kOrange,
                )),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _logoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: OutlinedButton.icon(
        onPressed: _confirmLogout,
        icon: const Icon(Icons.logout, color: Colors.red, size: 18),
        label: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: const Size(double.infinity, 44),
        ),
      ),
    );
  }

  // ─── MOBILE ───────────────────────────────────

  Widget _mobileLayout(bool isTablet) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: _tab,
        child: Builder(
          builder: (context) {
            final tabController = DefaultTabController.of(context);
            if (tabController != null && tabController.index != _tab) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && tabController.index != _tab) {
                  setState(() => _tab = tabController.index);
                }
              });
            }
            return NestedScrollView(
              headerSliverBuilder: (ctx, scrolled) => [
                SliverAppBar(
                  expandedHeight: isTablet ? 230 : 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: _mobileHeader(),
                  ),
                  backgroundColor: kOrange,
                  title: scrolled
                      ? const Text('My Profile', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                      : null,
                  actions: [
                    Stack(
                      children: [
                        IconButton(icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white), onPressed: () => _show('Cart has $_cartCount item(s)')),
                        if (_cartCount > 0)
                          Positioned(top: 6, right: 6, child: Container(
                            width: 16, height: 16,
                            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            child: Center(child: Text('$_cartCount', style: const TextStyle(color: kOrange, fontSize: 10, fontWeight: FontWeight.bold))),
                          )),
                      ],
                    ),
                    IconButton(icon: const Icon(Icons.notifications_outlined, color: Colors.white), onPressed: () => _show('No new notifications', success: false)),
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: Container(
                      color: Colors.white,
                      child: TabBar(
                        controller: tabController,
                        onTap: (i) {
                          setState(() => _tab = i);
                        },
                        labelColor: kOrange,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: kOrange,
                        indicatorWeight: 3,
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        tabs: const [
                          Tab(icon: Icon(Icons.shopping_bag_outlined, size: 19), text: 'Orders'),
                          Tab(icon: Icon(Icons.favorite_border, size: 19), text: 'Wishlist'),
                          Tab(icon: Icon(Icons.settings_outlined, size: 19), text: 'Settings'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              body: TabBarView(
                controller: tabController,
                children: [
                  _ordersTab(isDesktop: false, isTablet: isTablet),
                  _wishlistTab(isDesktop: false, isTablet: isTablet),
                  _settingsTab(isDesktop: false),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _mobileHeader() {
    return Container(
      decoration: const BoxDecoration(gradient: kGradient),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _showEditProfile,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white.withOpacity(0.25),
                          child: const Text('AK', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        Positioned(
                          bottom: 0, right: 0,
                          child: Container(
                            width: 20, height: 20,
                            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: kOrange, width: 1.5)),
                            child: const Icon(Icons.edit, color: kOrange, size: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Ahmed Khan', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 2),
                      const Text('ahmed.khan@email.com', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.star, color: Colors.amber, size: 13),
                          SizedBox(width: 4),
                          Text('Gold Member', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                        ]),
                      ),
                    ],
                  )),
                ],
              ),
              const SizedBox(height: 12),
              Row(children: [
                _statChip('${_orders.length}', 'Orders'),
                const SizedBox(width: 10),
                _statChip('${_wishlist.length}', 'Wishlist'),
                const SizedBox(width: 10),
                _statChip('3', 'Reviews'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statChip(String val, String lbl) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
        Text(lbl, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ]),
    ),
  );

  String _tabTitle(int i) => ['My Orders', 'My Wishlist', 'Settings'][i];

  Widget _tabContent({bool isDesktop = false, bool isTablet = false}) {
    switch (_tab) {
      case 0: return _ordersTab(isDesktop: isDesktop, isTablet: isTablet);
      case 1: return _wishlistTab(isDesktop: isDesktop, isTablet: isTablet);
      case 2: return _settingsTab(isDesktop: isDesktop);
      default: return const SizedBox.shrink();
    }
  }

  // ─────────────────────────────────────────────
  // ORDERS TAB WITH PAGINATION
  // ─────────────────────────────────────────────

  Widget _ordersTab({bool isDesktop = false, bool isTablet = false}) {
    final filters = ['All', 'Processing', 'In Transit', 'Delivered', 'Cancelled'];
    final filteredOrders = _getFilteredOrders();
    final totalPages = _ordersTotalPages;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter row
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (_, i) {
                final active = filters[i] == _activeFilter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _activeFilter = filters[i];
                        _ordersCurrentPage = 1; // Reset to first page when filter changes
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: active ? kGradientShort : null,
                        color: active ? null : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: active ? Colors.transparent : Colors.grey[300]!),
                        boxShadow: active ? [const BoxShadow(color: Colors.black12, blurRadius: 4)] : [],
                      ),
                      child: Text(filters[i], style: TextStyle(
                        color: active ? Colors.white : Colors.grey[600],
                        fontWeight: active ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      )),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          if (filteredOrders.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(children: [
                  const Text('📦', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text('No $_activeFilter orders', style: const TextStyle(fontSize: 15, color: Colors.grey)),
                ]),
              ),
            )
          else ...[
            ..._paginatedOrders.map((o) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _orderCard(o, isDesktop: isDesktop),
            )),
            if (totalPages > 1)
              _buildPagination(
                currentPage: _ordersCurrentPage,
                totalPages: totalPages,
                onPageChanged: (page) {
                  setState(() {
                    _ordersCurrentPage = page;
                  });
                },
                isDesktop: isDesktop,
              ),
          ],
        ],
      ),
    );
  }

  Widget _orderCard(OrderItem order, {bool isDesktop = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: Colors.black87), maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: order.statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(order.status, style: TextStyle(color: order.statusColor, fontWeight: FontWeight.w600, fontSize: 10)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 55, height: 55,
                  decoration: BoxDecoration(
                    color: kBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Center(child: Text(order.emoji, style: const TextStyle(fontSize: 28))),
                ),
                const SizedBox(width: 12),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.productName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Text('Qty: ${order.quantity}', style: TextStyle(color: Colors.grey[500], fontSize: 10)),
                    const SizedBox(height: 2),
                    ShaderMask(
                      shaderCallback: (b) => kGradientShort.createShader(b),
                      child: Text('Rs. ${order.price.toStringAsFixed(0)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                    ),
                  ],
                )),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(order.date, style: TextStyle(color: Colors.grey[500], fontSize: 10)),
                const Spacer(),
                ..._orderActions(order),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _orderActions(OrderItem order) {
    switch (order.status) {
      case 'Delivered':
        return [
          _actionBtn('Rate', Icons.star_border, kOrange, () => _showRatingDialog(order)),
          const SizedBox(width: 6),
          _actionBtn('Reorder', Icons.refresh, kGreen, () {
            setState(() => _cartCount++);
            _show('${order.productName} added to cart!');
          }),
        ];
      case 'In Transit':
        return [_actionBtn('Track', Icons.location_on_outlined, const Color(0xFF3B82F6), () => _showTrackingDialog(order))];
      case 'Processing':
        return [_actionBtn('Cancel', Icons.close, Colors.red, () => _confirmCancelOrder(order))];
      case 'Cancelled':
        return [_actionBtn('Reorder', Icons.refresh, kGreen, () {
          setState(() => _cartCount++);
          _show('${order.productName} added to cart!');
        })];
      default:
        return [];
    }
  }

  Widget _actionBtn(String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
          color: color.withOpacity(0.06),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // WISHLIST TAB WITH PAGINATION
  // ─────────────────────────────────────────────

  Widget _wishlistTab({bool isDesktop = false, bool isTablet = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final totalPages = _wishlistTotalPages;

    int cols;
    double aspectRatio;

    if (isDesktop) {
      cols = 4;
      aspectRatio = 0.75;
    } else if (isTablet) {
      cols = 3;
      aspectRatio = 0.72;
    } else {
      cols = screenWidth < 360 ? 1 : 2;
      aspectRatio = screenWidth < 360 ? 1.2 : 0.75;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 12, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${_wishlist.length} items saved', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    for (var item in _wishlist) {
                      if (!item.inCart) { item.inCart = true; _cartCount++; }
                    }
                  });
                  _show('All wishlist items added to cart!');
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    gradient: kGradientShort,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Add All to Cart', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_wishlist.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(children: [
                  const Text('❤️', style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  const Text('Your wishlist is empty', style: TextStyle(fontSize: 15, color: Colors.grey)),
                ]),
              ),
            )
          else ...[
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: aspectRatio,
              ),
              itemCount: _paginatedWishlist.length,
              itemBuilder: (_, i) => _wishlistCard(_paginatedWishlist[i]),
            ),
            if (totalPages > 1)
              const SizedBox(height: 16),
            if (totalPages > 1)
              _buildPagination(
                currentPage: _wishlistCurrentPage,
                totalPages: totalPages,
                onPageChanged: (page) {
                  setState(() {
                    _wishlistCurrentPage = page;
                  });
                },
                isDesktop: isDesktop,
              ),
          ],
        ],
      ),
    );
  }

  // Common pagination widget
  Widget _buildPagination({
    required int currentPage,
    required int totalPages,
    required Function(int) onPageChanged,
    required bool isDesktop,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Previous button
          if (currentPage > 1)
            GestureDetector(
              onTap: () => onPageChanged(currentPage - 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: kGradientShort,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.chevron_left, color: Colors.white, size: 18),
                    SizedBox(width: 4),
                    Text('Previous', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),

          if (currentPage > 1) const SizedBox(width: 8),

          // Page numbers
          ...List.generate(_getVisiblePages(currentPage, totalPages), (index) {
            final pageNumber = _getPageNumberAtIndex(currentPage, totalPages, index);
            return GestureDetector(
              onTap: () => onPageChanged(pageNumber),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 40,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: currentPage == pageNumber ? kOrange : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: currentPage == pageNumber ? Colors.transparent : Colors.grey[300]!),
                ),
                child: Center(
                  child: Text(
                    '$pageNumber',
                    style: TextStyle(
                      color: currentPage == pageNumber ? Colors.white : Colors.grey[700],
                      fontWeight: currentPage == pageNumber ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            );
          }),

          if (currentPage < totalPages) const SizedBox(width: 8),

          // Next button
          if (currentPage < totalPages)
            GestureDetector(
              onTap: () => onPageChanged(currentPage + 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: kGradientShort,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text('Next', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to get visible page numbers (show at most 5 pages)
  List<int> _getVisiblePagesList(int currentPage, int totalPages) {
    if (totalPages <= 1) return [1];

    List<int> pages = [];
    int start = currentPage - 2;
    if (start < 1) start = 1;
    if (totalPages > 5) {
      int end = start + 4;
      if (end > totalPages) {
        start = totalPages - 4;
        end = totalPages;
      }
      for (int i = start; i <= end; i++) {
        pages.add(i);
      }
    } else {
      for (int i = 1; i <= totalPages; i++) {
        pages.add(i);
      }
    }
    return pages;
  }

  int _getVisiblePages(int currentPage, int totalPages) {
    return _getVisiblePagesList(currentPage, totalPages).length;
  }

  int _getPageNumberAtIndex(int currentPage, int totalPages, int index) {
    return _getVisiblePagesList(currentPage, totalPages)[index];
  }

  Widget _wishlistCard(WishlistItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: item.bg,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  ),
                  child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 40))),
                ),
                if (item.originalPrice != null)
                  Positioned(top: 6, left: 6, child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    decoration: BoxDecoration(
                      gradient: kGradientShort,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text('-${item.discountPct}%', style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                  )),
                Positioned(top: 6, right: 6, child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _wishlist.remove(item);
                      // Adjust current page if needed
                      final newTotalPages = _wishlistTotalPages;
                      if (_wishlistCurrentPage > newTotalPages && newTotalPages > 0) {
                        _wishlistCurrentPage = newTotalPages;
                      }
                    });
                    _show('Removed from wishlist', success: false);
                  },
                  child: Container(
                    width: 26, height: 26,
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)]),
                    child: const Icon(Icons.favorite, color: Colors.red, size: 14),
                  ),
                )),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(item.name,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 2),
                  ShaderMask(
                    shaderCallback: (b) => kGradientShort.createShader(b),
                    child: Text('Rs. ${item.price.toStringAsFixed(0)}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
                    ),
                  ),
                  if (item.originalPrice != null)
                    Text('Rs. ${item.originalPrice!.toStringAsFixed(0)}',
                      style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 9),
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 28,
                    child: ElevatedButton(
                      onPressed: item.inCart ? null : () {
                        setState(() { item.inCart = true; _cartCount++; });
                        _show('${item.name} added to cart!');
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                      ),
                      child: item.inCart
                          ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text('In Cart ✓', style: TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w600)),
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                          gradient: kGradientShort,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Center(
                          child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
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

  // ─────────────────────────────────────────────
  // SETTINGS TAB
  // ─────────────────────────────────────────────

  Widget _settingsTab({bool isDesktop = false}) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 12, vertical: 12),
      child: Column(
        children: [
          _section('Account', [
            _tile(Icons.person_outline, 'Edit Profile', 'Update your personal info', onTap: _showEditProfile),
            _tile(Icons.location_on_outlined, 'Delivery Addresses', '3 saved addresses', onTap: () => _showAddressDialog()),
            _tile(Icons.credit_card_outlined, 'Payment Methods', '2 cards saved', onTap: () => _showPaymentDialog()),
          ]),
          const SizedBox(height: 14),
          _section('Notifications', [
            _toggleTile(Icons.notifications_active_outlined, 'Push Notifications', 'Receive order updates', _pushNotif, (v) => setState(() => _pushNotif = v)),
            _toggleTile(Icons.email_outlined, 'Email Notifications', 'Promotions and offers', _emailNotif, (v) => setState(() => _emailNotif = v)),
            _toggleTile(Icons.sms_outlined, 'SMS Alerts', 'Order & delivery alerts', _smsAlerts, (v) => setState(() => _smsAlerts = v)),
          ]),
          const SizedBox(height: 14),
          _section('Preferences', [
            _toggleTile(Icons.dark_mode_outlined, 'Dark Mode', 'Toggle dark theme', _darkMode, (v) => setState(() { _darkMode = v; _show(_darkMode ? 'Dark mode on' : 'Dark mode off'); })),
            _tile(Icons.language_outlined, 'Language', _language, onTap: _showLanguageDialog),
            _tile(Icons.currency_rupee, 'Currency', 'PKR (Rs.)', onTap: () => _show('Currency options coming soon', success: false)),
          ]),
          const SizedBox(height: 14),
          _section('Security', [
            _tile(Icons.lock_outline, 'Change Password', 'Last changed 30 days ago', onTap: _showChangePasswordDialog),
            _toggleTile(Icons.fingerprint, 'Biometric Login', 'Fingerprint / Face ID', _biometric, (v) => setState(() { _biometric = v; _show(_biometric ? 'Biometric enabled' : 'Biometric disabled'); })),
            _tile(Icons.privacy_tip_outlined, 'Privacy Policy', '', onTap: () => _show('Opening privacy policy...', success: false)),
          ]),
          const SizedBox(height: 14),
          _section('Support', [
            _tile(Icons.help_outline, 'Help Center', 'FAQs and guides', onTap: () => _show('Opening help center...', success: false)),
            _tile(Icons.chat_outlined, 'Chat Support', 'Talk to an agent', onTap: () => _showChatSupport()),
            _tile(Icons.star_outline, 'Rate the App', 'Share your feedback', onTap: () => _showRateAppDialog()),
          ]),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity, height: 50,
            child: OutlinedButton.icon(
              onPressed: _confirmLogout,
              icon: const Icon(Icons.logout, color: Colors.red, size: 18),
              label: const Text('Log Out', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 15)),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _section(String title, List<Widget> tiles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(title.toUpperCase(),
              style: TextStyle(color: Colors.grey[500], fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
          ),
          child: Column(
            children: tiles.asMap().entries.map((e) => Column(
              children: [
                e.value,
                if (e.key < tiles.length - 1) const Divider(height: 1, indent: 54),
              ],
            )).toList(),
          ),
        ),
      ],
    );
  }

  Widget _tile(IconData icon, String title, String sub, {VoidCallback? onTap}) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      onTap: onTap,
      leading: Container(
        width: 34, height: 34,
        decoration: BoxDecoration(
          gradient: kGradientShort,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(icon, color: Colors.white, size: 17),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      subtitle: sub.isNotEmpty ? Text(sub, style: TextStyle(color: Colors.grey[500], fontSize: 11)) : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 18),
    );
  }

  Widget _toggleTile(IconData icon, String title, String sub, bool val, ValueChanged<bool> onChanged) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      leading: Container(
        width: 34, height: 34,
        decoration: BoxDecoration(gradient: kGradientShort, borderRadius: BorderRadius.circular(9)),
        child: Icon(icon, color: Colors.white, size: 17),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      subtitle: Text(sub, style: TextStyle(color: Colors.grey[500], fontSize: 11)),
      trailing: Transform.scale(
        scale: 0.85,
        child: Switch(
          value: val,
          onChanged: onChanged,
          activeColor: kGreen,
          activeTrackColor: kGreen.withOpacity(0.3),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // DIALOGS & ACTIONS
  // ─────────────────────────────────────────────

  void _showEditProfile() {
    final nameCtrl = TextEditingController(text: 'Ahmed Khan');
    final emailCtrl = TextEditingController(text: 'ahmed.khan@email.com');
    final phoneCtrl = TextEditingController(text: '+92 300 1234567');
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: ShaderMask(
        shaderCallback: (b) => kGradientShort.createShader(b),
        child: const Text('Edit Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
      ),
      content: SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Center(child: Stack(
            children: [
              Container(
                width: 70, height: 70,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: kGradient),
                child: const Center(child: Text('AK', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
              ),
              Positioned(bottom: 0, right: 0, child: Container(
                width: 22, height: 22,
                decoration: BoxDecoration(gradient: kGradientShort, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 11),
              )),
            ],
          )),
          const SizedBox(height: 16),
          _dialogField(nameCtrl, 'Full Name', Icons.person),
          const SizedBox(height: 10),
          _dialogField(emailCtrl, 'Email', Icons.email),
          const SizedBox(height: 10),
          _dialogField(phoneCtrl, 'Phone', Icons.phone),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(context); _show('Profile updated successfully!'); },
          style: ElevatedButton.styleFrom(backgroundColor: kOrange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Save'),
        ),
      ],
    ));
  }

  Widget _dialogField(TextEditingController ctrl, String label, IconData icon) {
    return TextField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kOrange, size: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: kOrange)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }

  void _showRatingDialog(OrderItem order) {
    int stars = 4;
    showDialog(context: context, builder: (_) => StatefulBuilder(
      builder: (ctx, ss) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Rate Product', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(order.emoji, style: const TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          Text(order.productName, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) => GestureDetector(
              onTap: () => ss(() => stars = i + 1),
              child: Icon(i < stars ? Icons.star : Icons.star_border, color: kOrange, size: 36),
            )),
          ),
          const SizedBox(height: 12),
          TextField(
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Write a review (optional)',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); _show('Thanks for rating $stars ⭐!'); },
            style: ElevatedButton.styleFrom(backgroundColor: kOrange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Submit'),
          ),
        ],
      ),
    ));
  }

  void _showTrackingDialog(OrderItem order) {
    final steps = [
      ('Order Placed', true, kGreen),
      ('Processing', true, kGreen),
      ('Shipped', true, kGreen),
      ('In Transit', true, kOrange),
      ('Out for Delivery', false, Colors.grey),
      ('Delivered', false, Colors.grey),
    ];
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Row(children: [
        const Icon(Icons.local_shipping_outlined, color: kOrange),
        const SizedBox(width: 8),
        const Text('Track Order', style: TextStyle(fontWeight: FontWeight.bold)),
      ]),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(order.id, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 16),
            ...steps.map((s) => Row(
              children: [
                Column(children: [
                  Container(width: 20, height: 20,
                    decoration: BoxDecoration(color: s.$2 ? s.$3 : Colors.grey[200], shape: BoxShape.circle),
                    child: Icon(s.$2 ? Icons.check : Icons.circle, color: s.$2 ? Colors.white : Colors.grey[400], size: 12),
                  ),
                  if (s != steps.last)
                    Container(width: 2, height: 20, color: s.$2 ? s.$3.withOpacity(0.4) : Colors.grey[200]),
                ]),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(s.$1, style: TextStyle(
                    fontWeight: s.$2 ? FontWeight.w600 : FontWeight.normal,
                    color: s.$2 ? Colors.black87 : Colors.grey,
                    fontSize: 13,
                  )),
                ),
              ],
            )).toList(),
          ],
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  void _confirmCancelOrder(OrderItem order) {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Cancel Order?', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Text('Are you sure you want to cancel ${order.id}?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('No, Keep')),
        ElevatedButton(
          onPressed: () {
            setState(() => order.status = 'Cancelled');
            Navigator.pop(context);
            _show('Order cancelled successfully', success: false);
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Yes, Cancel'),
        ),
      ],
    ));
  }

  void _showAddressDialog() {
    final addresses = ['Home: 123 Main Street, Rawalpindi', 'Office: Block 5, DHA Phase 2, Lahore', 'Other: Shop 7, Saddar Bazar'];
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Delivery Addresses', style: TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...addresses.map((a) => ListTile(
              leading: const Icon(Icons.location_on_outlined, color: kOrange),
              title: Text(a, style: const TextStyle(fontSize: 12)),
              trailing: IconButton(icon: const Icon(Icons.edit_outlined, size: 16), onPressed: () { Navigator.pop(context); _show('Edit address coming soon', success: false); }),
              dense: true,
            )).toList(),
            const Divider(),
            TextButton.icon(
              onPressed: () { Navigator.pop(context); _show('Add new address coming soon', success: false); },
              icon: const Icon(Icons.add, color: kGreen),
              label: const Text('Add New Address', style: TextStyle(color: kGreen)),
            ),
          ],
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  void _showPaymentDialog() {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Payment Methods', style: TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 300,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _paymentCard('•••• •••• •••• 4532', 'Visa', Icons.credit_card, kOrange),
          const SizedBox(height: 10),
          _paymentCard('•••• •••• •••• 8901', 'Mastercard', Icons.credit_card, kGreen),
          const Divider(height: 20),
          TextButton.icon(
            onPressed: () { Navigator.pop(context); _show('Add new card coming soon', success: false); },
            icon: const Icon(Icons.add, color: kGreen),
            label: const Text('Add New Card', style: TextStyle(color: kGreen)),
          ),
        ]),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
    ));
  }

  Widget _paymentCard(String number, String type, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: color.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
        color: color.withOpacity(0.05),
      ),
      child: Row(children: [
        Icon(icon, color: color),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(type, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12)),
          Text(number, style: const TextStyle(fontSize: 12)),
        ]),
      ]),
    );
  }

  void _showChangePasswordDialog() {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    final confCtrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Change Password', style: TextStyle(fontWeight: FontWeight.bold)),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        _dialogField(oldCtrl, 'Current Password', Icons.lock_outline),
        const SizedBox(height: 10),
        _dialogField(newCtrl, 'New Password', Icons.lock),
        const SizedBox(height: 10),
        _dialogField(confCtrl, 'Confirm Password', Icons.lock_clock),
      ]),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(context); _show('Password changed successfully!'); },
          style: ElevatedButton.styleFrom(backgroundColor: kOrange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Update'),
        ),
      ],
    ));
  }

  void _showLanguageDialog() {
    final langs = ['English', 'اردو (Urdu)', 'پښتو (Pashto)', 'سندھی (Sindhi)'];
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Select Language', style: TextStyle(fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: langs.map((l) => RadioListTile<String>(
            value: l, groupValue: _language,
            onChanged: (v) { setState(() => _language = v!); Navigator.pop(context); _show('Language set to $v'); },
            title: Text(l, style: const TextStyle(fontSize: 13)),
            activeColor: kOrange,
            dense: true,
          )).toList(),
        ),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel'))],
    ));
  }

  void _showChatSupport() {
    final msgCtrl = TextEditingController();
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: Row(children: [
        Container(width: 32, height: 32, decoration: const BoxDecoration(gradient: kGradientShort, shape: BoxShape.circle), child: const Icon(Icons.support_agent, color: Colors.white, size: 18)),
        const SizedBox(width: 8),
        const Text('Chat Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ]),
      content: SizedBox(
        width: 300,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: kBg, borderRadius: BorderRadius.circular(10)),
            child: const Text('👋 Hi! How can we help you today?', style: TextStyle(fontSize: 13)),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: msgCtrl,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Type your message...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(context); _show('Message sent! Agent will reply shortly.'); },
          style: ElevatedButton.styleFrom(backgroundColor: kGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Send'),
        ),
      ],
    ));
  }

  void _showRateAppDialog() {
    int stars = 5;
    showDialog(context: context, builder: (_) => StatefulBuilder(
      builder: (ctx, ss) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Rate the App', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('🛍️', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 8),
          const Text('Enjoying ShopEase?', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (i) => GestureDetector(
              onTap: () => ss(() => stars = i + 1),
              child: Icon(i < stars ? Icons.star : Icons.star_border, color: kOrange, size: 38),
            )),
          ),
        ]),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Later')),
          ElevatedButton(
            onPressed: () { Navigator.pop(context); _show('Thanks for the $stars⭐ rating!'); },
            style: ElevatedButton.styleFrom(backgroundColor: kOrange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('Submit'),
          ),
        ],
      ),
    ));
  }

  void _confirmLogout() {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      title: const Text('Log Out?', style: TextStyle(fontWeight: FontWeight.bold)),
      content: const Text('Are you sure you want to log out of your account?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () { Navigator.pop(context); _show('Logged out. See you soon! 👋', success: false); },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
          child: const Text('Log Out'),
        ),
      ],
    ));
  }
}