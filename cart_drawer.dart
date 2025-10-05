import 'package:cartza/homepage.dart';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartDrawer extends StatelessWidget {
  final List<CartItem> cart;
  final VoidCallback onUpdate;

  const CartDrawer({
    super.key,
    required this.cart,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    double total =
    cart.fold(0, (sum, item) => sum + item.price * item.quantity);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Text(
                '🛒 YOUR CART',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              if (cart.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.orange),
                  onPressed: () {
                    cart.clear();
                    onUpdate();
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),

          // Empty state
          if (cart.isEmpty) ...[
            const Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            // Start Shopping Button
            GestureDetector(
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage()),
                );
              },
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Text(
                  "Start Shopping",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]
          else
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: cart.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = cart[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(item.image),
                      radius: 24,
                    ),
                    title: Text(item.name,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Rs ${item.price.toStringAsFixed(0)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _circleButton(
                          icon: Icons.remove,
                          onTap: () {
                            if (item.quantity > 1) {
                              item.quantity--;
                            } else {
                              cart.removeAt(index);
                            }
                            onUpdate();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Text('${item.quantity}',
                              style: const TextStyle(fontSize: 16)),
                        ),
                        _circleButton(
                          icon: Icons.add,
                          onTap: () {
                            item.quantity++;
                            onUpdate();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            cart.removeAt(index);
                            onUpdate();
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          // Total + Checkout
          if (cart.isNotEmpty) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: Rs ${total.toStringAsFixed(0)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Checkout not implemented yet')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF05811C),
                  ),
                  child: const Text('Checkout',
                      style: TextStyle(fontSize: 17, color: Colors.white)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}
