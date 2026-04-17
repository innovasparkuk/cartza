// ============================================================
// FILE: lib/homepage.dart  –  Cartza
// ✅ Overflow fixed – product cards use proper sizing
// ✅ Flash Sale uses items with real asset images from sample_data
// ✅ Recommended uses different items from sample_data
// ✅ Both open ProductDetailPage on tap
// ✅ Search bar functional – filters and navigates
// ✅ Responsive for all screen sizes
// ============================================================
import 'package:flutter/material.dart';
import 'package:cartza/category_page.dart';
import 'package:cartza/notifications_page.dart';
import 'package:cartza/profile_page.dart';
import 'package:cartza/widgets/cart_drawer.dart';
import 'package:cartza/data/cart_data.dart';
import 'package:cartza/data/sample_data.dart';
import 'package:cartza/notification_service.dart';
import 'package:cartza/productdetailpage.dart';

// ─── Brand colours ─────────────────────────────────────────
class _C {
  static const orange    = Color(0xFFFF6F00);
  static const amber     = Color(0xFFFF9800);
  static const green     = Color(0xFF4CAF50);
  static const darkGreen = Color(0xFF2E7D32);
  static const slate     = Color(0xFF37474F);
  static const bg        = Color(0xFFF4F6F8);
  static const white     = Colors.white;
  static const red       = Color(0xFFE53935);
  static const star      = Color(0xFFFFC107);
  static const lightGrey = Color(0xFFF0F2F5);
}

// ─── Responsive breakpoints ─────────────────────────────────
class _BP {
  static const mob  = 816.0;
  static const tab  = 960.0;
  static const desk = 1280.0;
  static const maxW = 1400.0;

  static double w(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isMob(BuildContext c)  => w(c) < mob;
  static bool isTab(BuildContext c)  => w(c) >= mob && w(c) < desk;
  static bool isDesk(BuildContext c) => w(c) >= desk;

  static double hp(BuildContext c) {
    final sw = w(c);
    if (sw < mob)  return 12;
    if (sw < tab)  return 18;
    if (sw < desk) return 24;
    final extra = (sw - maxW) / 2;
    return extra > 24 ? extra : 24;
  }

  static double catIconSize(BuildContext c) {
    final sw = w(c);
    if (sw < mob)  return 48.0;
    if (sw < tab)  return 54.0;
    return 60.0;
  }
}

// ─── Unsplash image URLs (6 banners) ─────────────────────
class _Img {
  static const banners = [
    'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?w=1200&q=80',
    'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=1200&q=80',
    'https://images.unsplash.com/photo-1472851294608-062f824d29cc?w=1200&q=80',
    'https://images.unsplash.com/photo-1556741533-6e6a3bd8a0d2?w=1200&q=80',
    'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=1200&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?w=1200&q=80',
  ];
  static const catNet = [
    'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300&q=80',
    'https://images.unsplash.com/photo-1558769132-cb1aea458c5e?w=300&q=80',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=300&q=80',
    'https://images.unsplash.com/photo-1515488042361-ee00e0ddd4e4?w=300&q=80',
    'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=300&q=80',
    'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=300&q=80',
    'https://images.unsplash.com/photo-1481627834876-b7833e8f5570?w=300&q=80',
    'https://images.unsplash.com/photo-1506617564039-2f3b650b7010?w=300&q=80',
    'https://images.unsplash.com/photo-1594938298603-c8148c4b4757?w=300&q=80',
    'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=300&q=80',
    'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&q=80',
    'https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=300&q=80',
  ];
}

// ─── Categories data (UI strip + grid) ──────────────────────
final List<Map<String, dynamic>> _categories = [
  {'name': 'Beauty',      'icon': Icons.face_retouching_natural, 'color': Color(0xFFE91E63), 'items': 10, 'from': 10,  'img': _Img.catNet[0]},
  {'name': 'Handmade',    'icon': Icons.handshake,               'color': Color(0xFF9C27B0), 'items': 8,  'from': 12,  'img': _Img.catNet[1]},
  {'name': 'Food',        'icon': Icons.local_grocery_store,     'color': Color(0xFFFF9800), 'items': 12, 'from': 15,  'img': _Img.catNet[2]},
  {'name': 'Kids',        'icon': Icons.child_care,              'color': Color(0xFF2196F3), 'items': 10, 'from': 12,  'img': _Img.catNet[3]},
  {'name': 'Electronics', 'icon': Icons.devices,                 'color': Color(0xFF009688), 'items': 10, 'from': 50,  'img': _Img.catNet[4]},
  {'name': 'Sports',      'icon': Icons.sports_soccer,           'color': Color(0xFF4CAF50), 'items': 7,  'from': 20,  'img': _Img.catNet[5]},
  {'name': 'Books',       'icon': Icons.menu_book,               'color': Color(0xFFFF5722), 'items': 5,  'from': 8,   'img': _Img.catNet[6]},
  {'name': 'Grocery',     'icon': Icons.local_grocery_store,     'color': Color(0xFF8BC34A), 'items': 9,  'from': 25,  'img': _Img.catNet[7]},
  {'name': "Men's",       'icon': Icons.checkroom,               'color': Color(0xFF795548), 'items': 9,  'from': 300, 'img': _Img.catNet[8]},
  {'name': "Women's",     'icon': Icons.dry_cleaning,            'color': Color(0xFFF44336), 'items': 11, 'from': 200, 'img': _Img.catNet[9]},
  {'name': 'Home',        'icon': Icons.home,                    'color': Color(0xFF607D8B), 'items': 8,  'from': 150, 'img': _Img.catNet[10]},
  {'name': 'Jewellery',   'icon': Icons.diamond,                 'color': Color(0xFFE91E63), 'items': 6,  'from': 300, 'img': _Img.catNet[11]},
];

// ─── Product model using ASSET images from sample_data ───────
class _Prod {
  final String name;
  final double price;
  final String badge;
  final double rating;
  final int sold;
  final String imageAsset;
  final String description;
  final String category;

  const _Prod({
    required this.name,
    required this.price,
    required this.imageAsset,
    required this.description,
    required this.category,
    this.badge = '',
    this.rating = 4.5,
    this.sold = 120,
  });

  Product1 toProduct1() => Product1(
    id: name.hashCode.toString(),
    name: name,
    price: price,
    brand: category,
    description: description,
    images: [imageAsset],
    specifications: const {},
  );
}

// ─── Flash Sale items ──────────────────────────────────────
const _kFlash = <_Prod>[
  _Prod(
    name: 'Tattoo Kits',
    price: 100,
    imageAsset: 'assets/images/subcategory_3_4.png',
    description: 'Complete tattoo kits including ink, needles, and accessories.',
    category: 'Mehndi & Tattooing',
    badge: '70% OFF',
    rating: 4.6,
    sold: 342,
  ),
  _Prod(
    name: 'Smartphones',
    price: 300,
    imageAsset: 'assets/images/subcategory_5_1.png',
    description: 'Latest smartphones with advanced features and top performance.',
    category: 'Electronics',
    badge: 'SALE',
    rating: 4.7,
    sold: 510,
  ),
  _Prod(
    name: 'Tattoo Needles',
    price: 30,
    imageAsset: 'assets/images/subcategory_3_8.png',
    description: 'High-quality needles for professional tattoo application.',
    category: 'Mehndi & Tattooing',
    badge: '30% OFF',
    rating: 4.4,
    sold: 189,
  ),
  _Prod(
    name: 'Eye Liner',
    price: 18,
    imageAsset: 'assets/images/subcategory_1_9.png',
    description: 'Smudge-proof eyeliner for precise application and long-lasting wear.',
    category: 'Beauty & Cosmetics',
    badge: 'HOT',
    rating: 4.5,
    sold: 231,
  ),
  _Prod(
    name: 'Headphones',
    price: 50,
    imageAsset: 'assets/images/subcategory_5_3.png',
    description: 'Noise-cancelling and wireless headphones for premium sound.',
    category: 'Electronics',
    badge: '25% OFF',
    rating: 4.8,
    sold: 178,
  ),
  _Prod(
    name: 'Mehndi Cones',
    price: 5,
    imageAsset: 'assets/images/subcategory_3_1.png',
    description: 'Natural henna cones for intricate mehndi designs.',
    category: 'Mehndi & Tattooing',
    badge: 'NEW',
    rating: 4.3,
    sold: 95,
  ),
];

// ─── Recommended items ─────────────────────────────────────
const _kRec = <_Prod>[
  _Prod(
    name: 'Skin Care',
    price: 25,
    imageAsset: 'assets/images/subcategory_1_1.png',
    description: 'Skin care products enriched with natural oils and vitamins for glowing skin.',
    category: 'Beauty & Cosmetics',
    badge: 'NEW',
    rating: 4.6,
    sold: 87,
  ),
  _Prod(
    name: 'Handmade Jewelry',
    price: 45,
    imageAsset: 'assets/images/subcategory_2_1.png',
    description: 'Unique handmade jewelry crafted with care and creativity.',
    category: 'Handmade Products',
    badge: '',
    rating: 4.3,
    sold: 145,
  ),
  _Prod(
    name: 'Cricket Bat',
    price: 35,
    imageAsset: 'assets/images/subcategory_8_7.png',
    description: 'Premium cricket bats for practice and matches.',
    category: 'Sports',
    badge: 'HOT',
    rating: 4.5,
    sold: 312,
  ),
  _Prod(
    name: 'Fiction Books',
    price: 15,
    imageAsset: 'assets/images/subcategory_9_1.png',
    description: 'Engaging fiction books across various genres.',
    category: 'Books',
    badge: 'SALE',
    rating: 4.4,
    sold: 204,
  ),
  _Prod(
    name: 'Clay Pots',
    price: 15,
    imageAsset: 'assets/images/subcategory_2_2.png',
    description: 'Durable and stylish clay pots for home decoration and gardening.',
    category: 'Handmade Products',
    badge: '',
    rating: 4.7,
    sold: 67,
  ),
  _Prod(
    name: 'Kids Clothing',
    price: 25,
    imageAsset: 'assets/images/subcategory_4_2.png',
    description: 'Comfortable and stylish clothing for children of all ages.',
    category: 'Kids',
    badge: 'NEW',
    rating: 4.8,
    sold: 198,
  ),
];

// ═══════════════════════════════════════════════════════════
// Homepage
// ═══════════════════════════════════════════════════════════
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _searchCtrl  = TextEditingController();
  int  _navIdx       = 0;
  bool _searchOpen   = false;

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  int get _cartCount => globalCart.fold(0, (s, i) => s + i.quantity);

  void _openCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => StatefulBuilder(
        builder: (ctx, set) => CartDrawer(
          cart: globalCart,
          onUpdate: () { setState(() {}); set(() {}); },
        ),
      ),
    );
  }

  void _openNotifications() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const NotificationsPage())
    ).then((_) => setState(() {}));
  }

  void _goToCategory([String? name]) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CategoryPage(selectedCategory: name))
    );
  }

  void _goToProduct(_Prod prod) {
    Navigator.push(context,
      MaterialPageRoute(
        builder: (_) => ModernProductDetailPage(product: prod.toProduct1()),
      ),
    );
  }

  void _goToProfile() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ProfilePage())
    ).then((_) => setState(() {}));
  }

  void _onSearch(String q) {
    if (q.trim().isEmpty) return;
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => CategoryPage(selectedCategory: q.trim()))
    );
  }

  void _showFlashSalePage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => _FlashSalePage(
        products: _kFlash,
        onProductTap: _goToProduct,
      ),
    ));
  }

  void _showRecommendPage() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => _RecommendPage(
        products: _kRec,
        onProductTap: _goToProduct,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mob = _BP.isMob(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: _C.bg,
      drawer: mob ? _buildDrawer(context) : null,
      appBar: _buildAppBar(context, mob),
      body: _buildBody(context, mob),
      bottomNavigationBar: mob ? _buildBottomNav(context) : null,
    );
  }

  // ── AppBar ──────────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(BuildContext ctx, bool mobile) {
    if (!mobile) {
      return PreferredSize(
        preferredSize: const Size.fromHeight(104),
        child: _WebBar(
          cartCount: _cartCount,
          notifCount: notificationService.unreadCount,
          navIdx: _navIdx,
          onNav: (i) {
            setState(() => _navIdx = i);
            if (i == 1) _goToCategory();
          },
          onCart: _openCart,
          onNotif: _openNotifications,
          onProfile: _goToProfile,
          searchCtrl: _searchCtrl,
          onSearch: _onSearch,
        ),
      );
    }
    return PreferredSize(
      preferredSize: Size.fromHeight(_searchOpen ? 108 : 58),
      child: _MobileBar(
        searchOpen: _searchOpen,
        searchCtrl: _searchCtrl,
        cartCount: _cartCount,
        notifCount: notificationService.unreadCount,
        onMenu: () => _scaffoldKey.currentState?.openDrawer(),
        onSearch: () => setState(() => _searchOpen = !_searchOpen),
        onCart: _openCart,
        onNotif: _openNotifications,
        onSearchSubmit: _onSearch,
      ),
    );
  }

  // ── Body ────────────────────────────────────────────────────
  Widget _buildBody(BuildContext ctx, bool mobile) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        _DeliveryStrip(),
        mobile ? _MobileBanner() : _DesktopHeroRow(onCat: _goToCategory),
        _FilterChips(),
        _HomeCatSection(onCatTap: _goToCategory),
        _FlashHeader(onSeeAll: _showFlashSalePage),
        _HList(
          items: _kFlash,
          onAdd: () => setState(() {}),
          onTap: _goToProduct,
        ),
        if (!_BP.isMob(ctx))
          _PromoBanners(onSell: () => Navigator.pushNamed(ctx, '/seller').catchError((_) {})),
        _SectionHead(title: 'Recommended for You', onAction: _showRecommendPage),
        _ProdGrid(
          items: _kRec,
          onAdd: () => setState(() {}),
          onTap: _goToProduct,
        ),
        const SizedBox(height: 12),
        if (!_BP.isMob(ctx)) const _Footer(),
      ]),
    );
  }

  // ── Drawer ─────────────────────────────────────────────────
  Widget _buildDrawer(BuildContext ctx) {
    final navItems = [
      {'icon': Icons.home_rounded,         'label': 'Home',         'route': '/'},
      {'icon': Icons.grid_view_rounded,    'label': 'Categories',   'route': '/categories'},
      {'icon': Icons.flash_on_rounded,     'label': 'Flash Sale',   'route': '/flashSale'},
      {'icon': Icons.new_releases_rounded, 'label': 'New Arrivals', 'route': '/newArrivals'},
      {'icon': Icons.local_offer_rounded,  'label': 'Deals',        'route': '/deals'},
    ];
    final utilItems = [
      {'icon': Icons.person_rounded,        'label': 'My Profile',    'route': 'profile'},
      {'icon': Icons.shopping_bag_rounded,  'label': 'My Cart',       'route': 'cart'},
      {'icon': Icons.notifications_rounded, 'label': 'Notifications', 'route': 'notifications'},
      {'icon': Icons.favorite_rounded,      'label': 'Wishlist',      'route': '/wishlist'},
      {'icon': Icons.receipt_long_rounded,  'label': 'My Orders',     'route': '/orders'},
    ];

    return Drawer(
      backgroundColor: _C.white,
      width: 285,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
      ),
      child: Column(children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, MediaQuery.of(ctx).padding.top + 20, 20, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF43A047)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.close_rounded, color: Colors.white, size: 18),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  gradient: const LinearGradient(colors: [Color(0xFFFF9800), Color(0xFFFF6F00)]),
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Welcome back!',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
                Text('Sign in to your account',
                    style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 12)),
              ])),
            ]),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () { Navigator.pop(ctx); Navigator.pushNamed(ctx, '/login').catchError((_) {}); },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Text('Sign In', style: TextStyle(color: _C.darkGreen, fontWeight: FontWeight.w800, fontSize: 13)),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward_rounded, color: _C.darkGreen, size: 16),
                ]),
              ),
            ),
          ]),
        ),
        Expanded(child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            _DrawerSectionLabel('MAIN MENU'),
            ...navItems.asMap().entries.map((e) {
              final active = _navIdx == e.key;
              return _DrawerTile(
                icon: e.value['icon'] as IconData,
                label: e.value['label'] as String,
                active: active,
                badge: e.value['label'] == 'Flash Sale' ? 'LIVE' : null,
                onTap: () {
                  setState(() => _navIdx = e.key);
                  Navigator.pop(ctx);
                  final route = e.value['route'] as String;
                  if (route == '/categories') _goToCategory();
                  else if (route == '/flashSale') _showFlashSalePage();
                  else if (route != '/') Navigator.pushNamed(ctx, route).catchError((_) {});
                },
              );
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Divider(height: 1, color: Color(0xFFEEEEEE)),
            ),
            _DrawerSectionLabel('MY ACCOUNT'),
            ...utilItems.map((item) {
              final isCart  = item['route'] == 'cart';
              final isNotif = item['route'] == 'notifications';
              return _DrawerTile(
                icon: item['icon'] as IconData,
                label: item['label'] as String,
                active: false,
                badge: isCart && _cartCount > 0 ? '$_cartCount'
                    : isNotif && notificationService.unreadCount > 0
                    ? '${notificationService.unreadCount}' : null,
                badgeColor: isCart ? _C.orange : _C.red,
                onTap: () {
                  Navigator.pop(ctx);
                  if (isCart) _openCart();
                  else if (isNotif) _openNotifications();
                  else if (item['route'] == 'profile') _goToProfile();
                  else Navigator.pushNamed(ctx, item['route'] as String).catchError((_) {});
                },
              );
            }),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Divider(height: 1, color: Color(0xFFEEEEEE)),
            ),
            _DrawerSectionLabel('MORE'),
            _DrawerTile(icon: Icons.help_outline_rounded, label: 'Help Center', active: false,
                onTap: () { Navigator.pop(ctx); Navigator.pushNamed(ctx, '/help').catchError((_) {}); }),
            _DrawerTile(icon: Icons.settings_outlined, label: 'Settings', active: false,
                onTap: () { Navigator.pop(ctx); Navigator.pushNamed(ctx, '/settings').catchError((_) {}); }),
            _DrawerTile(icon: Icons.storefront_outlined, label: 'Sell on Cartza', active: false,
                badge: 'NEW', badgeColor: _C.green,
                onTap: () { Navigator.pop(ctx); Navigator.pushNamed(ctx, '/seller').catchError((_) {}); }),
            const SizedBox(height: 16),
          ]),
        )),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
          ),
          child: Row(children: [
            const Icon(Icons.verified_outlined, color: _C.green, size: 16),
            const SizedBox(width: 8),
            Expanded(child: Text('100% Secure & Authentic',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 11.5))),
            GestureDetector(
              onTap: () => Navigator.pop(ctx),
              child: Icon(Icons.close_rounded, color: Colors.grey.shade400, size: 18),
            ),
          ]),
        ),
      ]),
    );
  }

  // ── Bottom Navigation ─────────────────────────────────────
  Widget _buildBottomNav(BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(color: _C.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 12, offset: const Offset(0, -2)),
      ]),
      child: NavigationBar(
        height: 62,
        selectedIndex: _navIdx > 3 ? 0 : _navIdx,
        backgroundColor: Colors.transparent,
        elevation: 0,
        indicatorColor: _C.green.withOpacity(0.12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (i) {
          setState(() => _navIdx = i);
          if (i == 1) _goToCategory();
          if (i == 2) _openNotifications();
          if (i == 3) _goToProfile();
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: _C.green),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded, color: _C.green),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: notificationService.unreadCount > 0,
              label: Text('${notificationService.unreadCount}'),
              child: const Icon(Icons.notifications_outlined),
            ),
            selectedIcon: const Icon(Icons.notifications_rounded, color: _C.green),
            label: 'Alerts',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: _C.green),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ══════ Drawer helpers ══════════════════════════════════════
class _DrawerSectionLabel extends StatelessWidget {
  final String label;
  const _DrawerSectionLabel(this.label);
  @override
  Widget build(_) => Padding(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 6),
    child: Text(label, style: TextStyle(
        fontSize: 11, fontWeight: FontWeight.w800,
        color: Colors.grey.shade500, letterSpacing: 1.0)),
  );
}

class _DrawerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  final String? badge;
  final Color badgeColor;
  const _DrawerTile({
    required this.icon, required this.label,
    required this.active, required this.onTap,
    this.badge, this.badgeColor = _C.red,
  });
  @override
  Widget build(_) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: active ? _C.green.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: active ? Border.all(color: _C.green.withOpacity(0.2)) : null,
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: active ? _C.green.withOpacity(0.12) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: active ? _C.green : Colors.grey.shade700),
          ),
          const SizedBox(width: 14),
          Expanded(child: Text(label, style: TextStyle(
              fontSize: 14,
              fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              color: active ? _C.darkGreen : _C.slate))),
          if (badge != null) Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(12)),
            child: Text(badge!, style: const TextStyle(
                color: Colors.white, fontSize: 10, fontWeight: FontWeight.w800)),
          ),
        ]),
      ),
    ),
  );
}

// ══════ Logo ════════════════════════════════════════════════
class _Logo extends StatelessWidget {
  final double size;
  const _Logo({this.size = 22});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: size * 1.6,
    child: Image.asset(
      'assets/images/logo1.png',
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _FallbackLogo(size: size),
    ),
  );
}

class _FallbackLogo extends StatelessWidget {
  final double size;
  const _FallbackLogo({required this.size});
  @override
  Widget build(_) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(
      padding: EdgeInsets.all(size * 0.18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [_C.orange, _C.green],
            begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: Icon(Icons.shopping_cart_rounded, color: Colors.white, size: size * 0.75),
    ),
    SizedBox(width: size * 0.25),
    RichText(text: TextSpan(children: [
      TextSpan(text: 'C', style: TextStyle(color: _C.orange, fontWeight: FontWeight.w900, fontSize: size)),
      TextSpan(text: 'artza', style: TextStyle(color: _C.slate, fontWeight: FontWeight.w900, fontSize: size)),
    ])),
  ]);
}

// ══════ Web AppBar ═══════════════════════════════════════════
class _WebBar extends StatelessWidget {
  final int cartCount, navIdx, notifCount;
  final ValueChanged<int> onNav;
  final VoidCallback onCart, onNotif, onProfile;
  final TextEditingController searchCtrl;
  final ValueChanged<String> onSearch;
  const _WebBar({
    required this.cartCount, required this.navIdx, required this.notifCount,
    required this.onNav, required this.onCart, required this.onNotif,
    required this.onProfile, required this.searchCtrl, required this.onSearch,
  });

  static const _links = ['Home', 'Categories', 'Flash Sale', 'New Arrivals', 'Deals'];

  @override
  Widget build(BuildContext context) {
    return Container(color: _C.white, child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        color: _C.darkGreen,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: Row(children: [
          const Flexible(child: Text('🚚  Free delivery on orders above Rs.2000',
              style: TextStyle(color: Colors.white70, fontSize: 11), overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 16),
          Flexible(child: Wrap(alignment: WrapAlignment.end, spacing: 16, children: [
            _topLink('Sell on Cartza'), _topLink('Help Center'), _topLink('Track Order'),
          ])),
        ]),
      ),
      Container(
        height: 68,
        decoration: BoxDecoration(color: _C.white, boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 8, offset: const Offset(0, 2)),
        ]),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(children: [
          const _Logo(size: 26), const SizedBox(width: 20),
          Expanded(child: _SearchBar(ctrl: searchCtrl, compact: false, onSubmit: onSearch)),
          const SizedBox(width: 12),
          Flexible(child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: _links.asMap().entries.map((e) => _NavPill(
              label: e.value, active: navIdx == e.key, onTap: () => onNav(e.key),
            )).toList()),
          )),
          const SizedBox(width: 8),
          _BagIcon(count: cartCount, onTap: onCart),
          Stack(clipBehavior: Clip.none, children: [
            IconButton(onPressed: onNotif,
                icon: const Icon(Icons.notifications_outlined, color: _C.slate, size: 22)),
            if (notifCount > 0) Positioned(top: 6, right: 6, child: Container(
              width: 8, height: 8,
              decoration: const BoxDecoration(color: _C.red, shape: BoxShape.circle),
            )),
          ]),
          IconButton(onPressed: onProfile,
              icon: const Icon(Icons.person_outline, color: _C.slate, size: 22)),
        ]),
      ),
    ]));
  }

  static Widget _topLink(String t) => InkWell(
    onTap: () {},
    child: Text(t, style: const TextStyle(color: Colors.white70, fontSize: 11)),
  );
}

class _NavPill extends StatefulWidget {
  final String label; final bool active; final VoidCallback onTap;
  const _NavPill({required this.label, required this.active, required this.onTap});
  @override State<_NavPill> createState() => _NavPillState();
}
class _NavPillState extends State<_NavPill> {
  bool _hov = false;
  @override
  Widget build(_) => MouseRegion(
    onEnter: (_) => setState(() => _hov = true),
    onExit:  (_) => setState(() => _hov = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        margin: const EdgeInsets.only(left: 2),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: (widget.active || _hov) ? _C.green.withOpacity(0.09) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: widget.active
              ? const Border(bottom: BorderSide(color: _C.green, width: 2))
              : null,
        ),
        child: Text(widget.label, style: TextStyle(
          fontSize: 12.5,
          color: (widget.active || _hov) ? _C.darkGreen : _C.slate,
          fontWeight: (widget.active || _hov) ? FontWeight.w700 : FontWeight.w500,
        )),
      ),
    ),
  );
}

// ══════ Mobile AppBar ════════════════════════════════════════
class _MobileBar extends StatelessWidget {
  final bool searchOpen;
  final TextEditingController searchCtrl;
  final int cartCount, notifCount;
  final VoidCallback onMenu, onSearch, onCart, onNotif;
  final ValueChanged<String> onSearchSubmit;
  const _MobileBar({
    required this.searchOpen, required this.searchCtrl,
    required this.cartCount, required this.notifCount,
    required this.onMenu, required this.onSearch,
    required this.onCart, required this.onNotif,
    required this.onSearchSubmit,
  });

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: _C.white, boxShadow: [
      BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2)),
    ]),
    child: SafeArea(bottom: false, child: Column(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(height: 56, child: Row(children: [
        IconButton(onPressed: onMenu,
            icon: const Icon(Icons.menu_rounded, color: _C.slate, size: 24)),
        const _Logo(size: 20),
        const Spacer(),
        IconButton(onPressed: onSearch,
            icon: Icon(searchOpen ? Icons.close_rounded : Icons.search_rounded,
                color: _C.slate, size: 22)),
        Stack(clipBehavior: Clip.none, children: [
          IconButton(onPressed: onNotif,
              icon: const Icon(Icons.notifications_outlined, color: _C.slate, size: 22)),
          if (notifCount > 0) Positioned(top: 8, right: 8, child: Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(color: _C.red, shape: BoxShape.circle),
          )),
        ]),
        _BagIcon(count: cartCount, onTap: onCart),
        const SizedBox(width: 4),
      ])),
      AnimatedCrossFade(
        firstChild: const SizedBox(height: 0, width: double.infinity),
        secondChild: _SearchBar(ctrl: searchCtrl, compact: true, onSubmit: onSearchSubmit),
        crossFadeState: searchOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 220),
      ),
    ])),
  );
}

// ══════ Search Bar ════════════════════════════════════════════
class _SearchBar extends StatefulWidget {
  final TextEditingController ctrl;
  final bool compact;
  final ValueChanged<String> onSubmit;
  const _SearchBar({required this.ctrl, required this.compact, required this.onSubmit});
  @override State<_SearchBar> createState() => _SearchBarState();
}
class _SearchBarState extends State<_SearchBar> {
  bool _focused = false;
  final _fn = FocusNode();
  @override void initState() {
    super.initState();
    _fn.addListener(() => setState(() => _focused = _fn.hasFocus));
  }
  @override void dispose() { _fn.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.compact
          ? const EdgeInsets.fromLTRB(10, 0, 10, 8)
          : EdgeInsets.zero,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 44,
        decoration: BoxDecoration(
          color: _focused ? _C.white : _C.lightGrey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: _focused ? _C.orange : Colors.grey.shade300, width: 1.5),
          boxShadow: _focused
              ? [BoxShadow(color: _C.orange.withOpacity(0.15), blurRadius: 10)]
              : [],
        ),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search_rounded,
                color: _focused ? _C.orange : Colors.grey.shade400, size: 20),
          ),
          Expanded(
            child: TextField(
              controller: widget.ctrl,
              focusNode: _fn,
              style: const TextStyle(fontSize: 13.5, color: _C.slate),
              decoration: InputDecoration(
                hintText: 'Search products, brands…',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                border: InputBorder.none, isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onChanged: (_) => setState(() {}),
              onSubmitted: widget.onSubmit,
              textInputAction: TextInputAction.search,
            ),
          ),
          if (widget.ctrl.text.isNotEmpty)
            GestureDetector(
              onTap: () => setState(() => widget.ctrl.clear()),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.close_rounded, size: 16, color: Colors.grey.shade500),
              ),
            ),
          GestureDetector(
            onTap: () => widget.onSubmit(widget.ctrl.text),
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [_C.orange, _C.amber],
                    begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.horizontal(right: Radius.circular(9)),
              ),
              child: const Center(
                child: Text('Search',
                    style: TextStyle(color: Colors.white, fontSize: 13,
                        fontWeight: FontWeight.w800, letterSpacing: 0.3)),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

// ══════ Cart icon ════════════════════════════════════════════
class _BagIcon extends StatelessWidget {
  final int count; final VoidCallback onTap;
  const _BagIcon({required this.count, required this.onTap});
  @override
  Widget build(_) => Stack(clipBehavior: Clip.none, children: [
    IconButton(onPressed: onTap,
        icon: const Icon(Icons.shopping_bag_outlined, color: _C.slate, size: 22)),
    if (count > 0) Positioned(top: 4, right: 4, child: Container(
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(color: _C.red, shape: BoxShape.circle),
      constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      child: Text('$count', textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
    )),
  ]);
}

// ══════ Delivery strip ═══════════════════════════════════════
class _DeliveryStrip extends StatelessWidget {
  static const _items = [
    [Icons.local_shipping_outlined, 'Free delivery Rs.2000+'],
    [Icons.replay_outlined,          '7-day easy returns'],
    [Icons.verified_outlined,        '100% authentic'],
    [Icons.support_agent_outlined,   '24/7 support'],
    [Icons.lock_outline,             'Secure payments'],
  ];
  @override
  Widget build(BuildContext context) => Container(
    color: const Color(0xFFF0F8F0),
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _items.map((it) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(it[0] as IconData, color: _C.green, size: 15),
          const SizedBox(width: 5),
          Text(it[1] as String,
              style: const TextStyle(fontSize: 11.5, color: _C.slate, fontWeight: FontWeight.w500)),
        ]),
      )).toList()),
    ),
  );
}

// ══════ Mobile Banner ════════════════════════════════════════
class _MobileBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hp  = _BP.hp(context);
    final mob = _BP.isMob(context);
    return Container(
      color: _C.white,
      padding: EdgeInsets.fromLTRB(hp, 10, hp, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(mob ? 10 : 12),
        child: LayoutBuilder(builder: (_, c) {
          final h = (c.maxWidth / (mob ? 2.0 : 2.8)).clamp(140.0, 320.0);
          return SizedBox(width: double.infinity, height: h,
              child: _BannerSlider(height: h));
        }),
      ),
    );
  }
}

// ══════ Banner Slider ════════════════════════════════════════
class _BannerSlider extends StatefulWidget {
  final double height;
  const _BannerSlider({required this.height});
  @override State<_BannerSlider> createState() => _BannerSliderState();
}
class _BannerSliderState extends State<_BannerSlider> {
  int _cur = 0;
  final PageController _pc = PageController();

  static final _slides = [
    {'title': 'Shop Smarter ✨',  'sub': 'Thousands of products at your fingertips', 'url': _Img.banners[0]},
    {'title': 'Flash Sale! ⚡',   'sub': 'Up to 70% off on selected items',           'url': _Img.banners[1]},
    {'title': 'New Arrivals 🆕',  'sub': 'Fresh styles dropped this week',            'url': _Img.banners[2]},
    {'title': 'Electronics 📱',   'sub': 'Latest gadgets at best prices',             'url': _Img.banners[3]},
    {'title': 'Fashion Week 👗',  'sub': 'Trendy outfits for everyone',               'url': _Img.banners[4]},
    {'title': 'Home & Living 🏠', 'sub': 'Make your home beautiful',                  'url': _Img.banners[5]},
  ];

  @override void dispose() { _pc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final mob = _BP.isMob(context);
    return Stack(children: [
      PageView.builder(
        controller: _pc,
        itemCount: _slides.length,
        onPageChanged: (i) => setState(() => _cur = i),
        itemBuilder: (_, i) {
          final slide = _slides[i];
          return Stack(fit: StackFit.expand, children: [
            Image.network(slide['url']!, fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) => progress == null ? child
                  : Container(color: _C.green.withOpacity(0.1),
                  child: const Center(child: CircularProgressIndicator(color: _C.green, strokeWidth: 2))),
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(gradient: LinearGradient(
                    colors: [_C.darkGreen, Color(0xFFFF6F00)],
                    begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
            ),
            Container(decoration: const BoxDecoration(gradient: LinearGradient(
                colors: [Color(0xCC000000), Colors.transparent, Color(0x66000000)],
                begin: Alignment.bottomCenter, end: Alignment.topCenter))),
            Positioned(
              bottom: 28, left: mob ? 14 : 24, right: mob ? 60 : 80,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, children: [
                    Text(slide['title']!, style: TextStyle(
                        color: Colors.white, fontSize: mob ? 18 : 24, fontWeight: FontWeight.w900,
                        shadows: const [Shadow(blurRadius: 8)])),
                    const SizedBox(height: 4),
                    Text(slide['sub']!, style: TextStyle(
                        color: Colors.white.withOpacity(0.9), fontSize: mob ? 11 : 13,
                        shadows: const [Shadow(blurRadius: 6)])),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [_C.orange, _C.amber]),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Shop Now',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ]),
            ),
          ]);
        },
      ),
      Positioned(bottom: 10, right: 12, child: Row(
        children: List.generate(_slides.length, (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.only(left: 5),
          width: i == _cur ? 18 : 7, height: 7,
          decoration: BoxDecoration(
              color: i == _cur ? Colors.white : Colors.white54,
              borderRadius: BorderRadius.circular(4)),
        )),
      )),
      if (!_BP.isMob(context)) ...[
        Positioned(left: 8, top: 0, bottom: 0, child: Center(child: GestureDetector(
          onTap: () => _pc.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
          child: Container(padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
              child: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 22)),
        ))),
        Positioned(right: 8, top: 0, bottom: 0, child: Center(child: GestureDetector(
          onTap: () => _pc.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
          child: Container(padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.black38, shape: BoxShape.circle),
              child: const Icon(Icons.chevron_right_rounded, color: Colors.white, size: 22)),
        ))),
      ],
    ]);
  }
}

// ══════ Desktop Hero Row ═════════════════════════════════════
class _DesktopHeroRow extends StatelessWidget {
  final void Function([String?]) onCat;
  const _DesktopHeroRow({required this.onCat});

  @override
  Widget build(BuildContext context) {
    final hp = _BP.hp(context);
    return Container(color: _C.white,
      padding: EdgeInsets.fromLTRB(hp, 12, hp, 12),
      child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: _BP.maxW),
        child: LayoutBuilder(builder: (_, c) {
          const sideW = 210.0;
          final bannerW = c.maxWidth - sideW - 12;
          final bannerH = (bannerW / 3.0).clamp(160.0, 300.0);
          return SizedBox(height: bannerH,
            child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              SizedBox(width: sideW, child: _CatSidebar(onCat: onCat)),
              const SizedBox(width: 12),
              Expanded(child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: _BannerSlider(height: bannerH),
              )),
            ]),
          );
        }),
      )),
    );
  }
}

class _CatSidebar extends StatelessWidget {
  final void Function([String?]) onCat;
  const _CatSidebar({required this.onCat});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: _C.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _C.green.withOpacity(0.18))),
    child: Column(children: [
      Container(width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: const BoxDecoration(color: _C.green,
            borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
        child: const Row(children: [
          Icon(Icons.grid_view_rounded, color: Colors.white, size: 15), SizedBox(width: 6),
          Text('All Categories', style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12.5)),
        ]),
      ),
      Expanded(child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _categories.length > 10 ? 10 : _categories.length,
        itemBuilder: (ctx, i) {
          final cat = _categories[i];
          return InkWell(
            onTap: () => onCat(cat['name'] as String),
            hoverColor: _C.green.withOpacity(0.05),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              child: Row(children: [
                ClipOval(child: SizedBox(width: 26, height: 26,
                  child: Image.network(cat['img'] as String, fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                          color: (cat['color'] as Color).withOpacity(0.12),
                          child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 14))),
                )),
                const SizedBox(width: 8),
                Expanded(child: Text(cat['name'] as String,
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11.5, color: _C.slate, fontWeight: FontWeight.w500))),
                const Icon(Icons.chevron_right_rounded, size: 14, color: Colors.grey),
              ]),
            ),
          );
        },
      )),
      InkWell(
        onTap: () => onCat(),
        child: Container(width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: _C.green.withOpacity(0.06),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10))),
          child: const Center(child: Text('See All Categories',
              style: TextStyle(color: _C.green, fontSize: 11.5, fontWeight: FontWeight.w700))),
        ),
      ),
    ]),
  );
}

// ══════ Filter Chips ═════════════════════════════════════════
class _FilterChips extends StatefulWidget {
  @override State<_FilterChips> createState() => _FilterChipsState();
}
class _FilterChipsState extends State<_FilterChips> {
  int _sel = 0;
  static const _chips = [
    ['🔥', 'Popular'], ['✨', 'New Arrivals'], ['💰', 'Budget Picks'],
    ['⚡', 'Flash Deals'], ['🎁', 'Gift Ideas'],
  ];
  @override
  Widget build(BuildContext context) {
    final hp = _BP.hp(context);
    return Container(color: _C.white,
      padding: EdgeInsets.fromLTRB(hp, 8, hp, 8),
      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
        child: Row(children: _chips.asMap().entries.map((e) {
          final sel = _sel == e.key;
          return GestureDetector(
            onTap: () => setState(() => _sel = e.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: sel ? _C.green : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: sel ? _C.green : Colors.grey.shade300),
              ),
              child: Text('${e.value[0]}  ${e.value[1]}',
                  style: TextStyle(
                    color: sel ? Colors.white : _C.slate,
                    fontSize: 12.5,
                    fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                  )),
            ),
          );
        }).toList()),
      ),
    );
  }
}

// ══════ Categories Section ════════════════════════════════════
class _HomeCatSection extends StatelessWidget {
  final void Function(String) onCatTap;
  const _HomeCatSection({required this.onCatTap});

  @override
  Widget build(BuildContext context) {
    final hp   = _BP.hp(context);
    final mob  = _BP.isMob(context);
    final desk = _BP.isDesk(context);
    final sw   = _BP.w(context);

    final iconSz = _BP.catIconSize(context);
    final stripH = iconSz + 44.0;

    int cols;
    if (sw < _BP.mob)       cols = 3;
    else if (sw < 960)      cols = 4;
    else if (sw < _BP.desk) cols = 5;
    else                    cols = 6;

    final gridCats = _categories.take(desk ? 12 : (mob ? 6 : 8)).toList();

    return Container(color: _C.white, margin: const EdgeInsets.only(top: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: EdgeInsets.fromLTRB(hp, 14, hp, 0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(width: 3.5, height: 18,
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [_C.orange, _C.green],
                          begin: Alignment.topCenter, end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(2))),
              const SizedBox(width: 8),
              const Text('Shop by Category',
                  style: TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: _C.slate)),
            ]),
            TextButton.icon(
              onPressed: () => onCatTap(''),
              icon: const Text('View All', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              label: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
              style: TextButton.styleFrom(foregroundColor: _C.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
            ),
          ]),
        ),
        SizedBox(
          height: stripH,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.fromLTRB(hp, 6, hp, 4),
            itemCount: _categories.length,
            itemBuilder: (ctx, i) {
              final cat = _categories[i];
              final itemW = iconSz + 16.0;
              return GestureDetector(
                onTap: () => onCatTap(cat['name'] as String),
                child: SizedBox(
                  width: itemW,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      width: iconSz, height: iconSz,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: _C.green.withOpacity(0.3), width: 2),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08),
                              blurRadius: 6, offset: const Offset(0, 2))]),
                      child: ClipOval(child: Image.network(cat['img'] as String, fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                              color: (cat['color'] as Color).withOpacity(0.12),
                              child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 22)))),
                    ),
                    const SizedBox(height: 5),
                    Flexible(
                      child: Text(cat['name'] as String,
                        textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: mob ? 9.5 : 10,
                            fontWeight: FontWeight.w600, color: _C.slate, height: 1.2),
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        ),
        Padding(padding: EdgeInsets.fromLTRB(hp, 6, hp, 14),
          child: GridView.builder(
            shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                childAspectRatio: mob ? 0.82 : 0.88,
                crossAxisSpacing: 8, mainAxisSpacing: 8),
            itemCount: gridCats.length,
            itemBuilder: (ctx, i) {
              final cat = gridCats[i];
              final color = cat['color'] as Color;
              return GestureDetector(
                onTap: () => onCatTap(cat['name'] as String),
                child: Container(
                  decoration: BoxDecoration(color: _C.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),
                          blurRadius: 6, offset: const Offset(0, 2))]),
                  child: Column(children: [
                    Expanded(child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(cat['img'] as String,
                        width: double.infinity, fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) => progress == null ? child
                            : Container(color: color.withOpacity(0.08),
                            child: Center(child: SizedBox(width: 20, height: 20,
                                child: CircularProgressIndicator(color: color, strokeWidth: 2)))),
                        errorBuilder: (_, __, ___) => Container(
                            color: color.withOpacity(0.1),
                            child: Icon(cat['icon'] as IconData, color: color, size: 32)),
                      ),
                    )),
                    Padding(padding: const EdgeInsets.fromLTRB(6, 5, 6, 6),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min, children: [
                            Text(cat['name'] as String, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w700,
                                    fontSize: mob ? 10.5 : 11.5, color: _C.slate)),
                            const SizedBox(height: 2),
                            Row(children: [
                              Expanded(child: Text('From Rs ${cat['from']}',
                                  style: const TextStyle(color: _C.green, fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis)),
                              Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                  decoration: BoxDecoration(color: _C.orange,
                                      borderRadius: BorderRadius.circular(4)),
                                  child: Text('${cat['items']}', style: const TextStyle(
                                      color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800))),
                            ]),
                          ]),
                    ),
                  ]),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}

// ══════ Section Heading ══════════════════════════════════════
class _SectionHead extends StatelessWidget {
  final String title;
  final VoidCallback onAction;
  const _SectionHead({required this.title, required this.onAction});
  @override
  Widget build(BuildContext context) {
    final hp = _BP.hp(context);
    return Padding(padding: EdgeInsets.fromLTRB(hp, 20, hp, 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Container(width: 3.5, height: 18,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [_C.orange, _C.green],
                      begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800, color: _C.slate)),
        ]),
        TextButton.icon(
          onPressed: onAction,
          icon: const Text('See All', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
          label: const Icon(Icons.arrow_forward_ios_rounded, size: 10),
          style: TextButton.styleFrom(foregroundColor: _C.orange,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
        ),
      ]),
    );
  }
}

// ══════ Flash Sale Header ════════════════════════════════════
class _FlashHeader extends StatefulWidget {
  final VoidCallback onSeeAll;
  const _FlashHeader({required this.onSeeAll});
  @override State<_FlashHeader> createState() => _FlashHeaderState();
}
class _FlashHeaderState extends State<_FlashHeader> {
  int _secs = 9931;
  late final _timer = Stream.periodic(const Duration(seconds: 1)).listen((_) {
    if (mounted && _secs > 0) setState(() => _secs--);
  });
  @override void dispose() { _timer.cancel(); super.dispose(); }

  String get _time {
    final h = _secs ~/ 3600;
    final m = (_secs % 3600) ~/ 60;
    final s = _secs % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final hp = _BP.hp(context);
    return Padding(padding: EdgeInsets.fromLTRB(hp, 18, hp, 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [_C.orange, _C.amber],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(color: _C.orange.withOpacity(0.3),
                blurRadius: 10, offset: const Offset(0, 4))]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(child: Row(children: [
            const Icon(Icons.flash_on_rounded, color: Colors.white, size: 22),
            const SizedBox(width: 6),
            const Text('Flash Sale',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900)),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.22), borderRadius: BorderRadius.circular(6)),
              child: Text(_time, style: const TextStyle(
                  color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1)),
            ),
          ])),
          TextButton(
            onPressed: widget.onSeeAll,
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.2),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: Size.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            child: const Text('See All', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
          ),
        ]),
      ),
    );
  }
}

// ══════ Horizontal Product List ══════════════════════════════
class _HList extends StatelessWidget {
  final List<_Prod> items;
  final VoidCallback onAdd;
  final ValueChanged<_Prod> onTap;
  const _HList({required this.items, required this.onAdd, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final mob = _BP.isMob(context);
    final hp  = _BP.hp(context);
    final cw  = mob ? 130.0 : 150.0;
    return Container(color: _C.white, padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(height: cw + 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(left: hp, right: hp),
          itemCount: items.length,
          itemBuilder: (_, i) => _PCard(
            prod: items[i], cw: cw, gridMode: false,
            onAdd: onAdd, onTap: () => onTap(items[i]),
          ),
        ),
      ),
    );
  }
}

// ══════ Promo Banners ════════════════════════════════════════
class _PromoBanners extends StatelessWidget {
  final VoidCallback onSell;
  const _PromoBanners({required this.onSell});
  @override
  Widget build(BuildContext context) {
    final hp   = _BP.hp(context);
    final desk = _BP.isDesk(context);
    return Padding(padding: EdgeInsets.fromLTRB(hp, 18, hp, 0),
      child: Row(children: [
        _PBanner(title: 'New Arrivals', sub: 'Fresh styles just dropped',
            g1: const Color(0xFF1565C0), g2: const Color(0xFF42A5F5),
            icon: Icons.new_releases_outlined, onTap: () {}),
        const SizedBox(width: 12),
        _PBanner(title: 'Best Sellers', sub: 'Top picks this week',
            g1: const Color(0xFF880E4F), g2: const Color(0xFFEC407A),
            icon: Icons.star_outline_rounded, onTap: () {}),
        if (desk) ...[
          const SizedBox(width: 12),
          _PBanner(title: 'Sell on Cartza', sub: 'Start your business today',
              g1: _C.darkGreen, g2: _C.green, icon: Icons.storefront_outlined, onTap: onSell),
        ],
      ]),
    );
  }
}

class _PBanner extends StatelessWidget {
  final String title, sub; final Color g1, g2; final IconData icon; final VoidCallback onTap;
  const _PBanner({required this.title, required this.sub, required this.g1,
    required this.g2, required this.icon, required this.onTap});
  @override
  Widget build(_) => Expanded(child: InkWell(onTap: onTap, borderRadius: BorderRadius.circular(12),
    child: Container(height: 82, padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [g1, g2], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: g1.withOpacity(0.28), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Row(children: [
        Icon(icon, color: Colors.white.withOpacity(0.9), size: 28), const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
              const SizedBox(height: 2),
              Text(sub, style: TextStyle(color: Colors.white.withOpacity(0.75), fontSize: 10.5)),
            ])),
        const Icon(Icons.chevron_right_rounded, color: Colors.white60, size: 18),
      ]),
    ),
  ));
}

// ══════ Product Grid ══════════════════════════════════════════
class _ProdGrid extends StatelessWidget {
  final List<_Prod> items;
  final VoidCallback onAdd;
  final ValueChanged<_Prod> onTap;
  const _ProdGrid({required this.items, required this.onAdd, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hp = _BP.hp(context);
    final sw = _BP.w(context);
    int cols;
    if (sw < _BP.mob)       cols = 2;
    else if (sw < 960)      cols = 3;
    else if (sw < _BP.desk) cols = 4;
    else if (sw < 1500)     cols = 5;
    else                    cols = 6;

    return Padding(
      padding: EdgeInsets.fromLTRB(hp, 12, hp, 0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          childAspectRatio: 0.72,
          crossAxisSpacing: 12,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) => _PCard(
          prod: items[i],
          cw: double.infinity,
          gridMode: true,
          onAdd: onAdd,
          onTap: () => onTap(items[i]),
        ),
      ),
    );
  }
}

// ══════ Product Card – OVERFLOW FIXED ════════════════════════
class _PCard extends StatefulWidget {
  final _Prod prod;
  final double cw;
  final bool gridMode;
  final VoidCallback onAdd;
  final VoidCallback onTap;
  const _PCard({
    required this.prod, required this.cw, required this.gridMode,
    required this.onAdd, required this.onTap,
  });
  @override State<_PCard> createState() => _PCardState();
}
class _PCardState extends State<_PCard> {
  bool _wish = false, _hov = false;

  @override
  Widget build(BuildContext context) {
    final p   = widget.prod;
    final mob = _BP.isMob(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit:  (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 170),
          width: widget.gridMode ? null : widget.cw,
          margin: widget.gridMode ? EdgeInsets.zero : const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: _C.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [BoxShadow(
              color: _hov ? _C.orange.withOpacity(0.18) : Colors.black.withOpacity(0.06),
              blurRadius: _hov ? 14 : 6,
              offset: const Offset(0, 2),
            )],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image section
                Stack(children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.asset(
                      p.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: _C.green.withOpacity(0.08),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(Icons.image_not_supported_outlined,
                              color: _C.green.withOpacity(0.5), size: 32),
                          const SizedBox(height: 4),
                          Text(p.name,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(fontSize: 9, color: _C.slate.withOpacity(0.6))),
                        ]),
                      ),
                    ),
                  ),
                  if (p.badge.isNotEmpty)
                    Positioned(top: 6, left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: p.badge.contains('NEW') ? _C.green : _C.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(p.badge,
                            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w900)),
                      ),
                    ),
                  Positioned(top: 6, right: 6,
                    child: GestureDetector(
                      onTap: () => setState(() => _wish = !_wish),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)]),
                        child: Icon(
                          _wish ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                          color: _wish ? _C.red : Colors.grey, size: 13,
                        ),
                      ),
                    ),
                  ),
                ]),

                // Info section
                Padding(
                  padding: const EdgeInsets.fromLTRB(7, 5, 7, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        p.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: mob ? 10.0 : 11.0,
                          fontWeight: FontWeight.w700,
                          color: _C.slate,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '★ ${p.rating.toStringAsFixed(1)}  •  ${p.sold} sold',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 9.0, color: _C.star, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rs.${p.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                                color: _C.orange, fontSize: 12.5, fontWeight: FontWeight.w900),
                          ),
                          GestureDetector(
                            onTap: widget.onAdd,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: _C.orange.withOpacity(0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.add_shopping_cart_rounded,
                                  size: 11, color: _C.orange),
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
        ),
      ),
    );
  }
}

// ══════ Flash Sale Full Page ══════════════════════════════════
class _FlashSalePage extends StatelessWidget {
  final List<_Prod> products;
  final ValueChanged<_Prod> onProductTap;
  const _FlashSalePage({required this.products, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        title: const Row(children: [
          Icon(Icons.flash_on_rounded, color: Colors.white, size: 20),
          SizedBox(width: 6),
          Text('Flash Sale', style: TextStyle(fontWeight: FontWeight.w800)),
        ]),
        backgroundColor: _C.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(children: [
        Container(
          color: _C.orange.withOpacity(0.12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(children: [
            const Icon(Icons.timer_outlined, color: _C.orange, size: 16),
            const SizedBox(width: 6),
            const Text('Limited time deals — shop before they expire!',
                style: TextStyle(color: _C.orange, fontWeight: FontWeight.w600, fontSize: 12)),
          ]),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.72,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: products.length,
            itemBuilder: (_, i) => _PCard(
              prod: products[i],
              cw: double.infinity,
              gridMode: true,
              onAdd: () {},
              onTap: () => onProductTap(products[i]),
            ),
          ),
        ),
      ]),
    );
  }
}

// ══════ Recommended Full Page ════════════════════════════════
class _RecommendPage extends StatelessWidget {
  final List<_Prod> products;
  final ValueChanged<_Prod> onProductTap;
  const _RecommendPage({required this.products, required this.onProductTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.bg,
      appBar: AppBar(
        title: const Row(children: [
          Icon(Icons.recommend_outlined, color: Colors.white, size: 20),
          SizedBox(width: 6),
          Text('Recommended for You', style: TextStyle(fontWeight: FontWeight.w800)),
        ]),
        backgroundColor: _C.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (_, i) => _PCard(
          prod: products[i],
          cw: double.infinity,
          gridMode: true,
          onAdd: () {},
          onTap: () => onProductTap(products[i]),
        ),
      ),
    );
  }
}

// ══════ Footer ════════════════════════════════════════════════
class _Footer extends StatelessWidget {
  const _Footer();
  @override
  Widget build(BuildContext context) {
    final mob = _BP.isMob(context);
    return Container(
      decoration: const BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)])),
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
      child: Column(children: [
        mob ? _FooterMobile() : _FooterDesktop(),
        const SizedBox(height: 16),
        Container(height: 0.5, color: _C.green.withOpacity(0.3)),
        Padding(padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Flexible(child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.copyright, color: Colors.white38, size: 12), SizedBox(width: 4),
              Flexible(child: Text('2025 Cartza. All rights reserved.',
                  style: TextStyle(color: Colors.white60, fontSize: 11),
                  overflow: TextOverflow.ellipsis)),
            ])),
            Row(children: [
              const Text('We Accept: ', style: TextStyle(color: Colors.white60, fontSize: 11)),
              ...[Icons.credit_card, Icons.account_balance_wallet, Icons.payment].map((ic) =>
                  Padding(padding: const EdgeInsets.only(left: 6),
                      child: Container(padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.07),
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.white24)),
                          child: Icon(ic, color: Colors.white54, size: 13)))),
            ]),
          ]),
        ),
      ]),
    );
  }
}

class _FooterDesktop extends StatelessWidget {
  @override
  Widget build(_) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: _C.green, borderRadius: BorderRadius.circular(8)),
          child: const Text('CARTZA', style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1.5))),
      const SizedBox(height: 10),
      const Text('Your trusted online shopping\ndestination for quality products.',
          style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.6)),
      const SizedBox(height: 14),
      const Text('Follow Us', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Row(children: [
        _SI(Icons.facebook,   const Color(0xFF1877F2)),
        _SI(Icons.chat,       const Color(0xFF25D366)),
        _SI(Icons.camera_alt, const Color(0xFFE4405F)),
        _SI(Icons.play_arrow, const Color(0xFFFF0000)),
      ]),
    ])),
    const SizedBox(width: 24),
    Expanded(child: _FC('Shop',          ['New Arrivals', 'Best Sellers', 'Flash Sale', 'Categories', 'Deals'])),
    Expanded(child: _FC('Customer Care', ['Contact Us', 'Help Center', 'Track Order', 'Returns', 'Shipping'])),
    Expanded(child: _FC('Company',       ['About Us', 'Careers', 'Privacy Policy', 'Terms', 'Cookies'])),
    Expanded(flex: 2, child: _NL()),
  ]);
}

class _FooterMobile extends StatelessWidget {
  @override
  Widget build(_) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: _C.green, borderRadius: BorderRadius.circular(8)),
        child: const Text('CARTZA', style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.w900, fontSize: 15))),
    const SizedBox(height: 10),
    const Text('Your trusted online shopping destination.',
        style: TextStyle(color: Colors.white60, fontSize: 11.5)),
    const SizedBox(height: 12),
    Row(children: [
      _SI(Icons.facebook,   const Color(0xFF1877F2)),
      _SI(Icons.chat,       const Color(0xFF25D366)),
      _SI(Icons.camera_alt, const Color(0xFFE4405F)),
      _SI(Icons.play_arrow, const Color(0xFFFF0000)),
    ]),
    const SizedBox(height: 16),
    Wrap(spacing: 8, runSpacing: 8,
        children: ['Shop', 'Track', 'Contact', 'About', 'Privacy', 'Terms'].map((t) =>
            InkWell(onTap: () {}, child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: _C.green.withOpacity(0.25))),
                child: Text(t, style: const TextStyle(color: Colors.white60, fontSize: 11))))).toList()),
    const SizedBox(height: 16),
    _NL(),
  ]);
}

class _FC extends StatelessWidget {
  final String title; final List<String> links;
  const _FC(this.title, this.links);
  @override
  Widget build(_) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5)),
    const SizedBox(height: 10),
    ...links.map((l) => Padding(padding: const EdgeInsets.only(bottom: 7),
        child: InkWell(onTap: () {}, child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.arrow_right_rounded, size: 13, color: _C.green.withOpacity(0.65)),
          const SizedBox(width: 3),
          Text(l, style: const TextStyle(color: Colors.white60, fontSize: 11.5)),
        ])))),
    const SizedBox(height: 24),
  ]);
}

class _NL extends StatelessWidget {
  @override
  Widget build(_) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('Newsletter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5)),
    const SizedBox(height: 8),
    const Text('Get special offers & updates', style: TextStyle(color: Colors.white60, fontSize: 11.5)),
    const SizedBox(height: 10),
    Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _C.green.withOpacity(0.28))),
      child: TextField(
        style: const TextStyle(color: Colors.white, fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Enter your email',
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          suffixIcon: Container(margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: _C.green, borderRadius: BorderRadius.circular(6)),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 15)),
        ),
      ),
    ),
    const SizedBox(height: 10),
    const Row(children: [
      Icon(Icons.lock_outline, color: _C.green, size: 13), SizedBox(width: 5),
      Text('Secure Shopping', style: TextStyle(color: Colors.white60, fontSize: 11)),
    ]),
  ]);
}

class _SI extends StatelessWidget {
  final IconData icon; final Color color;
  const _SI(this.icon, this.color);
  @override
  Widget build(_) => Padding(padding: const EdgeInsets.only(right: 8),
      child: InkWell(onTap: () {}, child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)),
          child: Icon(icon, color: Colors.white, size: 14))));
}
