import 'package:flutter/material.dart';
import 'dart:async';

class DrawerMenu extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  const DrawerMenu({super.key, required this.categories});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 18, end: 28).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // 🔥 Gradient Header with Animated Text
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF6F00), Color(0xFF4CAF50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 90, // Adjust width
                  height: 90, // Adjust height
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // You can add animated text or tagline below if needed

                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Text(
                      'Welcome to Cartza',
                      style: TextStyle(
                        fontSize: _animation.value,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // 🧾 Category List
          Expanded(
            child: ListView.builder(
              padding:  EdgeInsets.symmetric(vertical: 8),
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final category = widget.categories[index];
                return Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('${category['image']}'),
                        backgroundColor: Colors.green,
                      ),
                      title: Text(
                        category['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF212121),
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          '/subcategory',
                          arguments: category,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
