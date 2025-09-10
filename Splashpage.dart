import 'package:flutter/material.dart';

void main() {
  runApp(const CartzaApp());
}
class CartzaApp extends StatelessWidget {
  const CartzaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartza',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            //color: Color(0xFF72CC77) //300
           color: Color(0xC872CC77) //200
          //color: Color(0x6472CC77) //100
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                'assets/images/logoo.png',
                height: 120,
              ),
              const SizedBox(height: 15),
              // Tagline
              const Text(
                "Shop Smarter, Live Better",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF212121),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
