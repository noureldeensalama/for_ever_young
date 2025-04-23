import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/cubit/states.dart';
import 'package:for_ever_young/layout/services_screen/services_details_screen/book_services_screen/book_services_screen.dart';
import 'package:for_ever_young/layout/settings_screen/AccountWebView/AccountWebView.dart';
import 'package:for_ever_young/layout/settings_screen/aboutUs_screen/aboutUs_screen.dart';
import 'package:for_ever_young/layout/settings_screen/contactUs_screen/contactUs_screen.dart';
import 'package:for_ever_young/layout/settings_screen/faq_screen/faq_screen.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/components.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'location_page/location_page.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForEverYoungCubit, ForEverYoungStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // My Account Section
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AccountLoginScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person_outline, size: 28, color: secondaryColor), // Use secondaryColor
                              SizedBox(width: 10), // Add spacing between icon and text
                              Text(
                                'My Account',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.navigate_next, color: secondaryColor), // Use secondaryColor
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  Align(
                    alignment: Alignment.centerLeft, // Aligns text to the left
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 5), // Adds left spacing
                      child: Text(
                        'App Settings',
                        style: TextStyle(
                          fontSize: 16, // Smaller text
                          color: Colors.grey, // Optional: make it subtle
                          fontWeight: FontWeight.w400, // Light font weight
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 3),
                  buildCard(Icons.calendar_month_outlined, "Book Appointment", () {
                    navigateTo(context, BookingPage());
                  }, isDarkMode),
                  buildDropdownCard(
                    icon: Icons.wb_sunny_outlined, // Sun Icon
                    title: "App Mode",
                    selectedValue: isDarkMode ? "Dark Mode" : "Light Mode",
                    items: ["Light Mode", "Dark Mode"],
                    onChanged: (value) {
                      cubit.changeAppMode();
                    },
                    isDarkMode: isDarkMode,
                  ),

                  SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft, // Aligns text to the left
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 5), // Adds left spacing
                      child: Text(
                        'Help & FAQ',
                        style: TextStyle(
                          fontSize: 16, // Smaller text
                          color: Colors.grey, // Optional: make it subtle
                          fontWeight: FontWeight.w400, // Light font weight
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  buildCard(Icons.location_on, "Location", () {
                    navigateTo(context, LocationRedirectScreen());
                  }, isDarkMode),
                  SizedBox(height: 3),
                  buildCard(Icons.question_mark_outlined, "FAQ", () {
                    navigateTo(context, FAQScreen());
                  }, isDarkMode),
                  SizedBox(height: 12),
                  buildCard(Icons.info_outline, "About Us", () {
                    navigateTo(context, AboutUsScreen());
                  }, isDarkMode),
                  SizedBox(height: 12),
                  buildCard(Icons.mail_outline, "Contact Us", () {
                    navigateTo(context, ContactUsScreen());
                  }, isDarkMode),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerLeft, // Aligns text to the left
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 5), // Adds left spacing
                      child: Text(
                        'Follow Us',
                        style: TextStyle(
                          fontSize: 16, // Smaller text
                          color: Colors.grey, // Optional: make it subtle
                          fontWeight: FontWeight.w400, // Light font weight
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(SimpleIcons.facebook), // Facebook icon
                        onPressed: () {
                          _launchURL('https://www.facebook.com/4EverYoungStl/');
                        },
                      ),
                      IconButton(
                        icon: Icon(SimpleIcons.instagram), // Instagram icon
                        onPressed: () {
                          _launchURL('https://www.instagram.com/4everyoungstl?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==');
                        },
                      ),
                      IconButton(
                        icon: Icon(SimpleIcons.tiktok), // TikTok icon
                        onPressed: () {
                          _launchURL('https://www.tiktok.com/@4everyoungstl');
                        },
                      ),
                      IconButton(
                        icon: Icon(SimpleIcons.youtube), // YouTube icon
                        onPressed: () {
                          _launchURL('https://www.youtube.com/channel/UCGFcZP83mCWqMX-6oxvk4HA');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Standard Card Widget
Widget buildCard(IconData icon, String title, VoidCallback onTap, bool isDarkMode) {
  return Card(
    elevation: 0,
    color: isDarkMode ? Colors.grey[900] : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey.shade400, width: 1.5),
    ),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 30, color: secondaryColor), // Use secondaryColor
            SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.navigate_next, color: secondaryColor), // Use secondaryColor
          ],
        ),
      ),
    ),
  );
}

// Dropdown Card for Dark Mode
Widget buildDropdownCard({
  required IconData icon,
  required String title,
  required String selectedValue,
  required List<String> items,
  required Function(String) onChanged,
  required bool isDarkMode,
}) {
  return Card(
    elevation: 0,
    color: isDarkMode ? Colors.grey[900] : Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.grey.shade400, width: 1.5),
    ),
    child: Container(
      height: 80,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 30, color: secondaryColor), // Use secondaryColor
          SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          DropdownButton<String>(
            value: selectedValue,
            dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
            items: items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            underline: SizedBox(), // Removes default underline
          ),
        ],
      ),
    ),
  );
}