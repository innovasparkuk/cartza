import 'package:ecommercepro/ratingreviews.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ModernProductDetailPage extends StatefulWidget {
  final Product1 product;

  const ModernProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ModernProductDetailPageState createState() => _ModernProductDetailPageState();
}

class _ModernProductDetailPageState extends State<ModernProductDetailPage> {
  int _currentImageIndex = 0;
  int _quantity = 1;
  String _selectedColor = 'Black';
  String _selectedSize = 'M';
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          _buildProductImages(),
          _buildProductInfo(),
          _buildColorSelector(),
          _buildSizeSelector(),
          _buildProductDescription(),
          _buildSpecifications(),
          _buildAddToCartButton(),
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 0,
      pinned: true,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20,),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        'Product Details',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : Colors.black, size: 20,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.black, size: 20,),
          onPressed: () {},
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildProductImages() {
    return SliverToBoxAdapter(
      child: Container(
        height: 330,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 320,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentImageIndex = index;
                  });
                },
              ),
              items: widget.product.images.map((imagePath) {
                return Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }).toList(),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentImageIndex,
                  count: widget.product.images.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    dotColor: Colors.grey[300]!,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildProductInfo() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    right: 20
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RatingReviewsPage(),));
                      },
                          child:  Icon(Icons.star, color: Colors.amber, size: 16),
                      ),
                      Text(
                        widget.product.rating.toString(),
                        style:TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              widget.product.brand,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  'Rs.${widget.product.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                if (widget.product.originalPrice != null) ...[
                   SizedBox(width: 12),
                  Text(
                    'Rs.${widget.product.originalPrice!.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '${widget.product.discountPercentage}% OFF',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildColorSelector() {
    final colors = ['Black', 'White', 'Blue', 'Red'];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: colors.length,
                itemBuilder: (context, index) {
                  final color = colors[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedColor == color ? Color(0xFF4CAF50) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedColor == color ? Color(0xFF4CAF50) : Colors.grey[300]!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        color,
                        style: TextStyle(
                          color: _selectedColor == color ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
             SizedBox(height: 10),
            Divider(color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSizeSelector() {
    final sizes = ['S', 'M', 'L', 'XL'];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 35,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: sizes.length,
                itemBuilder: (context, index) {
                  final size = sizes[index];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedSize = size;
                      });
                    },
                    child: Container(
                      width: 60,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: _selectedSize == size ? Color(0xFF4CAF50) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _selectedSize == size ? Color(0xFF4CAF50): Colors.grey[300]!,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          size,
                          style: TextStyle(
                            color: _selectedSize == size ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildProductDescription() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.product.description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey[300]),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildSpecifications() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Specifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.product.specifications.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${entry.key}:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildAddToCartButton() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Quantity:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        _quantity.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF4CAF50),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: Color(0xFF4CAF50)),
                      ),
                    ),
                    icon: const Icon(FontAwesomeIcons.shoppingBag, color: Color(0xFF4CAF50),),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40,),
      ]
        ),
      ),
    );
  }
}

// Enhanced Product Model
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

  Product1({
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