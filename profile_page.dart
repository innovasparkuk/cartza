import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedSection = 0;

  // Sample data - replace with your actual data
  final List<Order> _orders = [
    Order('#12345', 'Processing', '\$125.99', '3 items'),
    Order('#12346', 'Delivered', '\$89.50', '2 items'),
    Order('#12347', 'Shipped', '\$210.75', '5 items'),
  ];

  final List<WishlistItem> _wishlistItems = [
    WishlistItem('Wireless Headphones', '\$79.99', 'assets/images/headphones.jpeg'),
    WishlistItem('Smart Watch', '\$199.99', 'assets/images/watch.jpeg'),
    WishlistItem('University Bag', '\$89.99', 'assets/images/bag.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit profile action
            },
          ),
        ],
      ),
      body: Column( // Changed from SingleChildScrollView to Column
        children: [
          _buildUserInfo(),
          _buildSectionTabs(),
          Expanded( // Add Expanded here instead of in _buildSelectedSection
            child: _buildSelectedSection(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo() {
    return ResponsiveWrapper(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage("assets/images/avatar.jpeg"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Haya Rajpoot',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF212121),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'haya.rajpoot@gmail.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      const Text(
                        'Islamabad, PAK',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
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
    );
  }

  Widget _buildSectionTabs() {
    return ResponsiveWrapper(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildTabItem('Orders', 0, Icons.shopping_bag),
            _buildTabItem('Wishlist', 1, Icons.favorite),
            _buildTabItem('Settings', 2, Icons.settings),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSection = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: _selectedSection == index ? const Color(0xFF4CAF50).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: _selectedSection == index
                ? Border.all(color: const Color(0xFF4CAF50), width: 1)
                : null,
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: _selectedSection == index ? const Color(0xFF4CAF50) : Colors.grey,
                size: 24,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: TextStyle(
                  color: _selectedSection == index ? const Color(0xFF4CAF50) : Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedSection() {
    switch (_selectedSection) {
      case 0:
        return _buildOrdersSection();
      case 1:
        return _buildWishlistSection();
      case 2:
        return _buildSettingsSection();
      default:
        return _buildOrdersSection();
    }
  }

  Widget _buildOrdersSection() {
    return ResponsiveWrapper(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 16),
            Expanded( // Add Expanded here
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _orders.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildOrderCard(_orders[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order ${order.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: _getStatusColor(order.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.items,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              Text(
                order.price,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212121),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200), // ✅ sets a max width
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("View Details"),
                  ),
                ),
              )

        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.grey;
      case 'Delivered':
        return const Color(0xFF4CAF50);
      default:
        return Colors.grey;
    }
  }

  Widget _buildWishlistSection() {
    return ResponsiveWrapper(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Wishlist',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 16),
            Expanded( // This Expanded is crucial
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                    mainAxisExtent: 250,
                ),
                itemCount: _wishlistItems.length,
                itemBuilder: (context, index) {
                  return _buildWishlistItem(_wishlistItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWishlistItem(WishlistItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              color: Colors.grey[100],
            ),

            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),

              child: Image.asset(
                item.image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 60, color: Colors.grey);
                },
              ),
            ),

          ),


          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212121),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.price,
                  style: const TextStyle(
                    color: Color(0xFFFF6F00),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Add to Cart button (fixed max width)
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 140),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Delete icon (stays tight)
                    IconButton(
                      onPressed: () {
                        // Remove from wishlist
                      },
                      icon: const Icon(Icons.delete_outline, size: 20),
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        padding: const EdgeInsets.all(6),
                      ),
                    ),
                  ],
                )


              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return ResponsiveWrapper(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: ListView( // Use ListView instead of Column
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            _buildSettingsItem(
              Icons.notifications,
              'Notifications',
              'Manage your notifications',
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.payment,
              'Payment Methods',
              'Add or edit payment methods',
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.location_on,
              'Shipping Address',
              'Update your delivery address',
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.security,
              'Privacy & Security',
              'Manage your account security',
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.help,
              'Help & Support',
              'Get help with your account',
              onTap: () {},
            ),
            _buildSettingsItem(
              Icons.logout,
              'Logout',
              'Sign out of your account',
              isLogout: true,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, String subtitle,
      {bool isLogout = false, VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : const Color(0xFF4CAF50).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.orange : const Color(0xFF4CAF50),
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isLogout ? Colors.orange : const Color(0xFF212121),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
}
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;
        double horizontalPadding;
        double maxWidth;

        if (screenWidth < 600) {
          // Mobile
          horizontalPadding = 0.5;
          maxWidth = screenWidth;
        } else if (screenWidth < 1024) {
          // Tablet
          horizontalPadding = 38;
          maxWidth = 800;
        } else {
          // Laptop/Desktop
          horizontalPadding = 70;
          maxWidth = 1200;
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: child,
            ),
          ),
        );
      },
    );
  }
}


// Data model classes
class Order {
  final String id;
  final String status;
  final String price;
  final String items;

  Order(this.id, this.status, this.price, this.items);
}

class WishlistItem {
  final String name;
  final String price;
  final String image;

  WishlistItem(this.name, this.price, this.image);
}