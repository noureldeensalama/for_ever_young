import 'package:flutter/material.dart';
import 'package:for_ever_young/layout/shop_screen/gift_cards_screen/gift_cards_screen.dart';
import 'package:for_ever_young/layout/shop_screen/memberships_screen/memberships_screen.dart';
import 'package:for_ever_young/layout/shop_screen/packages_screen/packages_screen.dart';
import 'package:for_ever_young/shared/components.dart';

class ShopItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  const ShopItemCard({
    required this.imagePath,
    required this.title,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              // Background Image
              Image.asset(
                imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),

              // Gradient Overlay for better readability
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.6), // Dark at bottom
                      Colors.transparent, // Fades out
                    ],
                  ),
                ),
              ),

              // Text with Padding
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo_banner.png',
          height: 60, // Adjust size as needed
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shop',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Divider(),
              const SizedBox(height: 10),
              ShopItemCard(
                imagePath: 'images/shop_screen_photos/giftcard.jpg', // Update with your image
                title: 'Gift Cards',
                onTap: () {
                  navigateTo(context, GiftCardScreen());
                },
              ),
              ShopItemCard(
                imagePath: 'images/shop_screen_photos/spa-memberships.jpg', // Update with your image
                title: 'Med Spa Memberships',
                onTap: () {
                  navigateTo(context, MembershipsScreen());
                },
              ),
              ShopItemCard(
                imagePath: 'images/shop_screen_photos/packages.jpg', // Update with your image
                title: 'Packages',
                onTap: () {
                  navigateTo(context, PackagesScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

