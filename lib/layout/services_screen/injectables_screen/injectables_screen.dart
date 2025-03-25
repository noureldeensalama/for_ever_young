import 'package:flutter/material.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/botox_screen/botox_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/daxxify_screen/daxxify_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/derma_fillers_screen/derma_fillers_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/injectables_packages_screen/injectables_packages_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/threads_lift_screen/threads_lift_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/wrinkle_relaxers_screen/wrinkle_relaxers_screen.dart';
import 'package:for_ever_young/layout/services_screen/services_screen.dart';
import 'kybella_screen/kybella_screen.dart';


class InjectablesScreen extends StatelessWidget {
  const InjectablesScreen({super.key});

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
              'Injectables',
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
                      title: 'Injectables Packages',
                      imagePath: 'images/services_screen_photos/injectables2.png',
                      width: screenWidth,
                      destinationScreen: InjectablesPackagesScreen(),
                    ),
                    ServiceCard(
                      title: 'Botox',
                      imagePath: 'images/services_screen_photos/botox.png',
                      width: screenWidth,
                      destinationScreen: BotoxScreen(),
                    ),
                    ServiceCard(
                      title: 'Daxxify',
                      imagePath: 'images/services_screen_photos/daxxify.png',
                      width: screenWidth,
                      destinationScreen: DaxxifyScreen(),
                    ),
                    ServiceCard(
                      title: 'Keybella',
                      imagePath: 'images/services_screen_photos/keybella.png',
                      width: screenWidth,
                      destinationScreen: KybellaScreen(),
                    ),
                    ServiceCard(
                      title: 'Dermal Fillers',
                      imagePath: 'images/services_screen_photos/skin_rejuvenation.jpg',
                      width: screenWidth,
                      destinationScreen: DermaFillersScreen(),
                    ),
                    ServiceCard(
                      title: 'Threads Lift Screen',
                      imagePath: 'images/services_screen_photos/threads.png',
                      width: screenWidth,
                      destinationScreen: ThreadsLiftScreen(),
                    ),
                    ServiceCard(
                      title: 'Wrinkle Relaxers',
                      imagePath: 'images/services_screen_photos/wrinkle.png',
                      width: screenWidth,
                      destinationScreen: WrinkleRelaxersScreen(),
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
