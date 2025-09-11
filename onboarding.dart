import 'dart:async';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/pic1.jpg",
      "title": "Welcome to ShopEase",
      "desc": "Discover the best deals and latest trends at your fingertips."
    },
    {
      "image": "assets/images/pic2.jpg",
      "title": "Easy & Secure Payments",
      "desc": "Enjoy fast and secure checkout with multiple payment options."
    },
    {
      "image": "assets/images/pic3.jpg",
      "title": "Fast Delivery",
      "desc": "Get your orders delivered to your doorstep quickly and safely."
    },
    {
      "image": "assets/images/pic4.jpg",
      "title": "Shop Anytime, Anywhere",
      "desc": "Your favorite products are always just a tap away."
    },
  ];

  @override
  void initState() {
    super.initState();

    // Auto page change every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < onboardingData.length - 1) {
        _currentPage++;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // Stop timer when reaching last page
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) => OnboardContent(
              image: onboardingData[index]['image']!,
              title: onboardingData[index]['title']!,
              desc: onboardingData[index]['desc']!,
            ),
          ),

          // Skip button at top-right
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              style: TextButton.styleFrom(
                //minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              onPressed: () {
              },

              child: const Text("Skip", style: TextStyle(fontSize: 16,color: Colors.white)),
            ),
          ),

          // Bottom section
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // Dots indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingData.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: _currentPage == index ? 20 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? Colors.green
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Get Started button (only on last page)
                if (_currentPage == onboardingData.length - 1)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //minimumSize: const Size(double.infinity, 50),
                       backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                    },
                    child: const Text("Get Started",style: TextStyle(color: Colors.white),),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardContent extends StatelessWidget {
  final String image, title, desc;

  const OnboardContent({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20), // round corners
            child: Opacity(
              opacity: 0.9,
              child: Container(
                height: 250,
                width: 300, // make a consistent "card" shape for all
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover, // fills the box and applies rounded corners
                ),
              ),
            ),
          ),



          const SizedBox(height: 15),
          Text(title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
