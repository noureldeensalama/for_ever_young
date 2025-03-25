import 'package:flutter/material.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';

class AboutUsScreen extends StatelessWidget {

  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : buttonColor, // Use your button color
                ),
              ),
              Divider(),
              Text(
                "Confidence Starts Here.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black, // Use your button color
                ),
              ),
              SizedBox(height: 10),
              Text(
                "At 4Ever Young STL, the premier medical spa in St. Louis, we blend the art of beauty with the science of wellness to deliver personalized treatments that enhance your natural radiance and inspire lasting confidence. Our expert team offers innovative, cutting-edge aesthetic solutions for both men and women, empowering you to look and feel your best every day.\n\n"
                    "AESTHETIC & WELLNESS SERVICES. Serving the St. Louis and surrounding area since 2016, Alina McCann, NP, MSN, and her highly trained team of aestheticians and wellness professionals are here to help.\n\n"
                    "We specialize in anti-aging and skin rejuvenating treatments customized to meet your individual needs. As a trusted medical spa in St. Louis, our friendly staff is licensed and certified to provide Botox™ and dermal filler services to reveal a more youthful appearance.\n\n"
                    "Discover the beauty within you at our medical skin care facility. At our medical spa in St. Louis, aesthetic medical procedures for facial skin focus the fight on the visible signs of aging. We will guide you throughout the maze of aesthetic, non-surgical treatment options and help you develop a customized treatment plan to help you look your best.\n\n"
                    "4Ever Young STL medical spa prides itself on offering personalized treatment for a variety of your skin’s needs. We ensure our clients are comfortable and all their questions are answered before proceeding with the treatment. We welcome you to indulge in an unforgettable experience here in our medical spa in St. Louis to enhance your looks so you can either slow down the ‘facial aging clock’ or recapture those wonderful looks of not so long ago.\n\n"
                    "Our goal is to provide you with the best wellness skin treatment available on the market. So, book an appointment today and you’ll enjoy a free friendly consultation that will lead you to a new you!",
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : Colors.black,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
