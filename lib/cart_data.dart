import '../models/cart_item.dart';

List<CartItem> globalCart = [];

void addToCart(CartItem item) {
  final existing = globalCart.indexWhere((e) => e.name == item.name);
  if (existing != -1) {
    globalCart[existing].quantity += item.quantity;
  } else {
    globalCart.add(item);
  }
}

void removeFromCart(String name) {
  globalCart.removeWhere((item) => item.name == name);
}

int getCartCount() => globalCart.fold(0, (sum, item) => sum + item.quantity);