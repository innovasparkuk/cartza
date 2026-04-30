// ============================================================
//  CARTZA — Full Cart Page  (v5 — TEMU-STYLE LAYOUT)
//  ✅ Single scrollbar — whole page scrolls as ONE unit
//  ✅ Right panel (summary/payment) is STICKY like Temu
//  ✅ Footer spans FULL page width (below both columns)
//  ✅ Checkout button ONLY in summary panel (not above footer)
//  ✅ "My Cart" title clearly visible (white, bold, contrasted)
//  ✅ Search/Store icons at far right of centered AppBar
//  ✅ No double scrollbars on desktop
//  ✅ Bottom nav bar on mobile & tablet
//  ✅ AppBar homepage-style gradient
//  ✅ GREEN gradient checkout button
//  ✅ CENTERED MAX-WIDTH LAYOUT FOR WEB — empty margins on both sides
//  ✅ AppBar content also centered
//  ✅ Footer removed on Android/mobile (only visible on desktop)
// ============================================================

import 'package:flutter/material.dart';

// ─── Uncomment when integrating:
// import '../data/sample_data.dart';

// ============================================================
// EMBEDDED DATASET
// ============================================================
const List<Map<String, dynamic>> categories = [
  {
    "name": "Beauty & Cosmetics",
    "icon": "💄",
    "image": "assets/images/category_1.png",
    "subcategories": [
      {"name": "Skin Care",     "image": "assets/images/subcategory_1_1.png", "price": 25,  "stock": 50,  "rating": 4.6, "sold": 312, "tags": ["Popular", "Budget Picks"], "description": "Skin care products enriched with natural oils and vitamins.", "related": ["Nail Polish", "Lipsticks", "Foundation", "Handmade Jewelry"]},
      {"name": "Makeup",        "image": "assets/images/subcategory_1_2.png", "price": 30,  "stock": 40,  "rating": 4.4, "sold": 220, "description": "High-quality makeup essentials for every occasion.", "related": ["Lipsticks", "Eye Liner", "Foundation", "Tattoo Kits"]},
      {"name": "Perfume",       "image": "assets/images/subcategory_1_3.png", "price": 50,  "stock": 30,  "rating": 4.7, "sold": 180, "description": "Fragrances with long-lasting freshness.", "related": ["Lip Gloss", "Moisturizer Cream", "Face Masks", "Henna Cones"]},
      {"name": "Hair Care",     "image": "assets/images/subcategory_1_4.png", "price": 20,  "stock": 60,  "rating": 4.3, "sold": 415, "description": "Shampoos, conditioners, and serums for strong hair.", "related": ["Skin Care", "Face Masks", "Hair Oil", "Clay Pots"]},
      {"name": "Lipsticks",     "image": "assets/images/subcategory_1_5.png", "price": 15,  "stock": 70,  "rating": 4.5, "sold": 560, "description": "Matte and glossy lipsticks in vibrant shades.", "related": ["Makeup", "Eye Liner", "Lip Gloss", "Handmade Jewelry"]},
      {"name": "Nail Polish",   "image": "assets/images/subcategory_1_6.png", "price": 10,  "stock": 100, "rating": 4.2, "sold": 740, "description": "Quick-dry nail polish in trendy colors.", "related": ["Lipsticks", "Beauty Tools", "Foundation", "Tattoo Ink"]},
      {"name": "Face Masks",    "image": "assets/images/subcategory_1_7.png", "price": 12,  "stock": 80,  "rating": 4.6, "sold": 290, "description": "Hydrating face masks to rejuvenate skin.", "related": ["Skin Care", "Hair Care", "Moisturizer Cream", "Handmade Soaps"]},
      {"name": "Foundation",    "image": "assets/images/subcategory_1_8.png", "price": 35,  "stock": 40,  "rating": 4.4, "sold": 175, "description": "Lightweight foundation for a flawless finish.", "related": ["Makeup", "Eye Liner", "Lipsticks", "Tattoo Cones"]},
      {"name": "Eye Liner",     "image": "assets/images/subcategory_1_9.png", "price": 18,  "stock": 90,  "rating": 4.8, "sold": 620, "tags": ["Popular", "Budget Picks", "Gift Ideas"], "description": "Smudge-proof eyeliner for long-lasting wear.", "related": ["Makeup", "Foundation", "Lip Gloss", "Henna Powder"]},
      {"name": "Beauty Tools",  "image": "assets/images/subcategory_1_10.png","price": 22,  "stock": 60,  "rating": 4.3, "sold": 198, "description": "Essential beauty tools: brushes, sponges, applicators.", "related": ["Makeup", "Nail Polish", "Foundation", "Lipsticks"]},
    ]
  },
  {
    "name": "Electronics",
    "icon": "📱",
    "image": "assets/images/category_5.png",
    "subcategories": [
      {"name": "Smartphones",   "image": "assets/images/subcategory_5_1.png", "price": 300, "stock": 20,  "rating": 4.7, "sold": 510, "tags": ["Popular"], "description": "Latest smartphones with advanced features.", "related": ["Laptops", "Earphones", "Phone Cases", "Chargers"]},
      {"name": "Laptops",       "image": "assets/images/subcategory_5_2.png", "price": 700, "stock": 15,  "rating": 4.8, "sold": 245, "description": "High-performance laptops for work and gaming.", "related": ["Smartphones", "Keyboards", "Mouse", "Monitors"]},
      {"name": "Earphones",     "image": "assets/images/subcategory_5_3.png", "price": 40,  "stock": 80,  "rating": 4.5, "sold": 890, "description": "Wireless earphones with noise cancellation.", "related": ["Smartphones", "Laptops", "Speakers", "Chargers"]},
      {"name": "Chargers",      "image": "assets/images/subcategory_5_4.png", "price": 15,  "stock": 100, "rating": 4.2, "sold": 1200,"description": "Fast chargers compatible with all devices.", "related": ["Smartphones", "Earphones", "Power Banks", "Cables"]},
      {"name": "Smart Watch",   "image": "assets/images/subcategory_5_5.png", "price": 120, "stock": 30,  "rating": 4.6, "sold": 340, "tags": ["New"], "description": "Feature-rich smartwatch with health tracking.", "related": ["Smartphones", "Earphones", "Laptops", "Chargers"]},
      {"name": "Tablets",       "image": "assets/images/subcategory_5_6.png", "price": 250, "stock": 20,  "rating": 4.5, "sold": 180, "description": "Portable tablets for work and entertainment.", "related": ["Laptops", "Smartphones", "Earphones", "Keyboards"]},
      {"name": "Keyboards",     "image": "assets/images/subcategory_5_7.png", "price": 35,  "stock": 60,  "rating": 4.3, "sold": 420, "description": "Mechanical and wireless keyboards.", "related": ["Laptops", "Mouse", "Monitors", "Tablets"]},
      {"name": "Mouse",         "image": "assets/images/subcategory_5_8.png", "price": 20,  "stock": 70,  "rating": 4.4, "sold": 560, "description": "Ergonomic wireless mouse for smooth control.", "related": ["Keyboards", "Laptops", "Monitors", "Tablets"]},
      {"name": "Speakers",      "image": "assets/images/subcategory_5_9.png", "price": 60,  "stock": 45,  "rating": 4.6, "sold": 310, "description": "Portable Bluetooth speakers with rich sound.", "related": ["Earphones", "Smartphones", "Laptops", "Chargers"]},
      {"name": "Monitors",      "image": "assets/images/subcategory_5_10.png","price": 180, "stock": 25,  "rating": 4.7, "sold": 155, "description": "HD monitors for work and gaming.", "related": ["Laptops", "Keyboards", "Mouse", "Tablets"]},
    ]
  },
  {
    "name": "Fashion",
    "icon": "👗",
    "image": "assets/images/category_6.png",
    "subcategories": [
      {"name": "Men's Shirts",    "image": "assets/images/subcategory_6_1.png",  "price": 30,  "stock": 50, "rating": 4.3, "sold": 380, "description": "Stylish and comfortable shirts for men.", "related": ["Men's Jeans", "T-Shirts", "Women's Dresses", "Kids Clothing"]},
      {"name": "Men's Jeans",     "image": "assets/images/subcategory_6_2.png",  "price": 40,  "stock": 40, "rating": 4.4, "sold": 290, "description": "Classic and durable jeans for men.", "related": ["Men's Shirts", "T-Shirts", "Shoes", "Women's Jeans"]},
      {"name": "Women's Dresses", "image": "assets/images/subcategory_6_3.png",  "price": 50,  "stock": 30, "rating": 4.6, "sold": 210, "description": "Elegant and fashionable dresses for women.", "related": ["Women's Tops", "Women's Jeans", "Men's Shirts", "Handmade Jewelry"]},
      {"name": "Women's Tops",    "image": "assets/images/subcategory_6_4.png",  "price": 25,  "stock": 70, "rating": 4.5, "sold": 450, "description": "Casual and stylish tops for everyday wear.", "related": ["Women's Dresses", "Women's Jeans", "T-Shirts", "Men's Shirts"]},
      {"name": "T-Shirts",        "image": "assets/images/subcategory_6_5.png",  "price": 20,  "stock": 90, "rating": 4.4, "sold": 720, "description": "Comfortable t-shirts in multiple colors.", "related": ["Men's Shirts", "Women's Tops", "Jeans", "Shoes"]},
      {"name": "Women's Jeans",   "image": "assets/images/subcategory_6_6.png",  "price": 45,  "stock": 40, "rating": 4.5, "sold": 310, "description": "Trendy jeans for women with perfect fit.", "related": ["Women's Dresses", "Women's Tops", "T-Shirts", "Shoes"]},
      {"name": "Jackets",         "image": "assets/images/subcategory_6_7.png",  "price": 60,  "stock": 25, "rating": 4.6, "sold": 185, "description": "Warm and stylish jackets for men and women.", "related": ["Men's Shirts", "Women's Dresses", "T-Shirts", "Shoes"]},
      {"name": "Shoes",           "image": "assets/images/subcategory_6_8.png",  "price": 35,  "stock": 60, "rating": 4.5, "sold": 540, "description": "Comfortable shoes for daily wear.", "related": ["Men's Shirts", "Women's Dresses", "Men's Jeans", "T-Shirts"]},
      {"name": "Accessories",     "image": "assets/images/subcategory_6_9.png",  "price": 15,  "stock": 80, "rating": 4.2, "sold": 680, "description": "Belts, scarves, hats and fashion accessories.", "related": ["T-Shirts", "Shoes", "Women's Dresses", "Men's Shirts"]},
      {"name": "Handbags",        "image": "assets/images/subcategory_6_10.png", "price": 50,  "stock": 30, "rating": 4.7, "sold": 215, "description": "Trendy handbags for all occasions.", "related": ["Accessories", "Women's Dresses", "Women's Tops", "Shoes"]},
    ]
  },
  {
    "name": "Home Appliances",
    "icon": "🏠",
    "image": "assets/images/category_7.png",
    "subcategories": [
      {"name": "Refrigerators",  "image": "assets/images/subcategory_7_1.png",  "price": 500, "stock": 15, "rating": 4.5, "sold": 120, "description": "Energy-efficient refrigerators.", "related": ["Microwave", "Washing Machine", "Air Conditioner", "Vacuum Cleaner"]},
      {"name": "Microwave",      "image": "assets/images/subcategory_7_2.png",  "price": 120, "stock": 30, "rating": 4.4, "sold": 230, "description": "High-performance microwave ovens.", "related": ["Refrigerators", "Ovens", "Air Conditioner", "Blenders"]},
      {"name": "Washing Machine","image": "assets/images/subcategory_7_3.png",  "price": 400, "stock": 20, "rating": 4.6, "sold": 95,  "description": "Efficient washing machines for easy laundry.", "related": ["Dryers", "Refrigerators", "Microwave", "Vacuum Cleaner"]},
      {"name": "Air Conditioner","image": "assets/images/subcategory_7_4.png",  "price": 350, "stock": 25, "rating": 4.5, "sold": 145, "description": "Keep your home cool with AC units.", "related": ["Refrigerators", "Fans", "Heaters", "Microwave"]},
      {"name": "Vacuum Cleaner", "image": "assets/images/subcategory_7_5.png",  "price": 150, "stock": 40, "rating": 4.3, "sold": 190, "description": "High-power vacuum cleaners.", "related": ["Washing Machine", "Microwave", "Air Conditioner", "Blenders"]},
      {"name": "Blender",        "image": "assets/images/subcategory_7_6.png",  "price": 60,  "stock": 50, "rating": 4.4, "sold": 320, "description": "Blenders for smoothies and cooking.", "related": ["Juicer", "Microwave", "Refrigerators", "Vacuum Cleaner"]},
      {"name": "Oven",           "image": "assets/images/subcategory_7_7.png",  "price": 200, "stock": 30, "rating": 4.5, "sold": 165, "description": "Electric ovens for baking and cooking.", "related": ["Microwave", "Blender", "Air Conditioner", "Refrigerators"]},
      {"name": "Fans",           "image": "assets/images/subcategory_7_8.png",  "price": 50,  "stock": 60, "rating": 4.2, "sold": 480, "description": "Ceiling and table fans.", "related": ["Air Conditioner", "Refrigerators", "Blender", "Microwave"]},
      {"name": "Heaters",        "image": "assets/images/subcategory_7_9.png",  "price": 70,  "stock": 40, "rating": 4.3, "sold": 215, "description": "Electric heaters for warm rooms.", "related": ["Air Conditioner", "Blender", "Microwave", "Refrigerators"]},
      {"name": "Dishwasher",     "image": "assets/images/subcategory_7_10.png", "price": 300, "stock": 25, "rating": 4.6, "sold": 88,  "description": "Automatic dishwashers for clean dishes.", "related": ["Oven", "Microwave", "Refrigerators", "Blender"]},
    ]
  },
  {
    "name": "Sports",
    "icon": "⚽",
    "image": "assets/images/category_8.png",
    "subcategories": [
      {"name": "Football",        "image": "assets/images/subcategory_8_1.png", "price": 25, "stock": 50,  "rating": 4.5, "sold": 420, "description": "Official size footballs for training.", "related": ["Basketball", "Tennis Racket", "Yoga Mat", "T-Shirts"]},
      {"name": "Basketball",      "image": "assets/images/subcategory_8_2.png", "price": 30, "stock": 40,  "rating": 4.4, "sold": 310, "description": "High-quality basketballs indoor/outdoor.", "related": ["Football", "Tennis Racket", "Sports Shoes", "Yoga Mat"]},
      {"name": "Tennis Racket",   "image": "assets/images/subcategory_8_3.png", "price": 50, "stock": 30,  "rating": 4.6, "sold": 185, "description": "Professional tennis rackets.", "related": ["Football", "Basketball", "Yoga Mat", "Sports Shoes"]},
      {"name": "Yoga Mat",        "image": "assets/images/subcategory_8_4.png", "price": 20, "stock": 60,  "rating": 4.7, "sold": 540, "description": "Comfortable non-slip yoga mats.", "related": ["Sports Shoes", "Tennis Racket", "Dumbbells", "Football"]},
      {"name": "Sports Shoes",    "image": "assets/images/subcategory_8_5.png", "price": 60, "stock": 70,  "rating": 4.5, "sold": 390, "description": "Durable sports shoes for all games.", "related": ["Yoga Mat", "Football", "Basketball", "Tennis Racket"]},
      {"name": "Dumbbells",       "image": "assets/images/subcategory_8_6.png", "price": 40, "stock": 50,  "rating": 4.6, "sold": 270, "description": "Weight training dumbbells for home.", "related": ["Yoga Mat", "Sports Shoes", "Tennis Racket", "Basketball"]},
      {"name": "Cricket Bat",     "image": "assets/images/subcategory_8_7.png", "price": 35, "stock": 25,  "rating": 4.5, "sold": 190, "description": "Premium cricket bats.", "related": ["Football", "Sports Shoes", "Cricket Ball", "Tennis Racket"]},
      {"name": "Cricket Ball",    "image": "assets/images/subcategory_8_8.png", "price": 10, "stock": 60,  "rating": 4.3, "sold": 680, "description": "Durable cricket balls.", "related": ["Cricket Bat", "Football", "Sports Shoes", "Tennis Racket"]},
      {"name": "Badminton Racket","image": "assets/images/subcategory_8_9.png", "price": 25, "stock": 45,  "rating": 4.4, "sold": 310, "description": "Lightweight badminton rackets.", "related": ["Shuttlecock", "Tennis Racket", "Sports Shoes", "Yoga Mat"]},
      {"name": "Shuttlecock",     "image": "assets/images/subcategory_8_10.png","price": 5,  "stock": 100, "rating": 4.1, "sold": 920, "description": "High-quality shuttlecocks.", "related": ["Badminton Racket", "Tennis Racket", "Yoga Mat", "Sports Shoes"]},
    ]
  },
  {
    "name": "Books",
    "icon": "📚",
    "image": "assets/images/category_9.png",
    "subcategories": [
      {"name": "Fiction",          "image": "assets/images/subcategory_9_1.png",  "price": 15, "stock": 100, "rating": 4.6, "sold": 540, "description": "Engaging fiction books across genres.", "related": ["Non-Fiction", "Comics", "Science", "Children's Books"]},
      {"name": "Non-Fiction",      "image": "assets/images/subcategory_9_2.png",  "price": 20, "stock": 80,  "rating": 4.5, "sold": 380, "description": "Informative biographies and history books.", "related": ["Fiction", "Science", "Self-Help", "Comics"]},
      {"name": "Science",          "image": "assets/images/subcategory_9_3.png",  "price": 25, "stock": 50,  "rating": 4.4, "sold": 215, "description": "Books on science topics and discoveries.", "related": ["Fiction", "Non-Fiction", "Technology", "Comics"]},
      {"name": "Self-Help",        "image": "assets/images/subcategory_9_4.png",  "price": 18, "stock": 60,  "rating": 4.7, "sold": 680, "description": "Books for personal development.", "related": ["Non-Fiction", "Fiction", "Technology", "Science"]},
      {"name": "Children's Books", "image": "assets/images/subcategory_9_5.png",  "price": 12, "stock": 120, "rating": 4.8, "sold": 430, "description": "Illustrated stories for children.", "related": ["Comics", "Fiction", "Self-Help", "Non-Fiction"]},
      {"name": "Comics",           "image": "assets/images/subcategory_9_6.png",  "price": 10, "stock": 90,  "rating": 4.5, "sold": 760, "description": "Comic books with superheroes.", "related": ["Fiction", "Children's Books", "Science", "Non-Fiction"]},
      {"name": "Technology",       "image": "assets/images/subcategory_9_7.png",  "price": 30, "stock": 40,  "rating": 4.6, "sold": 290, "description": "Books on tech and programming.", "related": ["Science", "Self-Help", "Non-Fiction", "Fiction"]},
      {"name": "History",          "image": "assets/images/subcategory_9_8.png",  "price": 22, "stock": 70,  "rating": 4.4, "sold": 350, "description": "Historical events and biographies.", "related": ["Non-Fiction", "Science", "Self-Help", "Fiction"]},
      {"name": "Art & Design",     "image": "assets/images/subcategory_9_9.png",  "price": 28, "stock": 50,  "rating": 4.6, "sold": 180, "description": "Books on art and creative techniques.", "related": ["Fiction", "Comics", "Children's Books", "Non-Fiction"]},
      {"name": "Cookbooks",        "image": "assets/images/subcategory_9_10.png", "price": 18, "stock": 60,  "rating": 4.5, "sold": 410, "description": "Recipe books for delicious meals.", "related": ["Self-Help", "Science", "Fiction", "Children's Books"]},
    ]
  },
  {
    "name": "Grocery",
    "icon": "🛒",
    "image": "assets/images/category_10.png",
    "subcategories": [
      {"name": "Fruits",       "image": "assets/images/subcategory_10_1.png",  "price": 3,  "stock": 200, "rating": 4.6, "sold": 1200, "description": "Fresh seasonal fruits sourced locally.", "related": ["Vegetables", "Dairy", "Snacks", "Juices"]},
      {"name": "Vegetables",   "image": "assets/images/subcategory_10_2.png",  "price": 2,  "stock": 180, "rating": 4.5, "sold": 980,  "description": "Fresh vegetables for daily cooking.", "related": ["Fruits", "Dairy", "Snacks", "Juices"]},
      {"name": "Dairy",        "image": "assets/images/subcategory_10_3.png",  "price": 5,  "stock": 150, "rating": 4.7, "sold": 870,  "description": "Milk, cheese, butter and dairy products.", "related": ["Fruits", "Vegetables", "Bakery", "Juices"]},
      {"name": "Bakery",       "image": "assets/images/subcategory_10_4.png",  "price": 7,  "stock": 100, "rating": 4.4, "sold": 530,  "description": "Freshly baked bread, cakes, pastries.", "related": ["Dairy", "Snacks", "Juices", "Fruits"]},
      {"name": "Snacks",       "image": "assets/images/subcategory_10_5.png",  "price": 4,  "stock": 200, "rating": 4.3, "sold": 1400, "description": "Chips, cookies, and packaged snacks.", "related": ["Fruits", "Vegetables", "Bakery", "Dairy"]},
      {"name": "Juices",       "image": "assets/images/subcategory_10_6.png",  "price": 6,  "stock": 150, "rating": 4.5, "sold": 760,  "description": "Natural fruit juices and smoothies.", "related": ["Fruits", "Snacks", "Dairy", "Bakery"]},
      {"name": "Rice & Grains","image": "assets/images/subcategory_10_7.png",  "price": 10, "stock": 100, "rating": 4.6, "sold": 640,  "description": "High-quality rice, wheat, and grains.", "related": ["Pulses", "Vegetables", "Dairy", "Fruits"]},
      {"name": "Pulses",       "image": "assets/images/subcategory_10_8.png",  "price": 8,  "stock": 120, "rating": 4.4, "sold": 490,  "description": "Lentils, beans, and healthy pulses.", "related": ["Rice & Grains", "Vegetables", "Dairy", "Fruits"]},
      {"name": "Spices",       "image": "assets/images/subcategory_10_9.png",  "price": 3,  "stock": 180, "rating": 4.5, "sold": 830,  "description": "Essential spices to enhance flavor.", "related": ["Rice & Grains", "Vegetables", "Dairy", "Fruits"]},
      {"name": "Oils",         "image": "assets/images/subcategory_10_10.png", "price": 5,  "stock": 160, "rating": 4.3, "sold": 580,  "description": "Cooking oils: olive, sunflower, vegetable.", "related": ["Rice & Grains", "Vegetables", "Dairy", "Snacks"]},
    ]
  },
];

// ============================================================
// HELPERS
// ============================================================
Map<String, dynamic>? _findSubcategory(String name) {
  for (final cat in categories) {
    for (final sub in (cat['subcategories'] as List)) {
      if ((sub['name'] as String) == name) return sub as Map<String, dynamic>;
    }
  }
  return null;
}

Map<String, dynamic>? _findCategoryForProduct(String name) {
  for (final cat in categories) {
    for (final sub in (cat['subcategories'] as List)) {
      if ((sub['name'] as String) == name) return cat as Map<String, dynamic>;
    }
  }
  return null;
}

// ============================================================
// CART ITEM MODEL
// ============================================================
class CartItem {
  final String id;
  final String categoryName;
  final String categoryIcon;
  final String productName;
  final String imageAsset;
  final double price;
  final double originalPrice;
  final int discount;
  final double rating;
  final int sold;
  final String description;
  final List<String> related;
  final List<String> tags;
  final String variant;
  int qty;
  bool selected;
  bool saved;

  CartItem({
    required this.id,
    required this.categoryName,
    required this.categoryIcon,
    required this.productName,
    required this.imageAsset,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
    required this.sold,
    required this.description,
    required this.related,
    required this.tags,
    required this.variant,
    this.qty = 1,
    this.selected = true,
    this.saved = false,
  });
}

// ============================================================
// THEME COLORS
// ============================================================
class CZ {
  static const primary   = Color(0xFFE63B2E);
  static const accent    = Color(0xFFFF8C00);
  static const bg        = Color(0xFFF2F2F2);
  static const white     = Colors.white;
  static const dark      = Color(0xFF1A1A1A);
  static const mid       = Color(0xFF555555);
  static const grey      = Color(0xFF9E9E9E);
  static const light     = Color(0xFFEEEEEE);
  static const green     = Color(0xFF4CAF50);
  static const darkGreen = Color(0xFF2E7D32);
  static const gold      = Color(0xFFFFB300);
  static const teal      = Color(0xFF00838F);
  static const red       = Color(0xFFD32F2F);
  static const star      = Color(0xFFFFC107);
  static const orange    = Color(0xFFFF6F00);
  static const amber     = Color(0xFFFF9800);
}

// ============================================================
// BREAKPOINTS
// ============================================================
class _BP {
  static double w(BuildContext c) => MediaQuery.sizeOf(c).width;
  static bool isWide(BuildContext c)    => w(c) >= 720;
  static bool isDesktop(BuildContext c) => w(c) >= 900;
}

// ============================================================
// ENTRY POINT
// ============================================================
void main() => runApp(const CartzaApp());

class CartzaApp extends StatelessWidget {
  const CartzaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartza',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: CZ.green,
        useMaterial3: true,
        fontFamily: 'Roboto',
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith(
                  (s) => s.contains(WidgetState.selected) ? CZ.green : null),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        ),
      ),
      home: const CartPage(),
    );
  }
}

// ============================================================
// CART PAGE
// ============================================================
class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<CartItem> _items;
  final _searchCtrl = TextEditingController();
  bool _searchOpen  = false;
  int  _navIdx      = 2;

  @override
  void initState() {
    super.initState();
    _items = _buildInitialCart();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  List<CartItem> _buildInitialCart() {
    final result = <CartItem>[];
    int id = 1;
    for (final cat in categories) {
      final subs = cat['subcategories'] as List;
      if (subs.isEmpty) continue;
      final sub       = subs[0] as Map<String, dynamic>;
      final basePrice = (sub['price'] as num).toDouble();
      final discPct   = ((id % 4 + 1) * 10);
      final origPrice = (basePrice * 100 / (100 - discPct));
      result.add(CartItem(
        id:            'item_$id',
        categoryName:  cat['name']  as String,
        categoryIcon:  cat['icon']  as String? ?? '📦',
        productName:   sub['name']  as String,
        imageAsset:    sub['image'] as String? ?? '',
        price:         basePrice,
        originalPrice: double.parse(origPrice.toStringAsFixed(0)),
        discount:      discPct,
        rating:        (sub['rating'] as num?)?.toDouble() ?? 4.5,
        sold:          (sub['sold']   as num?)?.toInt()    ?? 100,
        description:   sub['description'] as String? ?? '',
        related:       List<String>.from(sub['related'] as List? ?? []),
        tags:          List<String>.from(sub['tags']    as List? ?? []),
        variant:       'Default · 1 unit',
      ));
      id++;
    }
    return result;
  }

  bool   get _allSelected => _items.isNotEmpty && _items.every((e) => e.selected);
  double get _subtotal    => _items.where((e) => e.selected).fold(0.0, (s, e) => s + e.price * e.qty);
  double get _savings     => _items.where((e) => e.selected).fold(0.0, (s, e) => s + (e.originalPrice - e.price) * e.qty);
  double get _voucher     => _subtotal > 0 ? 200.0 : 0.0;
  double get _grand       => _subtotal > 0 ? (_subtotal - _voucher) : 0.0;
  int    get _selCount    => _items.where((e) => e.selected).length;

  Map<String, List<CartItem>> get _grouped {
    final map = <String, List<CartItem>>{};
    for (var item in _items) {
      map.putIfAbsent(item.categoryName, () => []).add(item);
    }
    return map;
  }

  List<Map<String, dynamic>> get _allRelated {
    final inCart = _items.map((e) => e.productName).toSet();
    final seen   = <String>{};
    final result = <Map<String, dynamic>>[];
    for (final item in _items) {
      for (final relName in item.related) {
        if (!inCart.contains(relName) && !seen.contains(relName)) {
          seen.add(relName);
          final sub = _findSubcategory(relName);
          final cat = _findCategoryForProduct(relName);
          if (sub != null && cat != null) {
            result.add({
              'name':    relName,
              'image':   sub['image']  as String? ?? '',
              'price':   (sub['price'] as num).toDouble(),
              'rating':  (sub['rating'] as num?)?.toDouble() ?? 4.5,
              'sold':    (sub['sold']   as num?)?.toInt()    ?? 0,
              'catName': cat['name']   as String,
              'catIcon': cat['icon']   as String? ?? '📦',
              'catImage':cat['image']  as String? ?? '',
              'desc':    sub['description'] as String? ?? '',
              'related': List<String>.from(sub['related'] as List? ?? []),
              'tags':    List<String>.from(sub['tags']   as List? ?? []),
            });
          }
        }
      }
    }
    return result;
  }

  void _toggleAll(bool v) => setState(() { for (var i in _items) i.selected = v; });
  void _changeQty(CartItem item, int d) => setState(() { item.qty = (item.qty + d).clamp(1, 99); });
  void _toggleSave(CartItem item) => setState(() => item.saved = !item.saved);

  void _removeItem(CartItem item) {
    final idx = _items.indexOf(item);
    setState(() => _items.remove(item));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${item.productName} removed'),
      backgroundColor: CZ.dark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: CZ.gold,
        onPressed: () => setState(() => _items.insert(idx, item)),
      ),
    ));
  }

  void _removeSelected() {
    final toRemove = _items.where((e) => e.selected).toList();
    if (toRemove.isEmpty) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('Remove Items', style: TextStyle(fontWeight: FontWeight.w700)),
        content: Text('Remove ${toRemove.length} selected item(s) from cart?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _items.removeWhere((e) => e.selected));
            },
            style: ElevatedButton.styleFrom(backgroundColor: CZ.red, foregroundColor: CZ.white),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _addProductToCart(Map<String, dynamic> prod) {
    final name = prod['name'] as String;
    if (_items.any((e) => e.productName == name)) {
      _showToast('$name already in cart!');
      return;
    }
    final price = (prod['price'] as num).toDouble();
    setState(() {
      _items.add(CartItem(
        id:            'item_${DateTime.now().millisecondsSinceEpoch}',
        categoryName:  prod['catName']  as String? ?? 'Store',
        categoryIcon:  prod['catIcon']  as String? ?? '📦',
        productName:   name,
        imageAsset:    prod['image']    as String? ?? '',
        price:         price,
        originalPrice: (price * 1.3).roundToDouble(),
        discount:      23,
        rating:        (prod['rating']  as num?)?.toDouble() ?? 4.5,
        sold:          (prod['sold']    as num?)?.toInt()    ?? 0,
        description:   prod['desc']     as String? ?? '',
        related:       List<String>.from(prod['related'] as List? ?? []),
        tags:          List<String>.from(prod['tags']   as List? ?? []),
        variant:       'Default · 1 unit',
      ));
    });
    _showToast('$name added to cart!');
  }

  void _showToast(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: CZ.teal,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }

  void _showItemMenu(CartItem item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => _ItemMenuSheet(
        item: item,
        onSave:           () { Navigator.pop(context); _toggleSave(item); },
        onRemove:         () { Navigator.pop(context); _removeItem(item); },
        onViewRelated:    () { Navigator.pop(context); _showRelatedSheet(item); },
        onShareItem:      () { Navigator.pop(context); _showToast('Link copied!'); },
        onMoveToWishlist: () {
          Navigator.pop(context);
          setState(() { item.saved = true; _items.remove(item); });
          _showToast('Moved to Wishlist ❤️');
        },
      ),
    );
  }

  void _showRelatedSheet(CartItem item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => _RelatedProductsSheet(
        item: item,
        onAddToCart:  (prod) { Navigator.pop(context); _addProductToCart(prod); },
        onProductTap: (prod) {
          Navigator.pop(context);
          _openStoreSheet(initialCatName: prod['catName'] as String?);
        },
      ),
    );
  }

  void _openStoreSheet({String? initialCatName}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => _CategoryStoreSheet(
        categories: categories,
        initialCatName: initialCatName,
        onProductSelected: (sub, cat) {
          Navigator.pop(context);
          _addProductToCart({
            'name':    sub['name'],
            'image':   sub['image']       ?? '',
            'price':   sub['price'],
            'rating':  sub['rating']      ?? 4.5,
            'sold':    sub['sold']         ?? 0,
            'catName': cat['name'],
            'catIcon': cat['icon']        ?? '📦',
            'catImage':cat['image']       ?? '',
            'desc':    sub['description'] ?? '',
            'related': sub['related']     ?? [],
            'tags':    sub['tags']        ?? [],
          });
        },
      ),
    );
  }

  void _onSearch(String q) {
    if (q.trim().isEmpty) return;
    _openStoreSheet();
  }

  void _checkout() {
    if (_selCount == 0) { _showToast('Select at least one item!'); return; }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: const Text('🎉 Order Placed!',
            style: TextStyle(fontWeight: FontWeight.w800)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$_selCount item(s) ordered',
                style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 8),
            Text('Total: Rs.${_grand.toStringAsFixed(0)}',
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800, color: CZ.green)),
            const SizedBox(height: 4),
            const Text('Estimated delivery: Tomorrow',
                style: TextStyle(color: CZ.grey, fontSize: 12)),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _items.removeWhere((e) => e.selected));
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: CZ.green, foregroundColor: CZ.white),
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================
  @override
  Widget build(BuildContext context) {
    final isWide    = _BP.isWide(context);
    final isDesktop = _BP.isDesktop(context);

    return Scaffold(
      backgroundColor: CZ.bg,
      appBar: _buildGradientAppBar(context),
      // ✅ On desktop: NO bottom nav
      // ✅ On mobile/tablet: bottom nav
      bottomNavigationBar: isDesktop ? null : _buildBottomNav(context),
      body: _items.isEmpty
          ? Column(children: [
        Expanded(child: _EmptyCart(onShop: () => _openStoreSheet())),
        if (!isDesktop) const SizedBox.shrink(),
      ])
          : isWide
          ? _buildDesktopBody(isDesktop)
          : _buildMobileBody(),
    );
  }

  // ============================================================
  // DESKTOP BODY — Centered max-width layout
  // ✅ Single CustomScrollView — ONE scrollbar
  // ✅ Right panel sticky
  // ✅ Checkout button only in summary (no extra bar)
  // ✅ Content centered with max-width 1200
  // ✅ Footer present on desktop
  // ============================================================
  Widget _buildDesktopBody(bool isDesktop) {
    return CustomScrollView(
      slivers: [
        // ── Main content row (left items + right sticky panel)
        SliverToBoxAdapter(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── LEFT: Cart items list
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _SelectAllRow(
                            allSelected: _allSelected,
                            onToggleAll: _toggleAll,
                            onDeleteSelected: _removeSelected,
                          ),
                          ..._grouped.entries.map((e) => _StoreSectionWidget(
                            categoryName: e.key,
                            categoryIcon: _items
                                .firstWhere((i) => i.categoryName == e.key)
                                .categoryIcon,
                            items: e.value,
                            onQty: _changeQty,
                            onRemove: _removeItem,
                            onSave: _toggleSave,
                            onMenuTap: _showItemMenu,
                            onCategoryTap: () => _openStoreSheet(initialCatName: e.key),
                          )),
                          if (_allRelated.isNotEmpty)
                            _RelatedBottomSection(
                              products: _allRelated,
                              onAdd: _addProductToCart,
                              onSeeAll: () => _openStoreSheet(),
                              onProductTap: (prod) =>
                                  _openStoreSheet(initialCatName: prod['catName'] as String?),
                            ),
                          _CategoryBrowseRow(
                            categories: categories,
                            onTap: (catName) => _openStoreSheet(initialCatName: catName),
                          ),
                        ],
                      ),
                    ),
                    // ── RIGHT: Sticky summary panel (contains checkout button)
                    SizedBox(
                      width: 310,
                      child: _StickyRightPanel(
                        subtotal: _subtotal,
                        savings: _savings,
                        voucher: _voucher,
                        grand: _grand,
                        itemCount: _items.length,
                        allSelected: _allSelected,
                        onToggleAll: _toggleAll,
                        selectedCount: _selCount,
                        onCheckout: _checkout,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // ── FOOTER — full width at bottom (DESKTOP ONLY)
        const SliverToBoxAdapter(child: _CartFooter()),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  // ============================================================
  // MOBILE BODY — single ListView (NO FOOTER on Android/mobile)
  // ============================================================
  Widget _buildMobileBody() {
    return ListView(
      children: [
        _SelectAllRow(
          allSelected: _allSelected,
          onToggleAll: _toggleAll,
          onDeleteSelected: _removeSelected,
        ),
        ..._grouped.entries.map((e) => _StoreSectionWidget(
          categoryName: e.key,
          categoryIcon: _items
              .firstWhere((i) => i.categoryName == e.key)
              .categoryIcon,
          items: e.value,
          onQty: _changeQty,
          onRemove: _removeItem,
          onSave: _toggleSave,
          onMenuTap: _showItemMenu,
          onCategoryTap: () => _openStoreSheet(initialCatName: e.key),
        )),
        _DeliveryBanner(),
        _VoucherSection(),
        _FlashBanner(),
        _SummarySection(
          subtotal: _subtotal,
          savings: _savings,
          voucher: _voucher,
          grand: _grand,
          itemCount: _items.length,
        ),
        if (_allRelated.isNotEmpty)
          _RelatedBottomSection(
            products: _allRelated,
            onAdd: _addProductToCart,
            onSeeAll: () => _openStoreSheet(),
            onProductTap: (prod) =>
                _openStoreSheet(initialCatName: prod['catName'] as String?),
          ),
        _CategoryBrowseRow(
          categories: categories,
          onTap: (catName) => _openStoreSheet(initialCatName: catName),
        ),
        // Footer removed entirely on mobile/Android
        const SizedBox(height: 16),
      ],
    );
  }

  // ── Bottom Navigation Bar (mobile + tablet only) ───────────
  Widget _buildBottomNav(BuildContext context) {
    if (_items.isEmpty) return _buildNavBar(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mobile bottom bar (compact checkout summary)
        _MobileCheckoutBar(
          allSelected:   _allSelected,
          onToggleAll:   _toggleAll,
          grandTotal:    _grand,
          savings:       _savings,
          selectedCount: _selCount,
          onCheckout:    _checkout,
        ),
        _buildNavBar(context),
      ],
    );
  }

  Widget _buildNavBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CZ.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, -2)),
        ],
      ),
      child: NavigationBar(
        height: 62,
        selectedIndex: _navIdx > 4 ? 0 : _navIdx,
        backgroundColor: Colors.transparent,
        elevation: 0,
        indicatorColor: CZ.green.withOpacity(0.12),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (i) {
          setState(() => _navIdx = i);
          if (i != 2) Navigator.maybePop(context);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded, color: CZ.green),
            label: 'Home',
          ),
          const NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded, color: CZ.green),
            label: 'Categories',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: _items.isNotEmpty,
              label: Text('${_items.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            selectedIcon: const Icon(Icons.shopping_cart_rounded, color: CZ.green),
            label: 'My Cart',
          ),
          const NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications_rounded, color: CZ.green),
            label: 'Alerts',
          ),
          const NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: CZ.green),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // ── Gradient AppBar with centered content ──────────────────
  // ✅ "My Cart" clearly visible
  // ✅ Search/Store icons at far right of centered container
  // ✅ Whole AppBar content max-width 1200
  PreferredSizeWidget _buildGradientAppBar(BuildContext context) {
    final isDesktop = _BP.isDesktop(context);
    return PreferredSize(
      preferredSize: Size.fromHeight(_searchOpen ? 108 : 58),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [CZ.darkGreen, CZ.green, Color(0xFFAED581), CZ.amber, CZ.orange],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [BoxShadow(color: Color(0x44000000), blurRadius: 8, offset: Offset(0, 2))],
        ),
        child: SafeArea(
          bottom: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(children: [
                        // Back button
                        IconButton(
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 6),
                        // ✅ "My Cart" title
                        Text(
                          'My Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                            shadows: const [Shadow(color: Color(0x88000000), blurRadius: 6, offset: Offset(0, 1))],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(12)),
                          child: Text('${_items.length} items',
                              style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                        ),
                        const Spacer(),
                        if (_items.isNotEmpty)
                          TextButton(
                            onPressed: () => setState(() => _items.clear()),
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white70,
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                            child: const Text('Clear', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                          ),
                        const SizedBox(width: 2),
                        // Search icon
                        Container(
                          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                            onPressed: () => setState(() { _searchOpen = !_searchOpen; if (!_searchOpen) _searchCtrl.clear(); }),
                            icon: Icon(_searchOpen ? Icons.close : Icons.search, color: Colors.white, size: 22),
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Store icon
                        Container(
                          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                            onPressed: () => _openStoreSheet(),
                            icon: const Icon(Icons.storefront_outlined, color: Colors.white, size: 22),
                            padding: const EdgeInsets.all(6),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ]),
                    ),
                  ),
                  // Animated search bar
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 200),
                    crossFadeState: _searchOpen ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    firstChild: const SizedBox.shrink(),
                    secondChild: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                        child: TextField(
                          controller: _searchCtrl,
                          autofocus: true,
                          onSubmitted: _onSearch,
                          decoration: InputDecoration(
                            hintText: 'Search products…',
                            hintStyle: const TextStyle(color: CZ.grey, fontSize: 13),
                            prefixIcon: const Icon(Icons.search, color: CZ.grey, size: 18),
                            suffixIcon: GestureDetector(
                              onTap: () => _onSearch(_searchCtrl.text),
                              child: const Icon(Icons.arrow_forward, color: CZ.green, size: 18),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
      ),
    );
  }
}

// ============================================================
// STICKY RIGHT PANEL (Desktop)
// ============================================================
class _StickyRightPanel extends StatelessWidget {
  final double subtotal, savings, voucher, grand;
  final int itemCount, selectedCount;
  final bool allSelected;
  final ValueChanged<bool> onToggleAll;
  final VoidCallback onCheckout;

  const _StickyRightPanel({
    required this.subtotal,
    required this.savings,
    required this.voucher,
    required this.grand,
    required this.itemCount,
    required this.allSelected,
    required this.onToggleAll,
    required this.selectedCount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
      child: Align(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DeliveryBanner(),
            const SizedBox(height: 8),
            _VoucherSection(),
            const SizedBox(height: 8),
            _EnhancedSummarySection(
              subtotal: subtotal,
              savings: savings,
              voucher: voucher,
              grand: grand,
              itemCount: itemCount,
              selectedCount: selectedCount,
              onCheckout: onCheckout,
            ),
            const SizedBox(height: 8),
            _FlashBanner(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ENHANCED SUMMARY SECTION (Desktop right panel)
// ✅ Includes checkout button at BOTTOM of summary card
// ============================================================
class _EnhancedSummarySection extends StatelessWidget {
  final double subtotal, savings, voucher, grand;
  final int itemCount, selectedCount;
  final VoidCallback onCheckout;

  const _EnhancedSummarySection({
    required this.subtotal,
    required this.savings,
    required this.voucher,
    required this.grand,
    required this.itemCount,
    required this.selectedCount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CZ.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(children: [
            const Icon(Icons.receipt_long_outlined, color: CZ.green, size: 18),
            const SizedBox(width: 6),
            const Text('Order Summary', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: CZ.dark)),
          ]),
          const SizedBox(height: 14),
          _sRow('Subtotal ($itemCount items)', 'Rs.${subtotal.toStringAsFixed(0)}', CZ.dark, false),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: CZ.green.withOpacity(0.07), borderRadius: BorderRadius.circular(6)),
            child: _sRow('You Save', '- Rs.${savings.toStringAsFixed(0)}', CZ.green, true),
          ),
          const SizedBox(height: 8),
          _sRow('Delivery Fee', 'FREE', CZ.green, true),
          const SizedBox(height: 8),
          _sRow('Platform Voucher', '- Rs.${voucher.toStringAsFixed(0)}', CZ.green, true),
          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: Color(0xFFF0F0F0), thickness: 1.5)),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)]),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CZ.green.withOpacity(0.2)),
            ),
            child: Row(children: [
              const Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                Text('Grand Total', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CZ.dark)),
                Text('All taxes included', style: TextStyle(fontSize: 10, color: CZ.grey)),
              ]),
              const Spacer(),
              Flexible(
                child: Text('Rs.${grand.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: CZ.green),
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ),
          const SizedBox(height: 14),
          // ✅ CHECKOUT BUTTON — full width, inside summary panel
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: onCheckout,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  gradient: selectedCount > 0
                      ? const LinearGradient(colors: [CZ.darkGreen, CZ.green], begin: Alignment.topLeft, end: Alignment.bottomRight)
                      : null,
                  color: selectedCount > 0 ? null : CZ.grey,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: selectedCount > 0 ? [BoxShadow(color: CZ.green.withOpacity(0.4), blurRadius: 12, offset: const Offset(0, 5))] : null,
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text('Checkout ($selectedCount)', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15, letterSpacing: 0.3)),
                ]),
              ),
            ),
          ),
          if (savings > 0) ...[
            const SizedBox(height: 8),
            Center(child: Text('🎉 You\'re saving Rs.${savings.toStringAsFixed(0)} on this order!',
                style: const TextStyle(fontSize: 11, color: CZ.green, fontWeight: FontWeight.w600))),
          ],
        ],
      ),
    );
  }

  Widget _sRow(String label, String value, Color vc, bool bold) {
    return Row(children: [
      Expanded(child: Text(label, style: const TextStyle(fontSize: 13, color: CZ.grey), overflow: TextOverflow.ellipsis)),
      const SizedBox(width: 8),
      Text(value, style: TextStyle(fontSize: 13, color: vc, fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
    ]);
  }
}

// ============================================================
// MOBILE CHECKOUT BAR (only for mobile/tablet)
// ============================================================
class _MobileCheckoutBar extends StatelessWidget {
  final bool allSelected;
  final ValueChanged<bool> onToggleAll;
  final double grandTotal, savings;
  final int selectedCount;
  final VoidCallback onCheckout;

  const _MobileCheckoutBar({
    required this.allSelected,
    required this.onToggleAll,
    required this.grandTotal,
    required this.savings,
    required this.selectedCount,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: CZ.white, boxShadow: [BoxShadow(color: Color(0x18000000), blurRadius: 12, offset: Offset(0, -3))]),
      child: SafeArea(
        top: false,
        child: Container(
          height: 62,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(children: [
            SizedBox(
              width: 28,
              height: 28,
              child: Checkbox(
                value: allSelected,
                onChanged: (v) => onToggleAll(v ?? false),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: CZ.green,
              ),
            ),
            const SizedBox(width: 4),
            const Text('All', style: TextStyle(fontSize: 12, color: CZ.dark, fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 10, color: CZ.grey)),
                  Text('Rs.${grandTotal.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: CZ.green),
                      overflow: TextOverflow.ellipsis),
                  if (savings > 0)
                    Text('Save Rs.${savings.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 9, color: CZ.green),
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onCheckout,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                decoration: BoxDecoration(
                  gradient: selectedCount > 0 ? const LinearGradient(colors: [CZ.darkGreen, CZ.green]) : null,
                  color: selectedCount > 0 ? null : CZ.grey,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: selectedCount > 0 ? [BoxShadow(color: CZ.green.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))] : null,
                ),
                child: Text('Checkout ($selectedCount)',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ============================================================
// SELECT ALL ROW
// ============================================================
class _SelectAllRow extends StatelessWidget {
  final bool allSelected;
  final ValueChanged<bool> onToggleAll;
  final VoidCallback onDeleteSelected;

  const _SelectAllRow({
    required this.allSelected,
    required this.onToggleAll,
    required this.onDeleteSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CZ.white,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(children: [
        Checkbox(
          value: allSelected,
          onChanged: (v) => onToggleAll(v ?? false),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          activeColor: CZ.green,
        ),
        const SizedBox(width: 6),
        const Text('Select All', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CZ.dark)),
        const Spacer(),
        GestureDetector(
          onTap: onDeleteSelected,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(border: Border.all(color: CZ.red.withOpacity(0.4)), borderRadius: BorderRadius.circular(6)),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.delete_outline, color: CZ.red, size: 15),
              SizedBox(width: 4),
              Text('Delete Selected', style: TextStyle(color: CZ.red, fontSize: 12, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
    );
  }
}

// ============================================================
// STORE SECTION
// ============================================================
class _StoreSectionWidget extends StatelessWidget {
  final String categoryName;
  final String categoryIcon;
  final List<CartItem> items;
  final Function(CartItem, int) onQty;
  final Function(CartItem) onRemove;
  final Function(CartItem) onSave;
  final Function(CartItem) onMenuTap;
  final VoidCallback onCategoryTap;

  const _StoreSectionWidget({
    required this.categoryName,
    required this.categoryIcon,
    required this.items,
    required this.onQty,
    required this.onRemove,
    required this.onSave,
    required this.onMenuTap,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CZ.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Material(
          color: CZ.white,
          child: InkWell(
            onTap: onCategoryTap,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Row(children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(color: CZ.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: Center(child: Text(categoryIcon, style: const TextStyle(fontSize: 16))),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(categoryName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CZ.dark), overflow: TextOverflow.ellipsis)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(border: Border.all(color: CZ.green.withOpacity(0.5)), borderRadius: BorderRadius.circular(3)),
                  child: const Text('CARTZA STORE', style: TextStyle(color: CZ.green, fontSize: 8, fontWeight: FontWeight.w800, letterSpacing: 0.5)),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.chevron_right, color: CZ.grey, size: 18),
              ]),
            ),
          ),
        ),
        ...items.map((item) => _ItemCard(item: item, onQty: onQty, onRemove: onRemove, onSave: onSave, onMenuTap: onMenuTap)),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
          child: Material(
            color: CZ.green.withOpacity(0.05),
            borderRadius: BorderRadius.circular(6),
            child: InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: CZ.green.withOpacity(0.2))),
                child: Row(children: [
                  const Icon(Icons.local_offer_outlined, color: CZ.green, size: 14),
                  const SizedBox(width: 6),
                  Expanded(child: Text('$categoryName Voucher: Up to Rs.100 OFF',
                      style: const TextStyle(fontSize: 11, color: CZ.green, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)),
                  const Text('Claim >', style: TextStyle(fontSize: 11, color: CZ.green)),
                ]),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

// ============================================================
// ITEM CARD
// ============================================================
class _ItemCard extends StatelessWidget {
  final CartItem item;
  final Function(CartItem, int) onQty;
  final Function(CartItem) onRemove;
  final Function(CartItem) onSave;
  final Function(CartItem) onMenuTap;

  const _ItemCard({
    required this.item,
    required this.onQty,
    required this.onRemove,
    required this.onSave,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: CZ.red,
        padding: const EdgeInsets.only(right: 22),
        child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.delete, color: Colors.white, size: 26),
          SizedBox(height: 4),
          Text('Remove', style: TextStyle(color: Colors.white, fontSize: 11)),
        ]),
      ),
      onDismissed: (_) => onRemove(item),
      child: Container(
        decoration: const BoxDecoration(color: CZ.white, border: Border(top: BorderSide(color: Color(0xFFF0F0F0), width: 0.8))),
        padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: 28,
              height: 28,
              child: Checkbox(
                value: item.selected,
                onChanged: (v) {
                  item.selected = v ?? false;
                  (context as Element).markNeedsBuild();
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: CZ.green,
              ),
            ),
          ),
          Stack(clipBehavior: Clip.none, children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFFEEEEEE))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: item.imageAsset.isNotEmpty
                    ? Image.asset(item.imageAsset, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Center(child: Text(item.categoryIcon, style: const TextStyle(fontSize: 32))))
                    : Center(child: Text(item.categoryIcon, style: const TextStyle(fontSize: 32))),
              ),
            ),
            if (item.discount > 0)
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: const BoxDecoration(color: CZ.red, borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomRight: Radius.circular(8))),
                  child: Text('-${item.discount}%', style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.w800)),
                ),
              ),
            if (item.tags.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: item.tags.contains('Popular') ? CZ.green : item.tags.contains('New') ? CZ.teal : CZ.accent,
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  ),
                  child: Text(item.tags.first, style: const TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w800)),
                ),
              ),
          ]),
          const SizedBox(width: 8),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: Text(item.productName, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: CZ.dark, height: 1.3, fontWeight: FontWeight.w500))),
                GestureDetector(onTap: () => onMenuTap(item), child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.more_vert, color: CZ.grey, size: 18))),
              ]),
              const SizedBox(height: 3),
              _StarRow(rating: item.rating, sold: item.sold, size: 10),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(color: CZ.light, borderRadius: BorderRadius.circular(3)),
                child: Text(item.variant, style: const TextStyle(fontSize: 9, color: CZ.grey), maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              const SizedBox(height: 5),
              Wrap(crossAxisAlignment: WrapCrossAlignment.center, spacing: 4, runSpacing: 2, children: [
                Text('Rs.${(item.price * item.qty).toStringAsFixed(0)}', style: const TextStyle(color: CZ.green, fontSize: 14, fontWeight: FontWeight.w800)),
                Text('Rs.${(item.originalPrice * item.qty).toStringAsFixed(0)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: CZ.grey, fontSize: 10)),
              ]),
              const SizedBox(height: 7),
              Row(children: [
                Container(
                  decoration: BoxDecoration(border: Border.all(color: const Color(0xFFDDDDDD)), borderRadius: BorderRadius.circular(5)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    _QtyBtn(icon: Icons.remove, onTap: () => onQty(item, -1)),
                    Container(width: 28, height: 26, alignment: Alignment.center, decoration: const BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: Color(0xFFDDDDDD)))), child: Text('${item.qty}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: CZ.dark))),
                    _QtyBtn(icon: Icons.add, onTap: () => onQty(item, 1)),
                  ]),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => onSave(item),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(item.saved ? Icons.favorite : Icons.favorite_border, color: item.saved ? CZ.red : CZ.grey, size: 14),
                    const SizedBox(width: 2),
                    Text(item.saved ? 'Saved' : 'Save', style: TextStyle(fontSize: 10, color: item.saved ? CZ.red : CZ.grey)),
                  ]),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => onRemove(item),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.delete_outline, color: CZ.grey, size: 14), SizedBox(width: 2), Text('Remove', style: TextStyle(fontSize: 10, color: CZ.grey))]),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

// ============================================================
// STAR ROW
// ============================================================
class _StarRow extends StatelessWidget {
  final double rating;
  final int sold;
  final double size;

  const _StarRow({required this.rating, required this.sold, this.size = 12});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 1,
      runSpacing: 0,
      children: [
        ...List.generate(5, (i) {
          final filled = i < rating.floor();
          final half = !filled && i < rating;
          return Icon(filled ? Icons.star : half ? Icons.star_half : Icons.star_border, size: size, color: CZ.star);
        }),
        const SizedBox(width: 3),
        Text('$rating', style: TextStyle(fontSize: size - 1, color: CZ.grey, fontWeight: FontWeight.w600), overflow: TextOverflow.ellipsis),
        Text(' (${sold}sold)', style: TextStyle(fontSize: size - 1, color: CZ.grey), overflow: TextOverflow.ellipsis),
      ],
    );
  }
}

// ============================================================
// QTY BUTTON
// ============================================================
class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(width: 26, height: 26, color: const Color(0xFFF5F5F5), child: Icon(icon, size: 13, color: CZ.dark)),
    );
  }
}

// ============================================================
// THREE-DOT MENU SHEET
// ============================================================
class _ItemMenuSheet extends StatelessWidget {
  final CartItem item;
  final VoidCallback onSave, onRemove, onViewRelated, onShareItem, onMoveToWishlist;

  const _ItemMenuSheet({
    required this.item,
    required this.onSave,
    required this.onRemove,
    required this.onViewRelated,
    required this.onShareItem,
    required this.onMoveToWishlist,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: 14), decoration: BoxDecoration(color: CZ.light, borderRadius: BorderRadius.circular(2))),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8), border: Border.all(color: CZ.light)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: item.imageAsset.isNotEmpty
                      ? Image.asset(item.imageAsset, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Center(child: Text(item.categoryIcon, style: const TextStyle(fontSize: 22))))
                      : Center(child: Text(item.categoryIcon, style: const TextStyle(fontSize: 22))),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text(item.productName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('Rs.${item.price.toStringAsFixed(0)} × ${item.qty}', style: const TextStyle(color: CZ.green, fontSize: 13, fontWeight: FontWeight.w600)),
                  _StarRow(rating: item.rating, sold: item.sold, size: 11),
                ]),
              ),
            ]),
          ),
          const Divider(height: 1),
          _menuTile(Icons.favorite_border, item.saved ? 'Remove from Saved' : 'Save for Later', CZ.dark, onSave),
          _menuTile(Icons.bookmark_border, 'Move to Wishlist', CZ.dark, onMoveToWishlist),
          _menuTile(Icons.grid_view_rounded, 'View Related Products', CZ.teal, onViewRelated),
          _menuTile(Icons.share_outlined, 'Share This Product', CZ.dark, onShareItem),
          _menuTile(Icons.delete_outline, 'Remove from Cart', CZ.red, onRemove),
          const SizedBox(height: 6),
        ]),
      ),
    );
  }

  Widget _menuTile(IconData icon, String label, Color color, VoidCallback onTap) {
    return ListTile(
      leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 18)),
      title: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color == CZ.red ? CZ.red : CZ.dark)),
      onTap: onTap,
      dense: true,
    );
  }
}

// ============================================================
// RELATED PRODUCTS SHEET
// ============================================================
class _RelatedProductsSheet extends StatelessWidget {
  final CartItem item;
  final Function(Map<String, dynamic>) onAddToCart;
  final Function(Map<String, dynamic>) onProductTap;

  const _RelatedProductsSheet({
    required this.item,
    required this.onAddToCart,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final relProds = item.related.map((name) {
      final sub = _findSubcategory(name);
      final cat = _findCategoryForProduct(name);
      if (sub == null || cat == null) return null;
      return {
        'name': name,
        'image': sub['image'] as String? ?? '',
        'price': (sub['price'] as num).toDouble(),
        'rating': (sub['rating'] as num?)?.toDouble() ?? 4.5,
        'sold': (sub['sold'] as num?)?.toInt() ?? 0,
        'catName': cat['name'] as String,
        'catIcon': cat['icon'] as String? ?? '📦',
        'catImage': cat['image'] as String? ?? '',
        'desc': sub['description'] as String? ?? '',
        'related': List<String>.from(sub['related'] as List? ?? []),
        'tags': List<String>.from(sub['tags'] as List? ?? []),
      };
    }).whereType<Map<String, dynamic>>().toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (_, ctrl) => Column(children: [
        Container(width: 40, height: 4, margin: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: CZ.light, borderRadius: BorderRadius.circular(2))),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Row(children: [
            const Icon(Icons.grid_view_rounded, color: CZ.green, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text('Related to ${item.productName}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: CZ.dark), maxLines: 1, overflow: TextOverflow.ellipsis)),
          ]),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            controller: ctrl,
            itemCount: relProds.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 16),
            itemBuilder: (_, i) {
              final prod = relProds[i];
              return ListTile(
                onTap: () => onProductTap(prod),
                leading: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8), border: Border.all(color: CZ.light)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: (prod['image'] as String).isNotEmpty
                        ? Image.asset(prod['image'] as String, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Center(child: Text(prod['catIcon'] as String, style: const TextStyle(fontSize: 22))))
                        : Center(child: Text(prod['catIcon'] as String, style: const TextStyle(fontSize: 22))),
                  ),
                ),
                title: Text(prod['name'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CZ.dark)),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text(prod['catName'] as String, style: const TextStyle(fontSize: 11, color: CZ.grey)),
                  _StarRow(rating: prod['rating'] as double, sold: prod['sold'] as int, size: 11),
                ]),
                trailing: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                  Text('Rs.${(prod['price'] as double).toStringAsFixed(0)}', style: const TextStyle(color: CZ.green, fontWeight: FontWeight.w800, fontSize: 14)),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => onAddToCart(prod),
                    child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: CZ.green, borderRadius: BorderRadius.circular(5)), child: const Text('+ Add', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700))),
                  ),
                ]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

// ============================================================
// CATEGORY STORE SHEET
// ============================================================
class _CategoryStoreSheet extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final String? initialCatName;
  final Function(Map<String, dynamic>, Map<String, dynamic>) onProductSelected;

  const _CategoryStoreSheet({
    required this.categories,
    this.initialCatName,
    required this.onProductSelected,
  });

  @override
  State<_CategoryStoreSheet> createState() => _CategoryStoreSheetState();
}

class _CategoryStoreSheetState extends State<_CategoryStoreSheet> {
  late int _selCatIdx;
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selCatIdx = 0;
    if (widget.initialCatName != null) {
      final idx = widget.categories.indexWhere((c) => (c['name'] as String) == widget.initialCatName);
      if (idx >= 0) _selCatIdx = idx;
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cat = widget.categories[_selCatIdx];
    final subs = (cat['subcategories'] as List).cast<Map<String, dynamic>>();
    final filtered = _query.isEmpty ? subs : subs.where((s) => (s['name'] as String).toLowerCase().contains(_query.toLowerCase())).toList();

    return DraggableScrollableSheet(
      initialChildSize: 0.92,
      maxChildSize: 0.97,
      minChildSize: 0.5,
      expand: false,
      builder: (_, ctrl) => Column(children: [
        Container(width: 40, height: 4, margin: const EdgeInsets.symmetric(vertical: 12), decoration: BoxDecoration(color: CZ.light, borderRadius: BorderRadius.circular(2))),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Row(children: [
            const Icon(Icons.storefront_outlined, color: CZ.green, size: 20),
            const SizedBox(width: 8),
            const Expanded(child: Text('Browse & Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CZ.dark))),
            GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.close, color: CZ.grey, size: 20)),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Container(
            height: 38,
            decoration: BoxDecoration(color: CZ.bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: CZ.light)),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                hintText: 'Search products…',
                hintStyle: TextStyle(color: CZ.grey, fontSize: 13),
                prefixIcon: Icon(Icons.search, color: CZ.grey, size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 9),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: widget.categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 6),
            itemBuilder: (_, i) {
              final c = widget.categories[i];
              final sel = i == _selCatIdx;
              return GestureDetector(
                onTap: () => setState(() { _selCatIdx = i; _query = ''; _searchCtrl.clear(); }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: sel ? CZ.green : CZ.light, borderRadius: BorderRadius.circular(20)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Text(c['icon'] as String? ?? '📦', style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 5),
                    Text(c['name'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: sel ? Colors.white : CZ.dark)),
                  ]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        const Divider(height: 1),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('No products found', style: TextStyle(color: CZ.grey)))
              : GridView.builder(
            controller: ctrl,
            padding: const EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.sizeOf(context).width > 500 ? 3 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.68,
            ),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final sub = filtered[i];
              final tags = List<String>.from(sub['tags'] as List? ?? []);
              return GestureDetector(
                onTap: () => widget.onProductSelected(sub, cat),
                child: Container(
                  decoration: BoxDecoration(color: CZ.white, borderRadius: BorderRadius.circular(10), boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 6, offset: Offset(0, 2))]),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: (sub['image'] as String? ?? '').isNotEmpty
                              ? Image.asset(sub['image'] as String, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF5F5F5), child: Center(child: Text(cat['icon'] as String? ?? '📦', style: const TextStyle(fontSize: 36)))))
                              : Container(color: const Color(0xFFF5F5F5), child: Center(child: Text(cat['icon'] as String? ?? '📦', style: const TextStyle(fontSize: 36)))),
                        ),
                      ),
                      if (tags.isNotEmpty)
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(color: tags.contains('Popular') ? CZ.green : tags.contains('New') ? CZ.teal : CZ.accent, borderRadius: BorderRadius.circular(4)),
                            child: Text(tags.first, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w800)),
                          ),
                        ),
                    ]),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, mainAxisSize: MainAxisSize.max, children: [
                          Text(sub['name'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CZ.dark), maxLines: 2, overflow: TextOverflow.ellipsis),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                            _StarRow(rating: (sub['rating'] as num?)?.toDouble() ?? 4.5, sold: (sub['sold'] as num?)?.toInt() ?? 0, size: 10),
                            const SizedBox(height: 4),
                            Row(children: [
                              Expanded(child: Text('Rs.${sub['price']}', style: const TextStyle(color: CZ.green, fontWeight: FontWeight.w800, fontSize: 13), overflow: TextOverflow.ellipsis)),
                              GestureDetector(
                                onTap: () => widget.onProductSelected(sub, cat),
                                child: Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: CZ.green, borderRadius: BorderRadius.circular(5)), child: const Text('+ Add', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700))),
                              ),
                            ]),
                          ]),
                        ]),
                      ),
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

// ============================================================
// RELATED PRODUCTS (bottom section)
// ============================================================
class _RelatedBottomSection extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function(Map<String, dynamic>) onAdd;
  final VoidCallback onSeeAll;
  final Function(Map<String, dynamic>) onProductTap;

  const _RelatedBottomSection({
    required this.products,
    required this.onAdd,
    required this.onSeeAll,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final show = products.take(10).toList();
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CZ.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
          child: Row(children: [
            const Icon(Icons.recommend_outlined, color: CZ.green, size: 18),
            const SizedBox(width: 6),
            const Expanded(child: Text('You Might Also Like', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: CZ.dark))),
            GestureDetector(
              onTap: onSeeAll,
              child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(border: Border.all(color: CZ.green.withOpacity(0.4)), borderRadius: BorderRadius.circular(14)), child: const Text('See All', style: TextStyle(color: CZ.green, fontSize: 12, fontWeight: FontWeight.w600))),
            ),
          ]),
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
            itemCount: show.length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final prod = show[i];
              return GestureDetector(
                onTap: () => onProductTap(prod),
                child: Container(
                  width: 130,
                  decoration: BoxDecoration(color: CZ.bg, borderRadius: BorderRadius.circular(10), border: Border.all(color: CZ.light)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                        child: SizedBox(
                          width: 130,
                          height: 110,
                          child: (prod['image'] as String).isNotEmpty
                              ? Image.asset(prod['image'] as String, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF5F5F5), child: Center(child: Text(prod['catIcon'] as String, style: const TextStyle(fontSize: 36)))))
                              : Container(color: const Color(0xFFF5F5F5), child: Center(child: Text(prod['catIcon'] as String, style: const TextStyle(fontSize: 36)))),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        right: 6,
                        child: GestureDetector(
                          onTap: () => onAdd(prod),
                          child: Container(width: 28, height: 28, decoration: const BoxDecoration(color: CZ.green, shape: BoxShape.circle), child: const Icon(Icons.add, color: Colors.white, size: 16)),
                        ),
                      ),
                    ]),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(prod['name'] as String, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: CZ.dark), maxLines: 2, overflow: TextOverflow.ellipsis),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                            _StarRow(rating: prod['rating'] as double, sold: prod['sold'] as int, size: 9),
                            const SizedBox(height: 2),
                            Text('Rs.${(prod['price'] as double).toStringAsFixed(0)}', style: const TextStyle(color: CZ.green, fontWeight: FontWeight.w800, fontSize: 13)),
                          ]),
                        ]),
                      ),
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

// ============================================================
// DELIVERY BANNER
// ============================================================
class _DeliveryBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CZ.white,
      child: Material(
        color: CZ.white,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Container(width: 38, height: 38, decoration: BoxDecoration(color: CZ.green.withOpacity(0.12), borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.local_shipping_outlined, color: CZ.green, size: 20)),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                  Text('Free Delivery on this order! 🎉', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CZ.green)),
                  SizedBox(height: 2),
                  Text('Estimated: Tomorrow · Express available', style: TextStyle(fontSize: 11, color: CZ.grey)),
                ]),
              ),
              const Text('Change >', style: TextStyle(fontSize: 12, color: CZ.green, fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// VOUCHER SECTION
// ============================================================
class _VoucherSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CZ.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        _vRow(Icons.confirmation_num_outlined, CZ.green, 'Platform Voucher', 'Rs.200 OFF Applied', CZ.green, true),
        const Divider(height: 1, indent: 14, endIndent: 14),
        _vRow(Icons.storefront_outlined, CZ.accent, 'Seller Vouchers', 'Select', CZ.grey, false),
        const Divider(height: 1, indent: 14, endIndent: 14),
        _vRow(Icons.credit_card_outlined, CZ.teal, 'EasyPaisa / JazzCash', 'Extra 5% OFF', CZ.teal, true),
        const Divider(height: 1, indent: 14, endIndent: 14),
        _vRow(Icons.stars_outlined, CZ.gold, 'Cartza Coins', '240 coins available', CZ.gold, true),
      ]),
    );
  }

  Widget _vRow(IconData icon, Color ic, String label, String value, Color vc, bool hasChip) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(children: [
          Icon(icon, color: ic, size: 18),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 13, color: CZ.dark))),
          if (hasChip)
            Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2), decoration: BoxDecoration(color: vc.withOpacity(0.1), borderRadius: BorderRadius.circular(4)), child: Text(value, style: TextStyle(fontSize: 11, color: vc, fontWeight: FontWeight.w700)))
          else
            Text(value, style: const TextStyle(fontSize: 12, color: CZ.grey)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: CZ.grey, size: 18),
        ]),
      ),
    );
  }
}

// ============================================================
// FLASH BANNER
// ============================================================
class _FlashBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFE63B2E), Color(0xFFFF8C00)])),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        const Icon(Icons.bolt, color: Colors.white, size: 24),
        const SizedBox(width: 6),
        const Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text('Flash Sale Ends In', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
            Text('02 : 45 : 30', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 2)),
          ]),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: const Text('Shop More', style: TextStyle(color: CZ.green, fontSize: 12, fontWeight: FontWeight.w800))),
        ),
      ]),
    );
  }
}

// ============================================================
// SUMMARY SECTION (Mobile)
// ============================================================
class _SummarySection extends StatelessWidget {
  final double subtotal, savings, voucher, grand;
  final int itemCount;

  const _SummarySection({
    required this.subtotal,
    required this.savings,
    required this.voucher,
    required this.grand,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CZ.white,
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        const Text('Order Summary', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: CZ.dark)),
        const SizedBox(height: 14),
        _row('Subtotal ($itemCount items)', 'Rs.${subtotal.toStringAsFixed(0)}', CZ.dark),
        const SizedBox(height: 7),
        _row('You Save', '- Rs.${savings.toStringAsFixed(0)}', CZ.green),
        const SizedBox(height: 7),
        _row('Delivery Fee', 'FREE', CZ.green),
        const SizedBox(height: 7),
        _row('Platform Voucher', '- Rs.${voucher.toStringAsFixed(0)}', CZ.green),
        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(color: Color(0xFFF0F0F0))),
        Row(children: [
          const Text('Grand Total', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: CZ.dark)),
          const Spacer(),
          Flexible(child: Text('Rs.${grand.toStringAsFixed(0)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: CZ.green), overflow: TextOverflow.ellipsis)),
        ]),
        const SizedBox(height: 4),
        const Align(alignment: Alignment.centerRight, child: Text('All taxes included', style: TextStyle(fontSize: 11, color: CZ.grey))),
      ]),
    );
  }

  Widget _row(String l, String v, Color vc) => Row(children: [
    Expanded(child: Text(l, style: const TextStyle(fontSize: 13, color: CZ.grey), overflow: TextOverflow.ellipsis)),
    const SizedBox(width: 8),
    Text(v, style: TextStyle(fontSize: 13, color: vc, fontWeight: FontWeight.w700)),
  ]);
}

// ============================================================
// CATEGORY BROWSE ROW
// ============================================================
class _CategoryBrowseRow extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String) onTap;

  const _CategoryBrowseRow({required this.categories, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      color: CZ.white,
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Row(children: [
          const Icon(Icons.storefront_outlined, color: CZ.green, size: 16),
          const SizedBox(width: 6),
          const Expanded(child: Text('Browse More Categories', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: CZ.dark))),
          GestureDetector(onTap: () => onTap(''), child: const Text('See All >', style: TextStyle(color: CZ.green, fontSize: 12, fontWeight: FontWeight.w600))),
        ]),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          for (final cat in categories)
            GestureDetector(
              onTap: () => onTap(cat['name'] as String),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(color: CZ.bg, borderRadius: BorderRadius.circular(20), border: Border.all(color: CZ.light)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(cat['icon'] as String? ?? '📦', style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 5),
                  Text(cat['name'] as String, style: const TextStyle(fontSize: 12, color: CZ.dark, fontWeight: FontWeight.w500)),
                ]),
              ),
            ),
        ]),
      ]),
    );
  }
}

// ============================================================
// EMPTY CART
// ============================================================
class _EmptyCart extends StatelessWidget {
  final VoidCallback onShop;
  const _EmptyCart({required this.onShop});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('🛒', style: TextStyle(fontSize: 72)),
        const SizedBox(height: 16),
        const Text('Your Cart is Empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: CZ.dark)),
        const SizedBox(height: 8),
        const Text('Add items from our categories!', style: TextStyle(fontSize: 13, color: CZ.grey)),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: onShop,
          icon: const Icon(Icons.storefront_outlined),
          label: const Text('Browse Categories'),
          style: ElevatedButton.styleFrom(
            backgroundColor: CZ.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ]),
    );
  }
}

// ============================================================
// CART FOOTER — Full width with centered content (DESKTOP ONLY)
// ============================================================
class _CartFooter extends StatelessWidget {
  const _CartFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1A1A1A), Color(0xFF0D0D0D)])),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
              Wrap(spacing: 24, runSpacing: 16, children: [
                SizedBox(
                  width: 200,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: CZ.green, borderRadius: BorderRadius.circular(8)), child: const Text('CARTZA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15, letterSpacing: 1.5))),
                    const SizedBox(height: 10),
                    const Text('Your trusted online shopping\ndestination.', style: TextStyle(color: Colors.white60, fontSize: 12, height: 1.6)),
                    const SizedBox(height: 12),
                    Row(mainAxisSize: MainAxisSize.min, children: [
                      _SocialIcon(Icons.facebook, const Color(0xFF1877F2)),
                      _SocialIcon(Icons.chat, const Color(0xFF25D366)),
                      _SocialIcon(Icons.camera_alt, const Color(0xFFE4405F)),
                      _SocialIcon(Icons.play_arrow, const Color(0xFFFF0000)),
                    ]),
                  ]),
                ),
                _FooterCol('Shop', ['New Arrivals', 'Best Sellers', 'Flash Sale', 'Categories']),
                _FooterCol('Support', ['Contact Us', 'Help Center', 'Track Order', 'Returns']),
                _FooterCol('Company', ['About Us', 'Careers', 'Privacy Policy', 'Terms']),
              ]),
              const SizedBox(height: 20),
              Container(height: 0.5, color: CZ.green.withOpacity(0.3)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(children: [
                  const Icon(Icons.copyright, color: Colors.white38, size: 12),
                  const SizedBox(width: 4),
                  const Flexible(child: Text('2025 Cartza. All rights reserved.', style: TextStyle(color: Colors.white60, fontSize: 11), overflow: TextOverflow.ellipsis)),
                  const Spacer(),
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text('We Accept: ', style: TextStyle(color: Colors.white60, fontSize: 11)),
                    ...[Icons.credit_card, Icons.account_balance_wallet, Icons.payment].map((ic) => Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Container(padding: const EdgeInsets.all(5), decoration: BoxDecoration(color: Colors.white.withOpacity(0.07), borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.white24)), child: Icon(ic, color: Colors.white54, size: 13)),
                    )),
                  ]),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class _FooterCol extends StatelessWidget {
  final String title;
  final List<String> links;
  const _FooterCol(this.title, this.links);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12.5)),
        const SizedBox(height: 10),
        ...links.map((l) => Padding(
          padding: const EdgeInsets.only(bottom: 7),
          child: InkWell(
            onTap: () {},
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.arrow_right_rounded, size: 13, color: CZ.green.withOpacity(0.65)),
              const SizedBox(width: 3),
              Flexible(child: Text(l, style: const TextStyle(color: Colors.white60, fontSize: 11.5), overflow: TextOverflow.ellipsis)),
            ]),
          ),
        )),
      ]),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _SocialIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {},
        child: Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(7)), child: Icon(icon, color: Colors.white, size: 14)),
      ),
    );
  }
}
