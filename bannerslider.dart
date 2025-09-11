import 'package:ecommercepro/detailpage.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0;

  final List<String> imageAssets = [
    'assets/Images/mobile sale.jpeg',
    'assets/Images/blackfriday.jpg',
    'assets/Images/womenslae.jpeg'

  ];

  final List<String> bannerTitles = [
    'Sale pic',
    'Black Friday pic',
    'iphone pic',
    'homeapplicance pic',
    'perfume pic'
    'best mobile pic'
  ];

  //void _navigateToDetailPage(BuildContext context, int index) {
  //  Navigator.push(
  //    context,
   //   MaterialPageRoute(
   //     builder: (context) => DetailPage(
    //      imagePath: imageAssets[index],
     //     title: bannerTitles[index],
     //   ),
    //  ),
   // );
//  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
    CarouselSlider.builder(
    itemCount: imageAssets.length,
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        return InkWell(
         // onTap: () => _navigateToDetailPage(context, index),
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imageAssets[index],
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    ),
    const SizedBox(height: 12),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(imageAssets.length, (index) {
    return Container(
    width: 8,
    height: 8,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: _currentIndex == index ? Color(0xFF4CAF50) : Colors.grey,
    ),
    );
    }),
    ),
      ],);
  }
}