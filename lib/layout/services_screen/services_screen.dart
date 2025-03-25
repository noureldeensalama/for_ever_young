import 'package:flutter/material.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/layout/services_screen/services_details_screen/services_details_screen.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;
  final Widget? destinationScreen;
  final int? tabIndex; // Add tabIndex to navigate to specific tab

  const ServiceCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.width,
    this.destinationScreen,
    this.tabIndex, // Optional tabIndex
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (destinationScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationScreen!),
          );
        } else if (tabIndex != null) {
          // Navigate to ServicesDetailsScreen with the specified tab index
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServicesDetailsScreen(initialTabIndex: tabIndex!),
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 4.0,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: width,
                fit: BoxFit.cover,
              ),
              Container(
                width: width,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final cubit = ForEverYoungCubit.get(context);
    final bool isDarkMode = cubit.isDark;

    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(13), // Adjust for more or less rounding
          child: Image.asset('images/logo_banner.png', height: 50,),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.grey[900]
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ServiceCard(
                      title: 'Injectables',
                      imagePath: 'images/services_screen_photos/injectables.jpg',
                      width: screenWidth,
                      tabIndex: 0, // Navigate to Injectables tab
                    ),
                    ServiceCard(
                      title: 'Facial',
                      imagePath: 'images/services_screen_photos/skin_rejuvenation.jpg',
                      width: screenWidth,
                      tabIndex: 1, // Navigate to Facial tab
                    ),
                    ServiceCard(
                      title: 'IV Therapy Packages',
                      imagePath: 'images/services_screen_photos/iv_therapy.jpg',
                      width: screenWidth,
                      tabIndex: 2, // Navigate to IV Therapy / Shots tab
                    ),
                    ServiceCard(
                      title: 'Bloodwork',
                      imagePath: 'images/services_screen_photos/bloodwork.jpg',
                      width: screenWidth,
                      tabIndex: 3, // Navigate to Bloodwork tab
                    ),
                    ServiceCard(
                      title: 'Biote Hormone Pellet',
                      imagePath: 'images/services_screen_photos/biote_hormone.png',
                      width: screenWidth,
                      tabIndex: 4, // Navigate to Biote Hormone Pellet tab
                    ),
                    ServiceCard(
                      title: 'Weight Loss',
                      imagePath: 'images/services_screen_photos/weightloss.jpg',
                      width: screenWidth,
                      tabIndex: 5, // Navigate to Weight Loss tab
                    ),
                    ServiceCard(
                      title: 'Erectile Dysfunction Treatment',
                      imagePath: 'images/services_screen_photos/erectile.png',
                      width: screenWidth,
                      tabIndex: 6, // Navigate to Erectile Dysfunction Treatment tab
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}