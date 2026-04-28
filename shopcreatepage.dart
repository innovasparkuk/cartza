import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

const double _kShopMaxWidth = 1000.0;

class Product {
  String name;
  String description;
  double price;
  int stock;
  String? imagePath;
  bool published;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.imagePath,
    this.published = false,
  });
}

class ShopModel {
  final String name;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String? imagePath;
  final List<Product> products;

  const ShopModel({
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    this.imagePath,
    required this.products,
  });
}

class Shopcreatepage extends StatefulWidget {
  const Shopcreatepage({super.key});

  @override
  State<Shopcreatepage> createState() => _ShopcreatepageState();
}

class _ShopcreatepageState extends State<Shopcreatepage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  XFile? _shopImage;
  final ImagePicker _picker = ImagePicker();
  bool _termsAccepted = false;
  XFile? _idCardImage;

  bool _isEmailVerificationSent = false;
  bool _isPhoneVerificationSent = false;
  final TextEditingController _emailVerificationCodeController = TextEditingController();
  final TextEditingController _phoneVerificationCodeController = TextEditingController();
  bool _isEmailVerified = false;
  bool _isPhoneVerified = false;
  bool _isIDCardVerified = false;

  List<Product> _products = [];
  final _productNameController = TextEditingController();
  final _productDescController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productStockController = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      setState(() => _shopImage = image);
    } catch (_) {
      _snack('Failed to pick image', isError: true);
    }
  }

  Future<void> _pickIDCardImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      setState(() {
        _idCardImage = image;
        _isIDCardVerified = true;
      });
      _snack('ID Card uploaded successfully!');
    } catch (_) {
      _snack('Failed to pick image', isError: true);
    }
  }

  Future<void> _pickProductImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
      setState(() => _products[index].imagePath = image?.path);
    } catch (_) {
      _snack('Failed to pick image', isError: true);
    }
  }

  void _snack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: isError ? Colors.red.shade700 : const Color(0xFF2E7D32),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _addProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
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
                    child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF2E7D32), size: 20),
                  ),
                  const SizedBox(width: 12),
                  const Text('Add Product',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: Color(0xFF1A1A2E))),
                  const Spacer(),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey.shade500),
                    ),
                  ),
                ]),
                const SizedBox(height: 20),
                _dialogField(_productNameController, 'Product Name', Icons.label_outline),
                const SizedBox(height: 14),
                _dialogField(_productDescController, 'Description', Icons.description_outlined, maxLines: 2),
                const SizedBox(height: 14),
                _dialogField(_productPriceController, 'Price (Rs)', Icons.payments_outlined,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 14),
                _dialogField(_productStockController, 'Stock Quantity', Icons.warehouse_outlined,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 24),
                Row(children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Cancel', style: TextStyle(color: Color(0xFF1A1A2E))),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_productNameController.text.isNotEmpty &&
                            _productPriceController.text.isNotEmpty &&
                            _productStockController.text.isNotEmpty) {
                          setState(() {
                            _products.add(Product(
                              name: _productNameController.text,
                              description: _productDescController.text,
                              price: double.tryParse(_productPriceController.text) ?? 0,
                              stock: int.tryParse(_productStockController.text) ?? 0,
                            ));
                            _productNameController.clear();
                            _productDescController.clear();
                            _productPriceController.clear();
                            _productStockController.clear();
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        );
      },
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      ),
    );
  }

  void _removeProduct(int index) {
    setState(() => _products.removeAt(index));
  }

  void _publishAll() {
    setState(() {
      for (final p in _products) {
        p.published = true;
      }
    });
    _snack('All products published!');
  }

  void _sendEmailVerificationCode() {
    if (_emailController.text.isEmpty) {
      _snack('Please enter your email first', isError: true);
      return;
    }
    _showSentDialog(
      title: '📧 Email Verification',
      subtitle: _emailController.text,
      hint: 'A 6-digit code has been sent to your email.\nEnter any 6-digit number to verify (demo mode).',
      onOk: () => setState(() => _isEmailVerificationSent = true),
    );
  }

  void _sendPhoneVerificationCode() {
    if (_phoneController.text.isEmpty) {
      _snack('Please enter your phone number first', isError: true);
      return;
    }
    _showSentDialog(
      title: '📱 SMS Verification',
      subtitle: _phoneController.text,
      hint: 'A 6-digit code has been sent to your phone.\nEnter any 6-digit number to verify (demo mode).',
      onOk: () => setState(() => _isPhoneVerificationSent = true),
    );
  }

  void _showSentDialog({
    required String title,
    required String subtitle,
    required String hint,
    required VoidCallback onOk,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 380),
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mark_email_unread_outlined, color: Color(0xFF2E7D32), size: 28),
            ),
            const SizedBox(height: 14),
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF1A1A2E))),
            const SizedBox(height: 6),
            Text('Code sent to:\n$subtitle',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(hint,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12, height: 1.5)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  onOk();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Got It', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void _verifyEmailCode() {
    final code = _emailVerificationCodeController.text.trim();
    if (code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code)) {
      setState(() => _isEmailVerified = true);
      _snack('Email verified successfully! ✓');
    } else {
      _snack('Please enter a valid 6-digit code', isError: true);
    }
  }

  void _verifyPhoneCode() {
    final code = _phoneVerificationCodeController.text.trim();
    if (code.length == 6 && RegExp(r'^\d{6}$').hasMatch(code)) {
      setState(() => _isPhoneVerified = true);
      _snack('Phone verified successfully! ✓');
    } else {
      _snack('Please enter a valid 6-digit code', isError: true);
    }
  }

  bool get _isFullyVerified => _isEmailVerified && _isPhoneVerified && _isIDCardVerified;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _termsAccepted && _isFullyVerified) {
      final shop = ShopModel(
        name: _shopNameController.text,
        description: _descriptionController.text,
        address: _addressController.text,
        phone: _phoneController.text,
        email: _emailController.text,
        imagePath: _shopImage?.path,
        products: List.from(_products),
      );
      _showSuccessDialog(shop);
    } else if (!_termsAccepted) {
      _snack('Please accept the Terms & Conditions', isError: true);
    } else if (!_isFullyVerified) {
      _snack('Please complete all verification steps', isError: true);
      _tabController.animateTo(1);
    }
  }

  void _showSuccessDialog(ShopModel shop) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 380),
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline, color: Color(0xFF2E7D32), size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              '🎉 Shop Created Successfully!',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: Color(0xFF1A1A2E)),
            ),
            const SizedBox(height: 8),
            Text(
              '"${shop.name}" is now live on Cartza.\nYou can add & publish more products from your shop page.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  Navigator.pop(context, shop);
                },
                icon: const Icon(Icons.storefront_rounded, size: 18),
                label: const Text('Go to My Shop', style: TextStyle(fontWeight: FontWeight.w800)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      appBar: _buildAppBar(),
      // ── ONLY CHANGE: Center → Align(topCenter) so layout stays at top
      //    and never stretches on zoom in/out ──────────────────────────
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kShopMaxWidth),
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildShopDetailsTab(),
              _buildVerificationTab(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      automaticallyImplyLeading: false,  // ← IMPORTANT: disable default back button
      titleSpacing: 0,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _kShopMaxWidth),
          child: Row(
            children: [
              // Back button
              Tooltip(
                message: 'Go Back',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
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
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Title text
              const Text(
                'Create Your Shop',
                style: TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              const Spacer(),  // ← keeps everything left-aligned within center
              // Optional: can add a placeholder or cart button here later
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _kShopMaxWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: Row(
                    children: [
                      _progressChip('📝 Details', _formKey.currentState != null),
                      const SizedBox(width: 6),
                      Icon(Icons.chevron_right, size: 14, color: Colors.grey.shade400),
                      const SizedBox(width: 6),
                      _progressChip('🔒 Verification', _isFullyVerified),
                      const Spacer(),
                      if (_isFullyVerified)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E7D32).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('✓ All Verified',
                              style: TextStyle(
                                  color: Color(0xFF2E7D32), fontSize: 11, fontWeight: FontWeight.w700)),
                        ),
                    ],
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.store_outlined, size: 16),
                        SizedBox(width: 6),
                        Text('Shop Details'),
                      ]),
                    ),
                    Tab(
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.verified_user_outlined, size: 16),
                        SizedBox(width: 6),
                        Text('Verification'),
                      ]),
                    ),
                  ],
                  labelColor: const Color(0xFF2E7D32),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: const Color(0xFF2E7D32),
                  indicatorWeight: 2.5,
                  labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _progressChip(String label, bool done) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: done ? const Color(0xFF2E7D32).withOpacity(0.1) : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: done ? const Color(0xFF2E7D32).withOpacity(0.4) : Colors.grey.shade300,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: done ? const Color(0xFF2E7D32) : Colors.grey.shade500,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _buildShopDetailsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _sectionHeader('Shop Image', Icons.add_photo_alternate_outlined),
            const SizedBox(height: 10),
            _buildImageUpload(),
            const SizedBox(height: 22),
            _buildCard(
              child: Column(children: [
                _sectionHeader('Basic Information', Icons.store_outlined),
                const SizedBox(height: 14),
                _styledField(
                  controller: _shopNameController,
                  label: 'Shop Name',
                  icon: Icons.storefront_outlined,
                  validator: (v) => v == null || v.isEmpty ? 'Enter shop name' : null,
                ),
                const SizedBox(height: 14),
                _styledField(
                  controller: _descriptionController,
                  label: 'Description',
                  icon: Icons.description_outlined,
                  maxLines: 3,
                ),
              ]),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(children: [
                _sectionHeader('Contact Details', Icons.contact_phone_outlined),
                const SizedBox(height: 14),
                _styledField(
                  controller: _addressController,
                  label: 'Address',
                  icon: Icons.location_on_outlined,
                  validator: (v) => v == null || v.isEmpty ? 'Enter address' : null,
                ),
                const SizedBox(height: 14),
                _styledField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (v) => v == null || v.isEmpty ? 'Enter phone number' : null,
                ),
                const SizedBox(height: 14),
                _styledField(
                  controller: _emailController,
                  label: 'Email Address',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Enter email';
                    if (!v.contains('@')) return 'Enter valid email';
                    return null;
                  },
                ),
              ]),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _sectionHeader(
                            'Products (${_products.length})', Icons.inventory_2_outlined),
                      ),
                      if (_products.isNotEmpty) ...[
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: OutlinedButton.icon(
                            onPressed: _publishAll,
                            icon: const Icon(Icons.public, size: 14),
                            label: const Text('Publish All',
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1565C0),
                              side: const BorderSide(color: Color(0xFF1565C0)),
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: ElevatedButton.icon(
                          onPressed: _addProduct,
                          icon: const Icon(Icons.add, size: 16),
                          label: const Text('Add',
                              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E7D32),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (_products.isEmpty) ...[
                    const SizedBox(height: 20),
                    Center(
                      child: Column(children: [
                        Icon(Icons.inventory_2_outlined, size: 40, color: Colors.grey.shade300),
                        const SizedBox(height: 8),
                        Text('No products yet',
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 13, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        Text('Tap "Add" to add your first product',
                            style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                        const SizedBox(height: 12),
                      ]),
                    ),
                  ] else ...[
                    const SizedBox(height: 14),
                    ..._products.asMap().entries.map((entry) {
                      final index = entry.key;
                      final product = entry.value;
                      return _ProductTile(
                        product: product,
                        onDelete: () => _removeProduct(index),
                        onPickImage: () => _pickProductImage(index),
                        onTogglePublish: () {
                          setState(() => product.published = !product.published);
                        },
                      );
                    }),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _termsAccepted
                      ? const Color(0xFF4CAF50).withOpacity(0.4)
                      : Colors.grey.shade200,
                ),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _termsAccepted,
                    activeColor: const Color(0xFF2E7D32),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    onChanged: (v) => setState(() => _termsAccepted = v ?? false),
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(color: Color(0xFF555555), fontSize: 13),
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.storefront_rounded, size: 20),
                label: const Text('Create My Shop',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 3,
                  shadowColor: const Color(0xFF4CAF50).withOpacity(0.4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageUpload() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _pickImage,
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _shopImage != null
                  ? const Color(0xFF4CAF50).withOpacity(0.5)
                  : Colors.grey.shade200,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
            ],
          ),
          child: _shopImage == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add_photo_alternate_outlined,
                    size: 26, color: Color(0xFF2E7D32)),
              ),
              const SizedBox(height: 10),
              const Text('Upload Shop Photo',
                  style: TextStyle(
                      color: Color(0xFF2E7D32), fontWeight: FontWeight.w700, fontSize: 13)),
              const SizedBox(height: 3),
              Text('JPG, PNG up to 5MB',
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
            ],
          )
              : Stack(fit: StackFit.expand, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.network(_shopImage!.path,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_outlined, size: 40, color: Colors.grey)),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.edit, color: Colors.white, size: 12),
                  SizedBox(width: 4),
                  Text('Change',
                      style: TextStyle(
                          color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) => Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3)),
      ],
    ),
    child: child,
  );

  Widget _sectionHeader(String title, IconData icon) => Row(
    children: [
      Container(
        width: 3,
        height: 18,
        decoration: BoxDecoration(color: const Color(0xFF4CAF50), borderRadius: BorderRadius.circular(3)),
      ),
      const SizedBox(width: 8),
      Icon(icon, size: 16, color: const Color(0xFF2E7D32)),
      const SizedBox(width: 6),
      Text(title,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1A1A2E))),
    ],
  );

  Widget _styledField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 18, color: Colors.grey.shade400),
        filled: true,
        fillColor: const Color(0xFFF4F6F8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.5)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.red.shade300)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red.shade400, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        labelStyle: TextStyle(color: Colors.grey.shade500, fontSize: 13),
      ),
    );
  }

  Widget _buildVerificationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(children: [
              const Icon(Icons.security, color: Colors.white, size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Identity Verification',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15)),
                    const SizedBox(height: 3),
                    Text('Complete all 3 steps to activate your shop',
                        style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                  ],
                ),
              ),
              Stack(alignment: Alignment.center, children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: CircularProgressIndicator(
                    value: [_isIDCardVerified, _isEmailVerified, _isPhoneVerified]
                        .where((v) => v)
                        .length /
                        3,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                ),
                Text(
                  '${[_isIDCardVerified, _isEmailVerified, _isPhoneVerified].where((v) => v).length}/3',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                ),
              ]),
            ]),
          ),
          const SizedBox(height: 20),
          _verificationCard(
            step: 1,
            icon: Icons.badge_outlined,
            title: 'ID Card Verification',
            subtitle: 'Upload a government-issued ID card',
            isVerified: _isIDCardVerified,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: _pickIDCardImage,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F6F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _idCardImage != null
                          ? const Color(0xFF4CAF50).withOpacity(0.5)
                          : const Color(0xFF2E7D32).withOpacity(0.3),
                      width: 1.5,
                    ),
                  ),
                  child: _idCardImage == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add_a_photo_outlined,
                            color: Color(0xFF2E7D32), size: 22),
                      ),
                      const SizedBox(height: 8),
                      const Text('Upload ID Card',
                          style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w700,
                              fontSize: 13)),
                      const SizedBox(height: 3),
                      Text('Front side of CNIC / Passport',
                          style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Stack(fit: StackFit.expand, children: [
                      Image.network(_idCardImage!.path,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image_outlined,
                              size: 40, color: Colors.grey)),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('Change',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          _verificationCard(
            step: 2,
            icon: Icons.email_outlined,
            title: 'Email Verification',
            subtitle: _emailController.text.isEmpty
                ? 'Enter email in Shop Details first'
                : _emailController.text,
            isVerified: _isEmailVerified,
            child: _isEmailVerified
                ? _verifiedBadge('Email address verified')
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!_isEmailVerificationSent)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton.icon(
                      onPressed: _sendEmailVerificationCode,
                      icon: const Icon(Icons.send_outlined, size: 16),
                      label: const Text('Send Code to Email',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      style: _verifyBtnStyle(),
                    ),
                  )
                else ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color(0xFF4CAF50).withOpacity(0.3)),
                    ),
                    child: const Text(
                      '✉️ Code sent to your email. Enter any 6-digit number below to verify.',
                      style:
                      TextStyle(color: Color(0xFF2E7D32), fontSize: 12, height: 1.4),
                    ),
                  ),
                  _codeInputField(_emailVerificationCodeController, 'Enter 6-digit code'),
                  const SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                      onPressed: _verifyEmailCode,
                      style: _verifyBtnStyle(),
                      child: const Text('Verify Email',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: TextButton(
                      onPressed: _sendEmailVerificationCode,
                      child: Text('Resend Code',
                          style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 14),
          _verificationCard(
            step: 3,
            icon: Icons.phone_outlined,
            title: 'Phone Verification',
            subtitle: _phoneController.text.isEmpty
                ? 'Enter phone in Shop Details first'
                : _phoneController.text,
            isVerified: _isPhoneVerified,
            child: _isPhoneVerified
                ? _verifiedBadge('Phone number verified')
                : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!_isPhoneVerificationSent)
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton.icon(
                      onPressed: _sendPhoneVerificationCode,
                      icon: const Icon(Icons.sms_outlined, size: 16),
                      label: const Text('Send Code to Phone',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      style: _verifyBtnStyle(),
                    ),
                  )
                else ...[
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: const Color(0xFF4CAF50).withOpacity(0.3)),
                    ),
                    child: const Text(
                      '📱 Code sent to your phone. Enter any 6-digit number below to verify.',
                      style:
                      TextStyle(color: Color(0xFF2E7D32), fontSize: 12, height: 1.4),
                    ),
                  ),
                  _codeInputField(_phoneVerificationCodeController, 'Enter 6-digit code'),
                  const SizedBox(height: 10),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton(
                      onPressed: _verifyPhoneCode,
                      style: _verifyBtnStyle(),
                      child: const Text('Verify Phone',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 6),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: TextButton(
                      onPressed: _sendPhoneVerificationCode,
                      child: Text('Resend Code',
                          style:
                          TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (_isFullyVerified) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.4)),
              ),
              child: const Row(children: [
                Icon(Icons.verified_user, color: Color(0xFF2E7D32), size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🎉 All Verifications Complete!',
                          style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                      SizedBox(height: 3),
                      Text(
                          'Your shop is verified. Go to Shop Details and tap "Create My Shop".',
                          style: TextStyle(color: Color(0xFF388E3C), fontSize: 12)),
                    ],
                  ),
                ),
              ]),
            ),
          ],
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _verificationCard({
    required int step,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isVerified,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isVerified ? const Color(0xFF4CAF50).withOpacity(0.35) : Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isVerified
                    ? const Color(0xFF2E7D32).withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isVerified ? Icons.check_circle_outline : icon,
                color: isVerified ? const Color(0xFF2E7D32) : Colors.orange,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF1A1A2E))),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: isVerified
                    ? const Color(0xFF2E7D32).withOpacity(0.1)
                    : Colors.orange.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isVerified ? '✓ Done' : 'Step $step',
                style: TextStyle(
                  color: isVerified ? const Color(0xFF2E7D32) : Colors.orange,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ]),
          if (!isVerified) ...[
            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 14),
            child,
          ],
        ],
      ),
    );
  }

  Widget _verifiedBadge(String msg) => Row(children: [
    const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 18),
    const SizedBox(width: 8),
    Text(msg,
        style: const TextStyle(
            color: Color(0xFF2E7D32), fontWeight: FontWeight.w700, fontSize: 13)),
  ]);

  ButtonStyle _verifyBtnStyle() => ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF2E7D32),
    foregroundColor: Colors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );

  Widget _codeInputField(TextEditingController controller, String hint) => TextField(
    controller: controller,
    keyboardType: TextInputType.number,
    textAlign: TextAlign.center,
    maxLength: 6,
    style: const TextStyle(
        fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: 8, color: Color(0xFF1A1A2E)),
    decoration: InputDecoration(
      hintText: '------',
      hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 22, letterSpacing: 8),
      counterText: '',
      filled: true,
      fillColor: const Color(0xFFF4F6F8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF2E7D32), width: 1.5)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),
  );

  @override
  void dispose() {
    _shopNameController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _productNameController.dispose();
    _productDescController.dispose();
    _productPriceController.dispose();
    _productStockController.dispose();
    _emailVerificationCodeController.dispose();
    _phoneVerificationCodeController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}

// ─── Product Tile ──────────────────────────────────────────────────────────
class _ProductTile extends StatefulWidget {
  final Product product;
  final VoidCallback onDelete;
  final VoidCallback onPickImage;
  final VoidCallback onTogglePublish;

  const _ProductTile({
    required this.product,
    required this.onDelete,
    required this.onPickImage,
    required this.onTogglePublish,
  });

  @override
  State<_ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<_ProductTile> {
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
            color: _hovered ? const Color(0xFF4CAF50).withOpacity(0.3) : Colors.grey.shade200,
          ),
        ),
        child: Row(children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.onPickImage,
              child: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32).withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: p.imagePath == null
                    ? const Icon(Icons.add_photo_alternate_outlined,
                    color: Color(0xFF2E7D32), size: 22)
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(p.imagePath!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_outlined, size: 22, color: Colors.grey)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF1A1A2E)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Row(children: [
                  Text('Rs ${p.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                          color: Color(0xFF2E7D32), fontWeight: FontWeight.w800, fontSize: 12)),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6F00).withOpacity(0.08),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('Stock: ${p.stock}',
                        style: const TextStyle(
                            color: Color(0xFFFF6F00), fontSize: 10, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: p.published
                          ? const Color(0xFF2E7D32).withOpacity(0.1)
                          : Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      p.published ? '● Live' : '○ Draft',
                      style: TextStyle(
                        color: p.published ? const Color(0xFF2E7D32) : Colors.grey.shade500,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(
              message: p.published ? 'Unpublish' : 'Publish',
              child: IconButton(
                onPressed: widget.onTogglePublish,
                icon: Icon(
                  p.published ? Icons.public : Icons.public_off_outlined,
                  color: p.published ? const Color(0xFF1565C0) : Colors.grey.shade400,
                  size: 20,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: IconButton(
              onPressed: widget.onDelete,
              icon: Icon(Icons.delete_outline, color: Colors.red.shade400, size: 20),
              tooltip: 'Remove product',
            ),
          ),
        ]),
      ),
    );
  }
}