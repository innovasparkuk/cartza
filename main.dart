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
      home: const RoleTabs(),
    );
  }
}

class RoleTabs extends StatelessWidget {
  const RoleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            backgroundColor: const Color(0xFF4CAF50),
            title: const Text("Cartza Login", style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w600,)),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black54,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "User"),
                Tab(text: "Seller"),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            AuthForm(role: "User"),
            AuthForm(role: "Seller"),
          ],
        ),
      ),
    );
  }
}

// Define HomePage and SellerPage classes here to fix the reference errors
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
      body: const Center(child: Text("Welcome User!", style: TextStyle(fontSize: 18))),
    );
  }
}

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
      body: const Center(child: Text("Welcome Seller!", style: TextStyle(fontSize: 18))),
    );
  }
}