import 'package:flutter/material.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/cream_bleaching_screen/cream_bleaching_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/facial_packages_screen/facial_packages_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/platelet_rich_plasma_screen/platelet_rich_plasma_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/vi_peel_screen/vi_peel_screen.dart';
import 'package:for_ever_young/layout/services_screen/services_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/Microneedling_screen/microneedling_screen.dart';
import 'mesotherapy_screen/mesotherapy_screen.dart';


class FacialScreen extends StatelessWidget {
  const FacialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo_banner.png', height: 60),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Facial',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
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
                      title: 'Facial Packages',
                      imagePath: 'images/services_screen_photos/skin_rejuvenation.jpg',
                      width: screenWidth,
                      destinationScreen: FacialPackagesScreen(),
                    ),
                    ServiceCard(
                      title: 'Platelet Rich Plasma',
                      imagePath: 'images/services_screen_photos/plasma.png',
                      width: screenWidth,
                      destinationScreen: PlateletRichPlasmaScreen(),
                    ),
                    ServiceCard(
                      title: 'VI Peel',
                      imagePath: 'images/services_screen_photos/vi.png',
                      width: screenWidth,
                      destinationScreen: ViPeelScreen(),
                    ),
                    ServiceCard(
                      title: 'Microneedling',
                      imagePath: 'images/services_screen_photos/microneedling.png',
                      width: screenWidth,
                      destinationScreen: MicroneedlingScreen(),
                    ),
                    ServiceCard(
                      title: 'Mesotherapy',
                      imagePath: 'images/services_screen_photos/mesotherapy.png',
                      width: screenWidth,
                      destinationScreen: MesotherapyScreen(),
                    ),
                    ServiceCard(
                      title: 'Cream Bleaching',
                      imagePath: 'images/services_screen_photos/cream.png',
                      width: screenWidth,
                      destinationScreen: CreamBleachingScreen(),
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
