import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const CartzaApp());
}

class CartzaApp extends StatelessWidget {
  const CartzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cartza",
      theme: ThemeData(
        fontFamily: "Roboto",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          primary: const Color(0xFF4CAF50),
          secondary: const Color(0xFFFF6F00),
        ),
      ),

      // 🔹 DIRECT LOGIN PAGE
      home: const ResponsiveLoginPage(role: "User"),
    );
  }
}

////////////////////////////////////////////////////////////
/// USER HOME PAGE
////////////////////////////////////////////////////////////

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "User Home",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "Welcome User!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// SELLER PAGE
////////////////////////////////////////////////////////////

class SellerPage extends StatelessWidget {
  const SellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Seller Dashboard",
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          "Welcome Seller!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
