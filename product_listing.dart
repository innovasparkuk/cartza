import 'package:flutter/material.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  State<ProductListingPage> createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  bool isGrid = true; // toggle grid/list
  List<Map<String, dynamic>> products = [
    {"name": "Sneakers", "price": 49.99, "image": "assets/images/shoes.png"},
    {"name": "Backpack", "price": 29.99, "image": "assets/images/phones.jpeg"},
    {"name": "Smart Watch", "price": 99.99, "image": "assets/images/watch.jpeg"},
    {"name": "Headphones", "price": 59.99, "image": "assets/images/bag.jpeg"},
    {"name": "Sneakers", "price": 49.99, "image": "assets/images/shoes.png"},
    {"name": "Backpack", "price": 29.99, "image": "assets/images/phones.jpeg"},
    {"name": "Smart Watch", "price": 99.99, "image": "assets/images/watch.jpeg"},
    {"name": "Headphones", "price": 59.99, "image": "assets/images/bag.jpeg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(25),
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search products...",
              border: InputBorder.none,
              icon: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black87),
            onPressed: () => _openFilterSheet(context),
          ),
          IconButton(
            icon: Icon(isGrid ? Icons.view_list : Icons.grid_view, color: Colors.black87),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isGrid ? _buildGridView() : _buildListView(),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]);
      },
    );
  }

  Widget _buildListView() {
    return ListView.separated(
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return _buildProductCard(products[index], isList: true);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, {bool isList = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isList
          ? Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(product["image"], width: 100, height: 100, fit: BoxFit.cover),
          ),
          Expanded(
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 8.0,right: 0.0),
              title: Text(product["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text("\$${product["price"]}",
                  style: const TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold)),
              trailing: IconButton(
                icon: const Icon(Icons.add_shopping_cart, color: Color(0xFFFF6F00)),
                onPressed: () {},
              ),
            ),
          )
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(product["image"], height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text("\$${product["price"]}",
                    style: const TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Filters", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: FilterChip(
                      label: const Center(child: Text("Men")), // 👈 Center the text
                      onSelected: (val) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilterChip(
                      label: const Center(child: Text("Women")),
                      onSelected: (val) {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilterChip(
                      label: const Center(child: Text("Electronics")),
                      onSelected: (val) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Apply Filters",style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        );
      },
    );
  }
}
