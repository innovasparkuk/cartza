// product_detail_page.dart — FULLY RESPONSIVE (mobile → desktop)
// FIX: MediaQuery applied via getter in build(); no _screenWidth field
// FIX: Action buttons (Add to Cart / Buy Now) reduced in size
// FIX: Bottom bar buttons reduced in size
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

class Product1 {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? originalPrice;
  final int? discountPercentage;
  final String description;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final Map<String, String> specifications;

  const Product1({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    this.originalPrice,
    this.discountPercentage,
    required this.description,
    required this.images,
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.specifications,
  });
}

Widget _clickable({
  required Widget child,
  required VoidCallback? onTap,
  bool forbidden = false,
}) {
  return MouseRegion(
    cursor: forbidden
        ? SystemMouseCursors.forbidden
        : (onTap != null ? SystemMouseCursors.click : MouseCursor.defer),
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: child,
    ),
  );
}

class ModernProductDetailPage extends StatefulWidget {
  final Product1 product;
  final void Function(Product1)? onAddToCart;

  const ModernProductDetailPage({
    super.key,
    required this.product,
    this.onAddToCart,
  });

  @override
  State<ModernProductDetailPage> createState() =>
      _ModernProductDetailPageState();
}

class _ModernProductDetailPageState extends State<ModernProductDetailPage>
    with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  int _quantity = 1;
  String _selectedColor = 'Black';
  String _selectedSize = 'M';
  bool _isFavorite = false;
  bool _descExpanded = false;
  int _tabIndex = 0;
  late TabController _tabController;
  final PageController _pageController = PageController();

  static const double _kWide = 900;
  static const double _kMid = 600;

  final List<String> _colors = ['Black', 'White', 'Blue', 'Red', 'Green'];
  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];

  static const Map<String, Color> _colorMap = {
    'Black': Color(0xFF212121),
    'White': Color(0xFFEEEEEE),
    'Blue': Color(0xFF1565C0),
    'Red': Color(0xFFC62828),
    'Green': Color(0xFF2E7D32),
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          setState(() => _tabIndex = _tabController.index);
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  double get _screenWidth => MediaQuery.sizeOf(context).width;

  @override
  Widget build(BuildContext context) {
    final w = _screenWidth;
    final isWide = w >= _kWide;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: isWide ? null : _buildAppBar(),
      bottomNavigationBar: isWide ? null : _buildBottomBar(w),
      body: isWide
          ? _buildWideLayout(context, w)
          : _buildNarrowLayout(context, w),
    );
  }

  // ─────────────────────────── WIDE LAYOUT (≥900) ───────────────────────────
  Widget _buildWideLayout(BuildContext context, double w) {
    final hPad = w >= 1200 ? 40.0 : 24.0;
    return CustomScrollView(
      slivers: [
        _buildAppBarSliver(),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(hPad),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(children: [
                    _buildImagePanel(isWide: true, w: w),
                    const SizedBox(height: 16),
                    _buildDeliveryCard(),
                  ]),
                ),
                const SizedBox(width: 28),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoCard(w),
                      const SizedBox(height: 16),
                      _buildColorSelectorCard(),
                      const SizedBox(height: 16),
                      _buildSizeSelectorCard(),
                      const SizedBox(height: 16),
                      _buildQuantityCard(),
                      const SizedBox(height: 20),
                      _buildActionButtonsRow(context),
                      const SizedBox(height: 24),
                      _buildTabsCard(isWide: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─────────────────────── NARROW LAYOUT (<900) ────────────────────────────
  Widget _buildNarrowLayout(BuildContext context, double w) {
    final hPad = w < _kMid ? 12.0 : 16.0;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImagePanel(isWide: false, w: w),
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 14, hPad, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoCard(w),
                const SizedBox(height: 12),
                _buildColorSelectorCard(),
                const SizedBox(height: 12),
                _buildSizeSelectorCard(),
                const SizedBox(height: 12),
                _buildDeliveryCard(),
                const SizedBox(height: 12),
                _buildTabsCard(isWide: false),
                const SizedBox(height: 120),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      toolbarHeight: 56,
      leading: _appBarIconBtn(
        icon: Icons.arrow_back_rounded,
        onTap: () => Navigator.maybePop(context),
        tooltip: 'Go Back',
      ),
      centerTitle: true,
      title: const Text(
        'Product Details',
        style: TextStyle(
          color: Color(0xFF1A1A2E),
          fontWeight: FontWeight.w800,
          fontSize: 17,
        ),
      ),
      actions: [
        _wishlistBtn(),
        _appBarIconBtn(
          icon: Icons.share_outlined,
          onTap: () {},
          tooltip: 'Share',
          margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
        ),
      ],
    );
  }

  SliverAppBar _buildAppBarSliver() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      toolbarHeight: 56,
      leading: _appBarIconBtn(
        icon: Icons.arrow_back_rounded,
        onTap: () => Navigator.maybePop(context),
        tooltip: 'Go Back',
      ),
      centerTitle: true,
      title: const Text(
        'Product Details',
        style: TextStyle(
          color: Color(0xFF1A1A2E),
          fontWeight: FontWeight.w800,
          fontSize: 17,
        ),
      ),
      actions: [
        _wishlistBtn(),
        _appBarIconBtn(
          icon: Icons.share_outlined,
          onTap: () {},
          tooltip: 'Share',
          margin: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
        ),
      ],
    );
  }

  Widget _wishlistBtn() {
    return Tooltip(
      message: _isFavorite ? 'Remove from Wishlist' : 'Add to Wishlist',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          decoration: BoxDecoration(
            color:
            _isFavorite ? Colors.red.shade50 : const Color(0xFFF4F6F8),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isFavorite
                  ? Colors.red.shade200
                  : Colors.grey.shade200,
            ),
          ),
          child: IconButton(
            iconSize: 20,
            padding: const EdgeInsets.all(6),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.grey.shade500,
              size: 20,
            ),
            onPressed: () => setState(() => _isFavorite = !_isFavorite),
          ),
        ),
      ),
    );
  }

  Widget _appBarIconBtn({
    required IconData icon,
    required VoidCallback onTap,
    String tooltip = '',
    Color color = Colors.white,
    Color bg = const Color(0xFF2E7D32),
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
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4CAF50).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
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

  Widget _buildImagePanel({required bool isWide, required double w}) {
    final images = widget.product.images;
    double height;
    if (isWide) {
      height = w >= 1200 ? 480 : 400;
    } else {
      height = w < _kMid ? 260 : 320;
    }
    final borderRadius = isWide
        ? BorderRadius.circular(20)
        : const BorderRadius.only(
      bottomLeft: Radius.circular(28),
      bottomRight: Radius.circular(28),
    );
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Stack(children: [
          images.isEmpty
              ? _imagePlaceholder()
              : PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (i) =>
                setState(() => _currentImageIndex = i),
            itemBuilder: (ctx, i) => Padding(
              padding: EdgeInsets.all(w < _kMid ? 14 : 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  images[i],
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) => _imagePlaceholder(),
                ),
              ),
            ),
          ),
          if (widget.product.discountPercentage != null)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    Color(0xFFFF6F00),
                    Color(0xFFFF8F00),
                  ]),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF6F00).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  '-${widget.product.discountPercentage}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          if (images.length > 1)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (i) {
                  final active = i == _currentImageIndex;
                  return GestureDetector(
                    onTap: () => _pageController.animateToPage(i,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: active ? 20 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: active
                            ? const Color(0xFF2E7D32)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
          if (isWide && images.length > 1)
            Positioned(
              left: 10,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                      (i) => _ThumbnailButton(
                    imagePath: images[i],
                    active: i == _currentImageIndex,
                    onTap: () {
                      _pageController.animateToPage(i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut);
                      setState(() => _currentImageIndex = i);
                    },
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
    color: Colors.grey.shade50,
    child: Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.image_outlined, size: 60, color: Colors.grey.shade300),
        const SizedBox(height: 8),
        Text('No Image',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13)),
      ]),
    ),
  );

  Widget _buildInfoCard(double w) {
    final p = widget.product;
    final bool small = w < _kMid;
    return _card(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _pill(p.brand, const Color(0xFF2E7D32), const Color(0xFFF4F6F8)),
          _clickable(
            onTap: () => _tabController.animateTo(2),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                const SizedBox(width: 4),
                Text('${p.rating}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E),
                        fontSize: 12)),
                Text(' (${p.reviewCount})',
                    style: TextStyle(
                        fontSize: 11, color: Colors.grey.shade500)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 10, color: Colors.amber),
              ]),
            ),
          ),
        ]),
        const SizedBox(height: 10),
        Text(p.name,
            style: TextStyle(
                fontSize: small ? 16 : 18,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF1A1A2E),
                height: 1.3)),
        const SizedBox(height: 12),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          runSpacing: 6,
          children: [
            Text('Rs ${p.price.toStringAsFixed(0)}',
                style: TextStyle(
                    fontSize: small ? 20 : 22,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF2E7D32))),
            if (p.originalPrice != null)
              Text('Rs ${p.originalPrice!.toStringAsFixed(0)}',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w500)),
            if (p.discountPercentage != null)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFFF6F00).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8)),
                child: Text('${p.discountPercentage}% OFF',
                    style: const TextStyle(
                        color: Color(0xFFFF6F00),
                        fontSize: 11,
                        fontWeight: FontWeight.w800)),
              ),
          ],
        ),
        if (p.originalPrice != null) ...[
          const SizedBox(height: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.06),
                borderRadius: BorderRadius.circular(10)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.savings_outlined,
                  size: 14, color: Color(0xFF2E7D32)),
              const SizedBox(width: 6),
              Text(
                  'You save Rs ${(p.originalPrice! - p.price).toStringAsFixed(0)}',
                  style: const TextStyle(
                      color: Color(0xFF2E7D32),
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
            ]),
          ),
        ],
      ]),
    );
  }

  Widget _buildColorSelectorCard() => _card(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel('Color', _selectedColor),
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _colors.length,
              itemBuilder: (_, i) {
                final c = _colors[i];
                return _ColorChip(
                  color: c,
                  dotColor: _colorMap[c] ?? Colors.grey,
                  selected: _selectedColor == c,
                  onTap: () => setState(() => _selectedColor = c),
                );
              },
            ),
          ),
        ]),
  );

  Widget _buildSizeSelectorCard() => _card(
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _sectionLabel('Size', _selectedSize),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: TextButton(
                    onPressed: _showSizeGuide,
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: const Text('Size Guide →',
                        style: TextStyle(
                            color: Color(0xFFFF6F00),
                            fontSize: 12,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _sizes.length,
              itemBuilder: (_, i) {
                final s = _sizes[i];
                return _SizeChip(
                  size: s,
                  selected: _selectedSize == s,
                  onTap: () => setState(() => _selectedSize = s),
                );
              },
            ),
          ),
        ]),
  );

  Widget _buildQuantityCard() => _card(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Quantity',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E))),
        Container(
          decoration: BoxDecoration(
              color: const Color(0xFFF4F6F8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200)),
          child: Row(children: [
            _qtyButton(Icons.remove_rounded, () {
              if (_quantity > 1) setState(() => _quantity--);
            }, enabled: _quantity > 1),
            SizedBox(
              width: 36,
              child: Center(
                child: Text('$_quantity',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: Color(0xFF1A1A2E))),
              ),
            ),
            _qtyButton(Icons.add_rounded, () => setState(() => _quantity++),
                enabled: true),
          ]),
        ),
      ],
    ),
  );

  Widget _qtyButton(IconData icon, VoidCallback onTap,
      {required bool enabled}) {
    return MouseRegion(
      cursor: enabled
          ? SystemMouseCursors.click
          : SystemMouseCursors.forbidden,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: enabled
                  ? const Color(0xFF2E7D32)
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard() => _card(
    child: Column(children: [
      _deliveryRow(Icons.local_shipping_outlined,
          const Color(0xFF2E7D32), 'Free Delivery', 'On orders above Rs 2000'),
      const Divider(height: 16),
      _deliveryRow(Icons.replay_outlined, const Color(0xFFFF6F00),
          'Easy Returns', '7-day hassle-free return policy'),
      const Divider(height: 16),
      _deliveryRow(Icons.verified_user_outlined, Colors.blue.shade700,
          'Genuine Product', '100% authentic guarantee'),
    ]),
  );

  Widget _deliveryRow(
      IconData icon, Color color, String title, String sub) =>
      Row(children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Color(0xFF1A1A2E))),
                Text(sub,
                    style:
                    TextStyle(fontSize: 11, color: Colors.grey.shade500)),
              ]),
        ),
      ]);

  Widget _buildTabsCard({required bool isWide}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: const Color(0xFF2E7D32),
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: const Color(0xFF2E7D32),
            indicatorWeight: 3,
            labelStyle:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
            mouseCursor: SystemMouseCursors.click,
            tabs: const [
              Tab(text: 'Description'),
              Tab(text: 'Specs'),
              Tab(text: 'Reviews'),
            ],
          ),
          isWide
              ? SizedBox(
            height: 240,
            child: TabBarView(
              controller: _tabController,
              children: [
                _descScrollable(),
                _specsScrollable(),
                _reviewsScrollable(),
              ],
            ),
          )
              : AnimatedBuilder(
            animation: _tabController,
            builder: (_, __) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: KeyedSubtree(
                key: ValueKey(_tabIndex),
                child: _tabIntrinsicContent(_tabIndex),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabIntrinsicContent(int index) {
    switch (index) {
      case 0:
        return Padding(
            padding: const EdgeInsets.all(16), child: _descContent());
      case 1:
        return Padding(
            padding: const EdgeInsets.all(16), child: _specsContent());
      default:
        return Padding(
            padding: const EdgeInsets.all(16), child: _reviewContent());
    }
  }

  Widget _descScrollable() =>
      SingleChildScrollView(padding: const EdgeInsets.all(16), child: _descContent());

  Widget _specsScrollable() {
    final specs = widget.product.specifications;
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: specs.length,
      separatorBuilder: (_, __) =>
          Divider(color: Colors.grey.shade100, height: 1),
      itemBuilder: (_, i) {
        final e = specs.entries.elementAt(i);
        return _specRow(e.key, e.value);
      },
    );
  }

  Widget _reviewsScrollable() =>
      SingleChildScrollView(padding: const EdgeInsets.all(16), child: _reviewContent());

  Widget _descContent() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        widget.product.description.isEmpty
            ? 'No description available.'
            : widget.product.description,
        maxLines: _descExpanded ? null : 4,
        overflow: _descExpanded ? null : TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: 13, color: Colors.grey.shade700, height: 1.65),
      ),
      const SizedBox(height: 8),
      GestureDetector(
        onTap: () => setState(() => _descExpanded = !_descExpanded),
        child: Text(
          _descExpanded ? 'Show less ↑' : 'Read more ↓',
          style: const TextStyle(
              color: Color(0xFF2E7D32),
              fontWeight: FontWeight.w700,
              fontSize: 12),
        ),
      ),
    ],
  );

  Widget _specsContent() {
    final specs = widget.product.specifications;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: specs.entries
          .map((e) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: _specRow(e.key, e.value),
      ))
          .toList(),
    );
  }

  Widget _specRow(String key, String value) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 110,
        child: Text(key,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey.shade500)),
      ),
      Expanded(
        child: Text(value,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E))),
      ),
    ],
  );

  Widget _reviewContent() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(children: [
        Text('${widget.product.rating}',
            style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A1A2E))),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
              children: List.generate(
                  5,
                      (i) => Icon(
                    i < widget.product.rating.floor()
                        ? Icons.star_rounded
                        : Icons.star_border_rounded,
                    color: Colors.amber,
                    size: 18,
                  ))),
          const SizedBox(height: 4),
          Text('${widget.product.reviewCount} reviews',
              style:
              TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        ]),
      ]),
      const SizedBox(height: 12),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero, minimumSize: Size.zero),
        child: const Text('See all reviews →',
            style: TextStyle(
                color: Color(0xFF2E7D32),
                fontWeight: FontWeight.w700,
                fontSize: 13)),
      ),
    ],
  );

  // ── Action buttons — SMALLER (vertical padding 10, font 13) ──────────────
  Widget _buildActionButtonsRow(BuildContext context) =>
      Row(children: [
        Expanded(
          child: _HoverButton(
            isOutlined: true,
            label: 'Add to Cart',
            icon: Icons.add_shopping_cart_rounded,
            onTap: () {
              widget.onAddToCart?.call(widget.product);
              _showSnack(context, '${widget.product.name} added to cart!',
                  const Color(0xFF2E7D32));
            },
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _HoverButton(
            isOutlined: false,
            label: 'Buy Now',
            onTap: () {
              widget.onAddToCart?.call(widget.product);
              Navigator.pop(context);
              _showSnack(context, 'Proceeding to checkout...',
                  const Color(0xFFFF6F00));
            },
          ),
        ),
      ]);

  // ── Bottom bar — SMALLER buttons ──────────────────────────────────────────
  Widget _buildBottomBar(double w) {
    final small = w < _kMid;
    return Container(
      padding: EdgeInsets.fromLTRB(small ? 12 : 16, 8, small ? 12 : 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF4F6F8),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              _qtyButton(Icons.remove_rounded, () {
                if (_quantity > 1) setState(() => _quantity--);
              }, enabled: _quantity > 1),
              SizedBox(
                width: small ? 28 : 32,
                child: Center(
                  child: Text('$_quantity',
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Color(0xFF1A1A2E))),
                ),
              ),
              _qtyButton(Icons.add_rounded, () => setState(() => _quantity++),
                  enabled: true),
            ]),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                widget.onAddToCart?.call(widget.product);
                _showSnack(context, '${widget.product.name} added!',
                    const Color(0xFF2E7D32));
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF2E7D32),
                side: const BorderSide(color: Color(0xFF2E7D32), width: 2),
                // ── smaller vertical padding ──
                padding: EdgeInsets.symmetric(vertical: small ? 5 : 7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: Icon(Icons.add_shopping_cart_rounded,
                  size: small ? 13 : 15),
              label: Text(small ? 'Cart' : 'Add to Cart',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: small ? 10 : 11)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                widget.onAddToCart?.call(widget.product);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                foregroundColor: Colors.white,
                // ── smaller vertical padding ──
                padding: EdgeInsets.symmetric(vertical: small ? 5 : 7),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text('Buy Now',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: small ? 11 : 12)),
            ),
          ),
        ]),
      ),
    );
  }

  void _showSizeGuide() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            const Text('Size Guide',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 12),
            Table(
              border: TableBorder.all(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8)),
              children: [
                _tableRow(['Size', 'Chest (in)', 'Waist (in)'],
                    isHeader: true),
                _tableRow(['XS', '32–34', '26–28']),
                _tableRow(['S', '34–36', '28–30']),
                _tableRow(['M', '36–38', '30–32']),
                _tableRow(['L', '38–40', '32–34']),
                _tableRow(['XL', '40–42', '34–36']),
                _tableRow(['XXL', '42–44', '36–38']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: BoxDecoration(
          color: isHeader
              ? const Color(0xFF2E7D32).withOpacity(0.08)
              : null),
      children: cells
          .map((c) => Padding(
        padding:
        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Text(c,
            style: TextStyle(
                fontWeight:
                isHeader ? FontWeight.w800 : FontWeight.w500,
                fontSize: 12,
                color: isHeader
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFF1A1A2E))),
      ))
          .toList(),
    );
  }

  Widget _card({required Widget child, EdgeInsets? padding}) => Container(
    width: double.infinity,
    padding: padding ?? const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 4))
      ],
    ),
    child: child,
  );

  Widget _pill(String text, Color textColor, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200)),
    child: Text(text,
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w700, color: textColor)),
  );

  Widget _sectionLabel(String label, String value) => Row(children: [
    Text(label,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A2E))),
    const SizedBox(width: 8),
    Text('— $value',
        style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade500)),
  ]);

  void _showSnack(BuildContext ctx, String msg, Color color) {
    ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: color,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

// ─── Thumbnail button ─────────────────────────────────────────────────────────
class _ThumbnailButton extends StatefulWidget {
  final String imagePath;
  final bool active;
  final VoidCallback onTap;
  const _ThumbnailButton(
      {required this.imagePath, required this.active, required this.onTap});
  @override
  State<_ThumbnailButton> createState() => _ThumbnailButtonState();
}

class _ThumbnailButtonState extends State<_ThumbnailButton> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(vertical: 4),
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.active
                  ? const Color(0xFF2E7D32)
                  : (_hovered
                  ? const Color(0xFF4CAF50)
                  : Colors.grey.shade200),
              width: widget.active ? 2 : 1,
            ),
            boxShadow: (widget.active || _hovered)
                ? [
              BoxShadow(
                  color: const Color(0xFF2E7D32).withOpacity(0.2),
                  blurRadius: 6)
            ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(widget.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade100)),
          ),
        ),
      ),
    );
  }
}

// ─── Color chip ───────────────────────────────────────────────────────────────
class _ColorChip extends StatefulWidget {
  final String color;
  final Color dotColor;
  final bool selected;
  final VoidCallback onTap;
  const _ColorChip(
      {required this.color,
        required this.dotColor,
        required this.selected,
        required this.onTap});
  @override
  State<_ColorChip> createState() => _ColorChipState();
}

class _ColorChipState extends State<_ColorChip> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.selected
                ? const Color(0xFF2E7D32)
                : (_hovered ? const Color(0xFFF1F8E9) : Colors.white),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.selected
                  ? const Color(0xFF2E7D32)
                  : (_hovered
                  ? const Color(0xFF4CAF50)
                  : Colors.grey.shade200),
              width: 2,
            ),
            boxShadow: (widget.selected || _hovered)
                ? [
              BoxShadow(
                  color: const Color(0xFF2E7D32).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3))
            ]
                : [],
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: widget.dotColor,
                shape: BoxShape.circle,
                border: Border.all(
                    color: widget.selected
                        ? Colors.white
                        : Colors.grey.shade300,
                    width: 1.5),
              ),
            ),
            const SizedBox(width: 6),
            Text(widget.color,
                style: TextStyle(
                    color: widget.selected
                        ? Colors.white
                        : const Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w600,
                    fontSize: 13)),
          ]),
        ),
      ),
    );
  }
}

// ─── Size chip ────────────────────────────────────────────────────────────────
class _SizeChip extends StatefulWidget {
  final String size;
  final bool selected;
  final VoidCallback onTap;
  const _SizeChip(
      {required this.size, required this.selected, required this.onTap});
  @override
  State<_SizeChip> createState() => _SizeChipState();
}

class _SizeChipState extends State<_SizeChip> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 50,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: widget.selected
                ? const Color(0xFF2E7D32)
                : (_hovered ? const Color(0xFFF1F8E9) : Colors.white),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.selected
                  ? const Color(0xFF2E7D32)
                  : (_hovered
                  ? const Color(0xFF4CAF50)
                  : Colors.grey.shade200),
              width: 2,
            ),
            boxShadow: (widget.selected || _hovered)
                ? [
              BoxShadow(
                  color: const Color(0xFF2E7D32).withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 3))
            ]
                : [],
          ),
          child: Center(
            child: Text(widget.size,
                style: TextStyle(
                    color: widget.selected
                        ? Colors.white
                        : const Color(0xFF1A1A2E),
                    fontWeight: FontWeight.w700,
                    fontSize: 14)),
          ),
        ),
      ),
    );
  }
}

// ─── Hover button — reduced vertical padding ──────────────────────────────────
class _HoverButton extends StatefulWidget {
  final bool isOutlined;
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  const _HoverButton(
      {required this.isOutlined,
        required this.label,
        this.icon,
        required this.onTap});
  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hovered = false;
  bool _pressed = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        onTapCancel: () => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          transform: Matrix4.identity()..scale(_pressed ? 0.97 : 1.0),
          // ── was 14 → now 10 for noticeably smaller buttons ──
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: widget.isOutlined
                ? Colors.white
                : (_hovered
                ? const Color(0xFF1B5E20)
                : const Color(0xFF2E7D32)),
            borderRadius: BorderRadius.circular(14),
            border: widget.isOutlined
                ? Border.all(
                color: _hovered
                    ? const Color(0xFF1B5E20)
                    : const Color(0xFF2E7D32),
                width: 2)
                : null,
            boxShadow: _hovered
                ? [
              BoxShadow(
                  color: const Color(0xFF2E7D32).withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4))
            ]
                : [],
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon,
                      size: 16,
                      color: widget.isOutlined
                          ? const Color(0xFF2E7D32)
                          : Colors.white),
                  const SizedBox(width: 6),
                ],
                Text(widget.label,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 12, // ── was 15
                        color: widget.isOutlined
                            ? const Color(0xFF2E7D32)
                            : Colors.white)),
              ]),
        ),
      ),
    );
  }
}