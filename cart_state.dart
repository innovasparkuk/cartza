import 'models/cart_item.dart';

/// Shared global cart used across the app
List<CartItem> globalCart = [];

/// Add item to cart (if exists, increase quantity)
void addToCart(CartItem newItem) {
  // Check if item already exists in cart
  final index = globalCart.indexWhere((item) => item.name == newItem.name);

  if (index != -1) {
    // If exists → increase quantity
    globalCart[index].quantity += newItem.quantity;
  } else {
    // If not exists → add new item
    globalCart.add(newItem);
  }
}

/// Remove one quantity (or entire item if last one)
void removeFromCart(CartItem item) {
  final index = globalCart.indexWhere((cartItem) => cartItem.name == item.name);

  if (index != -1) {
    if (globalCart[index].quantity > 1) {
      globalCart[index].quantity--;
    } else {
      globalCart.removeAt(index);
    }
  }
}

/// Delete entire item from cart
void deleteFromCart(CartItem item) {
  globalCart.removeWhere((cartItem) => cartItem.name == item.name);
}

/// Clear all items
void clearCart() {
  globalCart.clear();
}

/// Calculate total
double getCartTotal() {
  return globalCart.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
