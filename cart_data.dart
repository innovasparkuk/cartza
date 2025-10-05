import '../models/cart_item.dart';

/// Global shared cart accessible across pages
List<CartItem> globalCart = [];

/// Adds an item to the cart
void addToCart(CartItem item) {
  // If item already exists, increase quantity
  int index = globalCart.indexWhere((element) => element.name == item.name);
  if (index >= 0) {
    globalCart[index].quantity += item.quantity;
  } else {
    globalCart.add(item);
  }
}

/// Removes an item from the cart
void removeFromCart(CartItem item) {
  globalCart.removeWhere((element) => element.name == item.name);
}

/// Clears the cart
void clearCart() {
  globalCart.clear();
}

/// Total items in cart
int cartQuantity() {
  return globalCart.fold<int>(0, (sum, item) => sum + item.quantity);
}

/// Total price of cart
double cartTotal() {
  return globalCart.fold<double>(0, (sum, item) => sum + item.price * item.quantity);
}
