import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'shopcreatepage.dart';

const double _kMaxContentWidth = 1000.0;

class CartzaPage extends StatefulWidget {
  const CartzaPage({super.key});

  @override
  State<CartzaPage> createState() => _CartzaPageState();
}

class _CartzaPageState extends State<CartzaPage> with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _stepsController;
  late Animation<double> _heroFade;
  late Animation<Offset> _heroSlide;
  late Animation<double> _stepsFade;

  bool _btnHovered = false;

  final List<ShopModel> _myShops = [];
  ShopModel? _activeShop;

  @override
  void initState() {
    super.initState();
    _heroController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _stepsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _heroFade = CurvedAnimation(parent: _heroController, curve: Curves.easeOut);
    _heroSlide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _heroController, curve: Curves.easeOut));
    _stepsFade = CurvedAnimation(parent: _stepsController, curve: Curves.easeOut);
    _heroController.forward();
    Future.delayed(const Duration(milliseconds: 300), () => _stepsController.forward());
  }

  @override
  void dispose() {
    _heroController.dispose();
    _stepsController.dispose();
    super.dispose();
  }

  void _goToCreateShop() async {
    final result = await Navigator.push<ShopModel>(
      context,
      MaterialPageRoute(builder: (_) => const Shopcreatepage()),
    );
    if (result != null) {
      setState(() {
        _myShops.add(result);
        _activeShop = result;
      });
    }
  }

  void _closeShopDashboard() {
    setState(() => _activeShop = null);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F8),
        appBar: _buildAppBar(),
        body: _activeShop != null
            ? _buildShopDashboard()
            : _buildLandingBody(),
      ),
    );
  }

  // ── AppBar — fully centered, never stretches ───────────────────────────────
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      // Keep leading null so we control it inside titleWidget
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
          child: Row(
            children: [
              // Back button
              Tooltip(
                message: _activeShop != null ? 'Back' : 'Go Back',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF4CAF50).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.arrow_back_rounded,
                          color: Colors.white, size: 20),
                      onPressed: () {
                        if (_activeShop != null) {
                          _closeShopDashboard();
                        } else {
                          Navigator.maybePop(context);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Brand pill
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Cartza',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                        letterSpacing: 0.4)),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  _activeShop != null ? _activeShop!.name : 'Seller Hub',
                  style: const TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Cart button
              Tooltip(
                message: 'Cart',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF4CAF50).withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2))
                      ],
                    ),
                    child: IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.shopping_cart_outlined,
                          color: Colors.white, size: 20),
                      onPressed: () {},
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

  // ── Landing body ───────────────────────────────────────────────────────────
  Widget _buildLandingBody() {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final isWide = w >= 700;
              final isMid = w >= 500;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeroSection(w, isWide, isMid),
                  if (_myShops.isNotEmpty) ...[
                    _buildInlineShopsSection(w, isWide, isMid),
                    const SizedBox(height: 40),
                  ] else ...[
                    _buildBenefitsSection(w, isWide, isMid),
                    _buildStatsBanner(w, isMid),
                    _buildCTASection(w, isMid),
                    const SizedBox(height: 40),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ── Inline Shops Section ───────────────────────────────────────────────────
  Widget _buildInlineShopsSection(double w, bool isWide, bool isMid) {
    const hPad = 16.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(hPad, 28, hPad, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(width: 10),
            Text(
              'My Shops (${_myShops.length})',
              style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Color(0xFF1A1A2E)),
            ),
            const Spacer(),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                onPressed: _goToCreateShop,
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Shop',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 18),
          isWide ? _buildShopsGrid() : _buildShopsList(),
        ],
      ),
    );
  }

  Widget _buildShopsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 340,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.5,
      ),
      itemCount: _myShops.length,
      itemBuilder: (_, i) => _ShopCard(
        shop: _myShops[i],
        onTap: () => setState(() => _activeShop = _myShops[i]),
      ),
    );
  }

  Widget _buildShopsList() {
    return Column(
      children: _myShops
          .map((shop) => Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: _ShopCard(
          shop: shop,
          onTap: () => setState(() => _activeShop = shop),
        ),
      ))
          .toList(),
    );
  }

  // ── Shop Dashboard ─────────────────────────────────────────────────────────
  Widget _buildShopDashboard() {
    final shop = _activeShop!;
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kMaxContentWidth),
          child: LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 600;
            return Padding(
              padding: EdgeInsets.all(isWide ? 28 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Shop header card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: const Color(0xFF2E7D32).withOpacity(0.3),
                            blurRadius: 16,
                            offset: const Offset(0, 6))
                      ],
                    ),
                    child: Row(children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.storefront_rounded,
                            color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(shop.name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18)),
                              const SizedBox(height: 4),
                              Text(
                                  shop.description.isEmpty
                                      ? 'No description'
                                      : shop.description,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 12,
                                      height: 1.4),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text('● Live',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ]),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 20),

                  // Stats row
                  Row(children: [
                    Expanded(
                      child: _dashStat(
                          '${shop.products.length}',
                          'Total Products',
                          Icons.inventory_2_outlined,
                          const Color(0xFF2E7D32)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _dashStat(
                          '${shop.products.where((p) => p.published).length}',
                          'Published',
                          Icons.public,
                          const Color(0xFF1565C0)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _dashStat(
                          '${shop.products.where((p) => !p.published).length}',
                          'Drafts',
                          Icons.public_off_outlined,
                          const Color(0xFFFF6F00)),
                    ),
                  ]),
                  const SizedBox(height: 20),

                  // Products section
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Container(
                                width: 3,
                                height: 18,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF4CAF50),
                                    borderRadius: BorderRadius.circular(3))),
                            const SizedBox(width: 8),
                            const Icon(Icons.inventory_2_outlined,
                                size: 16, color: Color(0xFF2E7D32)),
                            const SizedBox(width: 6),
                            Text(
                                'Products (${_activeShop!.products.length})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                    color: Color(0xFF1A1A2E))),
                            const Spacer(),
                            if (_activeShop!.products.isNotEmpty)
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: OutlinedButton.icon(
                                  onPressed: _publishAllDashboard,
                                  icon: const Icon(Icons.public, size: 14),
                                  label: const Text('Publish All',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11)),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF1565C0),
                                    side: const BorderSide(
                                        color: Color(0xFF1565C0)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: ElevatedButton.icon(
                                onPressed: _addMoreProducts,
                                icon: const Icon(Icons.add, size: 16),
                                label: const Text('Add More',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E7D32),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ]),
                          if (_activeShop!.products.isEmpty) ...[
                            const SizedBox(height: 24),
                            Center(
                              child: Column(children: [
                                Icon(Icons.inventory_2_outlined,
                                    size: 44, color: Colors.grey.shade300),
                                const SizedBox(height: 8),
                                Text('No products yet',
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(height: 4),
                                Text(
                                    'Tap "Add More" to add your first product',
                                    style: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: 11)),
                                const SizedBox(height: 16),
                              ]),
                            ),
                          ] else ...[
                            const SizedBox(height: 14),
                            ..._activeShop!.products.asMap().entries.map(
                                    (entry) {
                                  final index = entry.key;
                                  final product = entry.value;
                                  return _DashProductTile(
                                    product: product,
                                    onTogglePublish: () {
                                      setState(() =>
                                      product.published = !product.published);
                                    },
                                    onDelete: () {
                                      setState(() =>
                                          _activeShop!.products.removeAt(index));
                                    },
                                  );
                                }),
                          ],
                        ]),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _dashStat(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 3))
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                color: color, fontSize: 22, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
            textAlign: TextAlign.center),
      ]),
    );
  }

  void _publishAllDashboard() {
    setState(() {
      for (final p in _activeShop!.products) {
        p.published = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('All products published!'),
      backgroundColor: const Color(0xFF2E7D32),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _addMoreProducts() => _showAddProductDialog();

  void _showAddProductDialog() {
    final nameCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final stockCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 440),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E7D32).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.inventory_2_outlined,
                      color: Color(0xFF2E7D32), size: 20),
                ),
                const SizedBox(width: 12),
                const Text('Add Product',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                        color: Color(0xFF1A1A2E))),
                const Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: IconButton(
                    onPressed: () => Navigator.pop(ctx),
                    icon: Icon(Icons.close, color: Colors.grey.shade500),
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              _dialogField(nameCtrl, 'Product Name', Icons.label_outline),
              const SizedBox(height: 14),
              _dialogField(descCtrl, 'Description', Icons.description_outlined,
                  maxLines: 2),
              const SizedBox(height: 14),
              _dialogField(priceCtrl, 'Price (Rs)', Icons.payments_outlined,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 14),
              _dialogField(stockCtrl, 'Stock Quantity',
                  Icons.warehouse_outlined,
                  keyboardType: TextInputType.number),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(color: Color(0xFF1A1A2E))),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameCtrl.text.isNotEmpty &&
                          priceCtrl.text.isNotEmpty &&
                          stockCtrl.text.isNotEmpty) {
                        setState(() {
                          _activeShop!.products.add(Product(
                            name: nameCtrl.text,
                            description: descCtrl.text,
                            price: double.tryParse(priceCtrl.text) ?? 0,
                            stock: int.tryParse(stockCtrl.text) ?? 0,
                          ));
                        });
                        Navigator.pop(ctx);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Add Product',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dialogField(
      TextEditingController controller,
      String label,
      IconData icon, {
        int maxLines = 1,
        TextInputType keyboardType = TextInputType.text,
      }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade500),
        filled: true,
        fillColor: const Color(0xFFF4F6F8),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
            const BorderSide(color: Color(0xFF2E7D32), width: 1.5)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      ),
    );
  }

  // ── Hero Section ───────────────────────────────────────────────────────────
  Widget _buildHeroSection(double w, bool isWide, bool isMid) {
    const hPad = 16.0;
    return FadeTransition(
      opacity: _heroFade,
      child: SlideTransition(
        position: _heroSlide,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(hPad, 20, hPad, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
                    blurRadius: 24,
                    offset: const Offset(0, 8))
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -40,
                  top: -40,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05)),
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: -60,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFF6F00).withOpacity(0.12)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 40.0 : (isMid ? 28.0 : 20.0),
                    vertical: isWide ? 36.0 : (isMid ? 28.0 : 24.0),
                  ),
                  child: isWide ? _heroWide(w) : _heroNarrow(isMid),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _heroWide(double w) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heroTag('🚀 Start Your Journey'),
              const SizedBox(height: 16),
              const Text(
                'Start Your\nOnline Business\nWith Cartza',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Join thousands of sellers already growing their\nbusiness on Pakistan\'s fastest growing marketplace.',
                style: TextStyle(
                    color: Colors.white.withOpacity(0.82),
                    fontSize: 13,
                    height: 1.6),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _heroBadge('Free to Join'),
                  _heroBadge('No Hidden Fees'),
                  _heroBadge('24/7 Support'),
                  _heroBadge('Fast Payouts'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 32),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/img2.jpg',
              fit: BoxFit.cover,
              height: 260,
              errorBuilder: (_, __, ___) => _heroImageFallback(260),
            ),
          ),
        ),
      ],
    );
  }

  Widget _heroNarrow(bool isMid) {
    return Column(
      children: [
        _heroTag('🚀 Start Your Journey'),
        const SizedBox(height: 14),
        Text(
          'Start Your Online\nBusiness With Cartza',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: isMid ? 26 : 22,
              fontWeight: FontWeight.w900,
              height: 1.25),
        ),
        const SizedBox(height: 10),
        Text(
          'Join thousands of sellers already growing\ntheir business on Pakistan\'s marketplace.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white.withOpacity(0.82), fontSize: 12, height: 1.6),
        ),
        const SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            'assets/images/sellinglogo3.jpg',
            fit: BoxFit.cover,
            height: isMid ? 200 : 160,
            width: double.infinity,
            errorBuilder: (_, __, ___) =>
                _heroImageFallback(isMid ? 200 : 160),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            _heroBadge('Free to Join'),
            _heroBadge('No Hidden Fees'),
            _heroBadge('24/7 Support'),
          ],
        ),
      ],
    );
  }

  Widget _heroImageFallback(double h) => Container(
    height: h,
    decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14)),
    child: const Center(
      child: Icon(Icons.store_mall_directory_outlined,
          size: 60, color: Colors.white54),
    ),
  );

  Widget _heroTag(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.3)),
    ),
    child: Text(text,
        style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 12)),
  );

  Widget _heroBadge(String text) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.3)),
    ),
    child: Text(text,
        style: const TextStyle(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
  );

  // ── Steps Section ──────────────────────────────────────────────────────────
  Widget _buildStepsSection(double w, bool isWide, bool isMid) {
    const hPad = 16.0;
    final steps = [
      _StepData(
          number: '01',
          icon: Icons.storefront_outlined,
          color: const Color(0xFF2E7D32),
          title: 'Create Your Shop',
          desc:
          'Set up your store profile, add your logo, description, and contact details in minutes.'),
      _StepData(
          number: '02',
          icon: Icons.inventory_2_outlined,
          color: const Color(0xFFFF6F00),
          title: 'List Your Products',
          desc:
          'Add product images, set prices, and manage your inventory with our easy-to-use tools.'),
      _StepData(
          number: '03',
          icon: Icons.local_shipping_outlined,
          color: const Color(0xFF1565C0),
          title: 'Start Earning',
          desc:
          'Receive orders, pack & ship, and get paid directly to your account fast and securely.'),
    ];

    return FadeTransition(
      opacity: _stepsFade,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(hPad, 28, hPad, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 4,
                height: 22,
                decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(4)),
              ),
              const SizedBox(width: 10),
              const Text('How It Works',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Color(0xFF1A1A2E))),
            ]),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 14),
              child: Text('Get started in 3 simple steps',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
            ),
            const SizedBox(height: 18),
            isWide
                ? Row(
              children: steps
                  .map((s) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: steps.indexOf(s) < 2 ? 14 : 0),
                  child: _StepCard(data: s, isCompact: false),
                ),
              ))
                  .toList(),
            )
                : Column(
              children: steps
                  .map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _StepCard(data: s, isCompact: true),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  // ── Benefits Section ───────────────────────────────────────────────────────
  Widget _buildBenefitsSection(double w, bool isWide, bool isMid) {
    const hPad = 16.0;
    final benefits = [
      _BenefitData(
          icon: Icons.verified_user_outlined,
          color: const Color(0xFF2E7D32),
          title: 'Verified & Secure',
          desc: 'Full verification process to build buyer trust.'),
      _BenefitData(
          icon: Icons.trending_up_rounded,
          color: const Color(0xFFFF6F00),
          title: 'Grow Your Sales',
          desc: 'Smart analytics and promotions to boost revenue.'),
      _BenefitData(
          icon: Icons.support_agent_outlined,
          color: const Color(0xFF1565C0),
          title: '24/7 Seller Support',
          desc: 'Dedicated team ready to help you succeed.'),
      _BenefitData(
          icon: Icons.account_balance_wallet_outlined,
          color: const Color(0xFF6A1B9A),
          title: 'Fast Payouts',
          desc: 'Get paid quickly with multiple withdrawal options.'),
    ];
    final cols = isWide ? 4 : 2;
    return Padding(
      padding: const EdgeInsets.fromLTRB(hPad, 28, hPad, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 4,
              height: 22,
              decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(width: 10),
            const Text('Why Sell on Cartza?',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Color(0xFF1A1A2E))),
          ]),
          const SizedBox(height: 18),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: cols,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: isWide ? 1.4 : (isMid ? 1.6 : 1.4),
            children: benefits.map((b) => _BenefitCard(data: b)).toList(),
          ),
        ],
      ),
    );
  }

  // ── Stats Banner ───────────────────────────────────────────────────────────
  Widget _buildStatsBanner(double w, bool isMid) {
    const hPad = 16.0;
    final stats = [
      _StatData(value: '50K+', label: 'Active Sellers'),
      _StatData(value: '2M+', label: 'Products Listed'),
      _StatData(value: '98%', label: 'Seller Satisfaction'),
      _StatData(value: '3 Days', label: 'Avg. First Sale'),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(hPad, 28, hPad, 0),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isMid ? 28 : 16, vertical: isMid ? 24 : 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color(0xFF1A1A2E)),
        child: isMid
            ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
          stats.map((s) => _StatItem(data: s, isMid: isMid)).toList(),
        )
            : Wrap(
          spacing: 0,
          runSpacing: 16,
          children: stats
              .map((s) => SizedBox(
            width: (w - hPad * 2 - 32) / 2,
            child: _StatItem(data: s, isMid: false),
          ))
              .toList(),
        ),
      ),
    );
  }

  // ── CTA Section ────────────────────────────────────────────────────────────
  Widget _buildCTASection(double w, bool isMid) {
    const hPad = 16.0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(hPad, 28, hPad, 0),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isMid ? 36 : 20, vertical: isMid ? 32 : 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
        ),
        child: Column(
          children: [
            const Text('Ready to Start Selling?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 8),
            Text(
              'Create your shop for free and reach millions of buyers across Pakistan.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey.shade600, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 24),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _btnHovered = true),
              onExit: (_) => setState(() => _btnHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                transform: Matrix4.identity()
                  ..scale(_btnHovered ? 1.03 : 1.0),
                transformAlignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: _goToCreateShop,
                  icon: const Icon(Icons.storefront_rounded, size: 20),
                  label: const Text('Start Selling Now',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    elevation: _btnHovered ? 8 : 3,
                    shadowColor: const Color(0xFF4CAF50).withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 13, color: Colors.grey.shade500),
                const SizedBox(width: 4),
                Text('Free to join · No credit card required',
                    style:
                    TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Shop Card ─────────────────────────────────────────────────────────────
class _ShopCard extends StatefulWidget {
  final ShopModel shop;
  final VoidCallback onTap;
  const _ShopCard({required this.shop, required this.onTap});

  @override
  State<_ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<_ShopCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final shop = widget.shop;
    final publishedCount = shop.products.where((p) => p.published).length;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _hovered
                  ? const Color(0xFF4CAF50).withOpacity(0.5)
                  : Colors.grey.shade200,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_hovered ? 0.10 : 0.05),
                blurRadius: _hovered ? 16 : 8,
                offset: Offset(0, _hovered ? 6 : 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.storefront_rounded,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shop.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Color(0xFF1A1A2E)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('● Live',
                            style: TextStyle(
                                color: Color(0xFF2E7D32),
                                fontSize: 10,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    size: 14,
                    color: _hovered
                        ? const Color(0xFF2E7D32)
                        : Colors.grey.shade400),
              ]),
              const SizedBox(height: 14),
              if (shop.description.isNotEmpty)
                Text(
                  shop.description,
                  style: TextStyle(
                      color: Colors.grey.shade500, fontSize: 12, height: 1.4),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              const SizedBox(height: 10),
              Row(children: [
                _miniStat(
                    '${shop.products.length}', 'Products', const Color(0xFF2E7D32)),
                const SizedBox(width: 10),
                _miniStat(
                    '$publishedCount', 'Published', const Color(0xFF1565C0)),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniStat(String value, String label, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.08),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Text(value,
          style: TextStyle(
              color: color, fontSize: 12, fontWeight: FontWeight.w800)),
      const SizedBox(width: 4),
      Text(label,
          style: TextStyle(color: color.withOpacity(0.7), fontSize: 11)),
    ]),
  );
}

// ─── Dashboard Product Tile ─────────────────────────────────────────────────
class _DashProductTile extends StatefulWidget {
  final Product product;
  final VoidCallback onTogglePublish;
  final VoidCallback onDelete;

  const _DashProductTile({
    required this.product,
    required this.onTogglePublish,
    required this.onDelete,
  });

  @override
  State<_DashProductTile> createState() => _DashProductTileState();
}

class _DashProductTileState extends State<_DashProductTile> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFFF9FFF9) : const Color(0xFFF4F6F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered
                ? const Color(0xFF4CAF50).withOpacity(0.3)
                : Colors.grey.shade200,
          ),
        ),
        child: Row(children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: p.imagePath == null
                ? const Icon(Icons.image_outlined,
                color: Color(0xFF2E7D32), size: 22)
                : ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Image.network(p.imagePath!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                      Icons.image_outlined,
                      size: 22,
                      color: Colors.grey)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Color(0xFF1A1A2E)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 3),
                  Row(children: [
                    Text('Rs ${p.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w800,
                            fontSize: 12)),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6F00).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text('Stock: ${p.stock}',
                          style: const TextStyle(
                              color: Color(0xFFFF6F00),
                              fontSize: 10,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: p.published
                            ? const Color(0xFF2E7D32).withOpacity(0.1)
                            : Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        p.published ? '● Live' : '○ Draft',
                        style: TextStyle(
                          color: p.published
                              ? const Color(0xFF2E7D32)
                              : Colors.grey.shade500,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ]),
                ]),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: p.published ? 'Unpublish' : 'Publish',
              child: IconButton(
                onPressed: widget.onTogglePublish,
                icon: Icon(
                  p.published ? Icons.public : Icons.public_off_outlined,
                  color: p.published
                      ? const Color(0xFF1565C0)
                      : Colors.grey.shade400,
                  size: 20,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              onPressed: widget.onDelete,
              icon: Icon(Icons.delete_outline,
                  color: Colors.red.shade400, size: 20),
              tooltip: 'Remove product',
            ),
          ),
        ]),
      ),
    );
  }
}

// ─── Step Card ─────────────────────────────────────────────────────────────
class _StepData {
  final String number;
  final IconData icon;
  final Color color;
  final String title;
  final String desc;
  const _StepData(
      {required this.number,
        required this.icon,
        required this.color,
        required this.title,
        required this.desc});
}

class _StepCard extends StatefulWidget {
  final _StepData data;
  final bool isCompact;
  const _StepCard({required this.data, required this.isCompact});

  @override
  State<_StepCard> createState() => _StepCardState();
}

class _StepCardState extends State<_StepCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.12 : 0.06),
              blurRadius: _hovered ? 20 : 10,
              offset: Offset(0, _hovered ? 8 : 4),
            ),
          ],
        ),
        child: widget.isCompact
            ? Row(children: [
          _icon(d),
          const SizedBox(width: 16),
          Expanded(child: _text(d))
        ])
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _icon(d),
          const SizedBox(height: 14),
          _text(d)
        ]),
      ),
    );
  }

  Widget _icon(_StepData d) => Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
            color: d.color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14)),
        child: Icon(d.icon, color: d.color, size: 26),
      ),
      Positioned(
        top: -6,
        right: -6,
        child: Container(
          width: 22,
          height: 22,
          decoration:
          BoxDecoration(color: d.color, shape: BoxShape.circle),
          child: Center(
            child: Text(d.number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      ),
    ],
  );

  Widget _text(_StepData d) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(d.title,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: Color(0xFF1A1A2E))),
      const SizedBox(height: 5),
      Text(d.desc,
          style: TextStyle(
              color: Colors.grey.shade500, fontSize: 12, height: 1.5)),
    ],
  );
}

// ─── Benefit Card ──────────────────────────────────────────────────────────
class _BenefitData {
  final IconData icon;
  final Color color;
  final String title;
  final String desc;
  const _BenefitData(
      {required this.icon,
        required this.color,
        required this.title,
        required this.desc});
}

class _BenefitCard extends StatefulWidget {
  final _BenefitData data;
  const _BenefitCard({required this.data});

  @override
  State<_BenefitCard> createState() => _BenefitCardState();
}

class _BenefitCardState extends State<_BenefitCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_hovered ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovered ? 0.11 : 0.06),
              blurRadius: _hovered ? 18 : 10,
              offset: Offset(0, _hovered ? 7 : 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: d.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(d.icon, color: d.color, size: 22),
            ),
            const SizedBox(height: 10),
            Text(d.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: Color(0xFF1A1A2E))),
            const SizedBox(height: 4),
            Text(d.desc,
                style: TextStyle(
                    color: Colors.grey.shade500, fontSize: 11, height: 1.5),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

// ─── Stat Item ─────────────────────────────────────────────────────────────
class _StatData {
  final String value;
  final String label;
  const _StatData({required this.value, required this.label});
}

class _StatItem extends StatelessWidget {
  final _StatData data;
  final bool isMid;
  const _StatItem({required this.data, required this.isMid});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(data.value,
            style: TextStyle(
                color: const Color(0xFF4CAF50),
                fontSize: isMid ? 26 : 22,
                fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(data.label,
            style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 11,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center),
      ],
    );
  }
}
