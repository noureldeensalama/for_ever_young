import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/cubit/states.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/cream_bleaching_screen/cream_bleaching_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/facial_packages_screen/facial_packages_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/facial_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/mesotherapy_screen/mesotherapy_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/platelet_rich_plasma_screen/platelet_rich_plasma_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/vi_peel_screen/vi_peel_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/botox_screen/botox_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/daxxify_screen/daxxify_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/derma_fillers_screen/derma_fillers_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/injectables_packages_screen/injectables_packages_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/injectables_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/kybella_screen/kybella_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/threads_lift_screen/threads_lift_screen.dart';
import 'package:for_ever_young/layout/services_screen/injectables_screen/wrinkle_relaxers_screen/wrinkle_relaxers_screen.dart';
import 'package:for_ever_young/layout/services_screen/services_details_screen/services_details_screen.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/components.dart';
import 'package:for_ever_young/layout/services_screen/biote_hormone_pellet_screen/biote_hormone_pellet.dart';
import 'package:for_ever_young/layout/services_screen/bloodwork_screen/bloodwork_screen.dart';
import 'package:for_ever_young/layout/services_screen/Erectile_Dysfunction_Treatment_screen/Erectile_Dysfunction_Treatment_screen.dart';
import 'package:for_ever_young/layout/services_screen/iv_therapy_screen/iv_therapy_screen.dart';
import 'package:for_ever_young/layout/services_screen/facial_screen/Microneedling_screen/microneedling_screen.dart';
import 'package:for_ever_young/layout/services_screen/weight_loss_screen/weight_loss_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<ForEverYoungCubit, ForEverYoungStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = ForEverYoungCubit.get(context);
        final bool isDarkMode = cubit.isDark;

        return Scaffold(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top Section with Curved Background
                  Stack(
                    children: [
                      Container(
                        height: screenHeight * 0.35,
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.grey[900] : buttonColor, // Use correct colors
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(screenWidth * 0.13),
                            bottomRight: Radius.circular(screenWidth * 0.13),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.07,
                          vertical: screenHeight * 0.06,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                                child: Image.asset(
                                  'images/logo_banner.png',
                                  height: screenHeight * 0.11,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.05),
                            defaultSearchField(
                              controller: searchController,
                              hintText: 'Search Services',
                              onTap: () {
                                navigateTo(context, SearchScreen());
                              },
                              context: context,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Image Banners
                  _serviceCard(
                    screenWidth,
                    screenHeight,
                    "images/home_screen_photos/personalised_experience.jpg",
                    "Tailored Treatments",
                    "Skincare solutions designed just for you.",
                  ),
                  _serviceCard(
                    screenWidth,
                    screenHeight,
                    "images/home_screen_photos/trusted_experts.jpg",
                    "Expert Care",
                    "Your skin deserves the best hands in the industry.",
                  ),
                  _serviceCard(
                    screenWidth,
                    screenHeight,
                    "images/home_screen_photos/next_level_skincare.jpg",
                    "Premium Products",
                    "Science-backed skincare for a radiant glow.",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _serviceCard(double screenWidth, double screenHeight, String imagePath, String title, String subtitle) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.025),
      child: Container(
        height: screenHeight * 0.23, // Adjust height dynamically
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradient Overlay for better readability
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
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
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> services = [
    {"name": "Biote Hormone Pellet", "screen": BioteHormonePellet(), "tabIndex": 4},
    {"name": "Bloodwork", "screen": BloodworkScreen(), "tabIndex": 3},
    {"name": "Botox", "screen": BotoxScreen(), "tabIndex": 0},
    {"name": "Daxxify", "screen": DaxxifyScreen(), "tabIndex": 0},
    {"name": "Derma Fillers", "screen": DermaFillersScreen(), "tabIndex": 0},
    {"name": "Erectile Dysfunction Treatment", "screen": ErectileDysfunctionTreatmentScreen(), "tabIndex": 6},
    {"name": "IV Therapy", "screen": IvTherapyScreen(), "tabIndex": 2},
    {"name": "Keybella", "screen": KybellaScreen(), "tabIndex": 0},
    {"name": "Mesotherapy", "screen": MesotherapyScreen(), "tabIndex": 1},
    {"name": "Microneedling", "screen": MicroneedlingScreen(), "tabIndex": 1},
    {"name": "Platelet Rich Plasma", "screen": PlateletRichPlasmaScreen(), "tabIndex": 0},
    {"name": "Threads Lift", "screen": ThreadsLiftScreen(), "tabIndex": 0},
    {"name": "VI Peel", "screen": ViPeelScreen(), "tabIndex": 1},
    {"name": "Weight Loss", "screen": WeightLossScreen(), "tabIndex": 5},
    {"name": "Wrinkle Relaxers", "screen": WrinkleRelaxersScreen(), "tabIndex": 0},
    {"name": "Cream Bleaching", "screen": CreamBleachingScreen(), "tabIndex": 1},
    {"name": "Facial Packages", "screen": FacialPackagesScreen(), "tabIndex": 1},
    {"name": "Injectables Packages", "screen": InjectablesPackagesScreen(), "tabIndex": 0},
    {"name": "Injectables", "screen": InjectablesScreen(), "tabIndex": 0},
    {"name": "Facial", "screen": FacialScreen(), "tabIndex": 1},

    {"name": "Botox Cosmetic", "screen": BotoxScreen(), "tabIndex": 0},
    {"name": "Dermal Fillers / Lip Fillers", "screen": DermaFillersScreen(), "tabIndex": 0},
    {"name": "Kybella", "screen": KybellaScreen(), "tabIndex": 0},
    {"name": "PDO Threads Lift", "screen": ThreadsLiftScreen(), "tabIndex": 0},
    {"name": "Platelet-Rich Plasma (PRP)", "screen": PlateletRichPlasmaScreen(), "tabIndex": 0},
    {"name": "Wrinkle Relaxers", "screen": WrinkleRelaxersScreen(), "tabIndex": 0},

    {"name": "Dermaplaning", "tabIndex": 1},
    {"name": "Hydra-Facial Platinum", "tabIndex": 1},
    {"name": "Hydra-Facial Signature", "tabIndex": 1},
    {"name": "Hydro Facial Platinum with Chest", "tabIndex": 1},
    {"name": "Hydro Facial Platinum with Neck", "tabIndex": 1},
    {"name": "Hydro Facial Signature with Chest", "tabIndex": 1},
    {"name": "Hydro Facial Signature with Neck", "tabIndex": 1},
    {"name": "Mesotherapy", "screen": MesotherapyScreen(), "tabIndex": 1},
    {"name": "Mesotherapy For Face & Neck", "tabIndex": 1},
    {"name": "Mesotherapy For Face, Neck & Décolleté", "tabIndex": 1},
    {"name": "Microneedling", "screen": MicroneedlingScreen(), "tabIndex": 1},
    {"name": "Microneedling/PRP Treatment", "tabIndex": 1},
    {"name": "Vi Peel", "screen": ViPeelScreen(), "tabIndex": 1},
    {"name": "Vi Peel/Dermaplaning Treatment", "tabIndex": 1},
    {"name": "Vi Peel/Microneedling Treatment", "tabIndex": 1},

    {"name": "CoQ10 Shot", "tabIndex": 2},
    {"name": "Pepcid Injection", "tabIndex": 2},
    {"name": "Amino Blend", "tabIndex": 2},
    {"name": "Vitamin B12 Injection", "tabIndex": 2},
    {"name": "Toradol Injection", "tabIndex": 2},
    {"name": "Biotin + B5 Injection", "tabIndex": 2},
    {"name": "MIC Plus", "tabIndex": 2},
    {"name": "Zofran IV Drip", "tabIndex": 2},
    {"name": "Vitamin D3 Injection", "tabIndex": 2},
    {"name": "Lipo-C Injection", "tabIndex": 2},
  ];
  List<Map<String, dynamic>> filteredServices = [];

  @override
  void initState() {
    super.initState();
    filteredServices = services;
  }

  void filterSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredServices = services;
      } else {
        filteredServices = services
            .where((service) =>
            service["name"].toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cubit = ForEverYoungCubit.get(context);
    final bool isDarkMode = cubit.isDark;
    final Color backgroundColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;
    final Color borderColor = isDarkMode ? Colors.grey : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Image.asset(
          'images/logo_banner.png',
          height: 60,
        ),
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Services',
                  hintStyle: TextStyle(fontSize: 14, color: textColor.withOpacity(0.7)),
                  prefixIcon: Icon(Icons.search, size: 20, color: textColor),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: textColor),
                  ),
                ),
                style: TextStyle(fontSize: 14, color: textColor),
                onChanged: (query) => filterSearch(query),
              ),
            ),
          ),
          Expanded(
            child: filteredServices.isEmpty
                ? Center(
              child: Text(
                "No results found",
                style: TextStyle(color: textColor),
              ),
            )
                : ListView.separated(
              itemCount: filteredServices.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, indent: 15, endIndent: 15, thickness: 0.5, color: borderColor),
              itemBuilder: (context, index) {
                final service = filteredServices[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(
                      service["name"],
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                    onTap: () {
                      if (service["tabIndex"] != null) {
                        // Navigate to ServicesDetailsScreen with the specified tab index
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ServicesDetailsScreen(
                              initialTabIndex: service["tabIndex"],
                            ),
                          ),
                        );
                      } else {
                        // Navigate to the specified screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => service["screen"],
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
