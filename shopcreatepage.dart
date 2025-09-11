import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Your Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[50],
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

class Product {
  String name;
  String description;
  double price;
  int stock;
  String? imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    this.imagePath,
  });
}

class Shopcreatepage extends StatefulWidget {
  const Shopcreatepage({super.key});

  @override
  State<Shopcreatepage> createState() => _ShopcreatepageState();
}

class _ShopcreatepageState extends State<Shopcreatepage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  XFile? _shopImage;
  final ImagePicker _picker = ImagePicker();

  // Verification-related variables
  bool _termsAccepted = false;

  // ID Card verification
  XFile? _idCardImage;
  bool _isEmailVerificationSent = false;
  bool _isPhoneVerificationSent = false;
  final TextEditingController _emailVerificationCodeController = TextEditingController();
  final TextEditingController _phoneVerificationCodeController = TextEditingController();
  String _generatedEmailCode = '';
  String _generatedPhoneCode = '';
  bool _isEmailVerified = false;
  bool _isPhoneVerified = false;
  bool _isIDCardVerified = false;

  // Product management
  List<Product> _products = [];
  final _productNameController = TextEditingController();
  final _productDescController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productStockController = TextEditingController();

  // Tab controller
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      setState(() {
        _shopImage = image;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image'),
        ),
      );
    }
  }

  Future<void> _pickIDCardImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      setState(() {
        _idCardImage = image;
        _isIDCardVerified = true; // Auto-verify after upload for demo
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID Card uploaded successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image'),
        ),
      );
    }
  }

  Future<void> _pickProductImage(int index) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      setState(() {
        _products[index].imagePath = image?.path;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to pick image'),
        ),
      );
    }
  }

  void _addProduct() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Product'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _productDescController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _productPriceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _productStockController,
                  decoration: const InputDecoration(
                    labelText: 'Stock Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter stock quantity';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_productNameController.text.isNotEmpty &&
                    _productPriceController.text.isNotEmpty &&
                    _productStockController.text.isNotEmpty) {
                  setState(() {
                    _products.add(Product(
                      name: _productNameController.text,
                      description: _productDescController.text,
                      price: double.parse(_productPriceController.text),
                      stock: int.parse(_productStockController.text),
                    ));
                    _productNameController.clear();
                    _productDescController.clear();
                    _productPriceController.clear();
                    _productStockController.clear();
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _removeProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  void _sendEmailVerificationCode() {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Generate a random 6-digit code
    _generatedEmailCode = (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();

    // Show a message that the code was sent to the actual email
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Verification Code Sent'),
          content: Text('A verification code has been sent to:\n${_emailController.text}\n\nYour verification code is: $_generatedEmailCode\n\nIn a real app, this would be sent via email service.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isEmailVerificationSent = true;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _sendPhoneVerificationCode() {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your phone number first'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Generate a random 6-digit code
    _generatedPhoneCode = (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();

    // Show a message that the code was sent to the actual phone number
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('SMS Verification Code Sent'),
          content: Text('A verification code has been sent to:\n${_phoneController.text}\n\nYour verification code is: $_generatedPhoneCode\n\nIn a real app, this would be sent via SMS service.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _isPhoneVerificationSent = true;
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _verifyEmailCode() {
    if (_emailVerificationCodeController.text == _generatedEmailCode) {
      setState(() {
        _isEmailVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email verification successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid verification code. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _verifyPhoneCode() {
    if (_phoneVerificationCodeController.text == _generatedPhoneCode) {
      setState(() {
        _isPhoneVerified = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Phone verification successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid verification code. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool get _isFullyVerified {
    return _isEmailVerified && _isPhoneVerified && _isIDCardVerified;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _termsAccepted && _isFullyVerified) {
      // Process data
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Shop created successfully! Your shop is now verified and ready to use.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 5),
        ),
      );
      // Navigate to next screen or reset form
    } else if (!_termsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!_isFullyVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all verification steps'),
          backgroundColor: Colors.red,
        ),
      );
      // Switch to verification tab
      _tabController.animateTo(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Create Your Shop',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Shop Details'),
            Tab(text: 'Verification'),
          ],
          labelColor: Colors.green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.green,
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
      // Shop Details Tab
      SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Shop Image Upload
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _shopImage == null
                    ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Add Shop Image',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
                    : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    _shopImage!.path,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 150,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Shop Name
            TextFormField(
              controller: _shopNameController,
              decoration: const InputDecoration(
                labelText: 'Shop Name',
                prefixIcon: Icon(Icons.store),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a shop name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Description
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Address
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Icons.location_on),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Phone
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Products Section
            const Text(
              'Products',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Add Product Button
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Add Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Product List
            ..._products.asMap().entries.map((entry) {
              final index = entry.key;
              final product = entry.value;
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: product.imagePath == null
                      ? IconButton(
                    icon: const Icon(Icons.add_photo_alternate),
                    onPressed: () => _pickProductImage(index),
                  )
                      : GestureDetector(
                    onTap: () => _pickProductImage(index),
                    child: Image.network(
                      product.imagePath!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(product.name),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)} - Stock: ${product.stock}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeProduct(index),
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),

            // Terms and Conditions
            Row(
              children: [
                Checkbox(
                  value: _termsAccepted,
                  onChanged: (value) {
                    setState(() {
                      _termsAccepted = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Show terms and conditions
                    },
                    child: const Text(
                      'I agree to the Terms and Conditions',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
              ),
              child: const Text(
                'Create Shop',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),

    // Verification Tab
    SingleChildScrollView(
    padding: const EdgeInsets.all(20),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    const Text(
    'Complete Verification',
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 16),
    const Text(
    'Please complete all three verification steps to create your shop.',
    style: TextStyle(
    color: Colors.grey,
    ),
    ),
    const SizedBox(height: 24),

    // ID Card Verification Section
    Card(
    child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    _isIDCardVerified
    ? const Icon(Icons.verified, color: Colors.green)
        : const Icon(Icons.pending, color: Colors.orange),
    const SizedBox(width: 8),
    const Text(
    'ID Card Verification',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),
    ],
    ),
    const SizedBox(height: 16),
    const Text(
    'Upload a photo of your government-issued ID card for verification.',
    style: TextStyle(
    color: Colors.grey,
    ),
    ),
    const SizedBox(height: 16),
    GestureDetector(
    onTap: _pickIDCardImage,
    child: Container(
    height: 150,
    decoration: BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
    color: Colors.green,
    width: 1,
    ),
    ),
    child: _idCardImage == null
    ? Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
    Icon(
    Icons.add_a_photo,
    size: 40,
    color: Colors.grey,
    ),
    SizedBox(height: 8),
    Text(
    'Upload ID Card',
    style: TextStyle(
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    ),
    ),
    ],
    )
        : ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.network(
    _idCardImage!.path,
    fit: BoxFit.cover,
    width: double.infinity,
    height: 150,
    ),
    ),
    ),
    ),
    const SizedBox(height: 16),
    if (_isIDCardVerified)
    const Text(
    'ID Card verified successfully!',
    style: TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    ),
    const SizedBox(height: 24),

    // Email Verification Section
    Card(
    child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    _isEmailVerified
    ? const Icon(Icons.verified, color: Colors.green)
        : const Icon(Icons.pending, color: Colors.orange),
    const SizedBox(width: 8),
    const Text(
    'Email Verification',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),
    ],
    ),
    const SizedBox(height: 16),
    Text(
    'Verify your email address: ${_emailController.text.isEmpty ? '[Please enter email first]' : _emailController.text}',
    style: const TextStyle(
    color: Colors.grey,
    ),
    ),
    const SizedBox(height: 16),
    if (!_isEmailVerified)
    ElevatedButton(
    onPressed: _sendEmailVerificationCode,
    child: const Text('Send Verification Code to Email'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,)
    ),
    if (_isEmailVerificationSent && !_isEmailVerified)
    Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    const SizedBox(height: 16),
    const Text(
    'Enter Verification Code',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 8),
    TextFormField(
    controller: _emailVerificationCodeController,
    decoration: const InputDecoration(
    hintText: 'Enter the code sent to your email',
    border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    ),
    const SizedBox(height: 16),
    ElevatedButton(
    onPressed: _verifyEmailCode,
    child: const Text('Verify Email'),
    ),
    ],
    ),
    if (_isEmailVerified)
    const Text(
    'Email verified successfully!',
    style: TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    ),
    const SizedBox(height: 24),

    // Phone Verification Section
    Card(
    child: Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    _isPhoneVerified
    ? const Icon(Icons.verified, color: Colors.green)
        : const Icon(Icons.pending, color: Colors.orange),
    const SizedBox(width: 8),
    const Text(
    'Phone Verification',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    ),
    ),]
    ),
    const SizedBox(height: 16),
    Text(
    'Verify your phone number: ${_phoneController.text.isEmpty ? '[Please enter phone first]' : _phoneController.text}',
    style: const TextStyle(
    color: Colors.grey,
    ),
    ),
    const SizedBox(height: 16),
    if (!_isPhoneVerified)
    ElevatedButton(
    onPressed: _sendPhoneVerificationCode,
    child: const Text('Send Verification Code to Phone'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,)
    ),
    if (_isPhoneVerificationSent && !_isPhoneVerified)
    Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    const SizedBox(height: 16),
    const Text(
    'Enter Verification Code',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 8),
    TextFormField(
    controller: _phoneVerificationCodeController,
    decoration: const InputDecoration(
    hintText: 'Enter the code sent to your phone',
    border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.number,
    ),
    const SizedBox(height: 16),
    ElevatedButton(
    onPressed: _verifyPhoneCode,
    child: const Text('Verify Phone'),
    ),
    ],
    ),
    if (_isPhoneVerified)
    const Text(
    'Phone verified successfully!',
    style: TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    ),

    const SizedBox(height: 24),

    // Overall Verification Status
    if (_isFullyVerified)
    Card(
    color: Colors.green[50],
    child: const Padding(
    padding: EdgeInsets.all(16),
    child: Row(
    children: [
    Icon(Icons.verified_user, color: Colors.green),
    SizedBox(width: 8),
    Text(
    'All verifications completed successfully!\nYour shop is now verified.',
    style: TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.bold,
    ),
    ),
    ],
    ),
    ),
    ),
    ],
    ),
    ),
    ],
    ),
    );
  }

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