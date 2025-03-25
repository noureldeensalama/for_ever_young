import 'package:flutter/material.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

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
                'FAQs',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : buttonColor, // Use your button color
                ),
              ),
              Divider(),
              _buildFAQItem(
                  "Why choose 4Ever Young STL Medical Spa?",
                  "Certified Experts\nWe are fully certified in all the services we offer, including Botox, dermal fillers, and weight loss treatments. With over 12 years of expertise and a track record of countless satisfied clients, we are committed to delivering exceptional care.",
                context
              ),
              _buildFAQItem(
                  "Best Botox Pricing in All St. Louis",
                  "We offer the best Botox pricing in St. Louis at just \$10.50 per unit, providing high-quality results at an unbeatable price. Achieve your desired look with effective, professional Botox treatments that fit your budget.",context
              ),
              _buildFAQItem(
                  "Free Consultation",
                  "We offer a free 30-minute to 1-hour consultation in our medical spa in St. Louis to discuss your needs, treatment options, pricing, and personalized plans. Our expert team will guide you through every step, ensuring you understand the best options for your unique goals.",context
              ),
              _buildFAQItem(
                  "CareCredit Financing Options",
                  "We proudly accept CareCredit, giving you flexible financing solutions for your treatments. With CareCredit, you can receive the services you want now and spread out payments over time, making it easier and more affordable to prioritize your self-care.",context
              ),
              _buildFAQItem(
                  "Track Your Progress with Our App",
                  "Our easy-to-use app allows you to create an account where you can track your progress, manage appointments, view pricing and billing, and much more. Stay connected with your treatment journey as we follow your results and provide updates to ensure you achieve the best possible outcomes.",context
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer, BuildContext context) {
    final cubit = ForEverYoungCubit.get(context);
    final bool isDarkMode = cubit.isDark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Text(
            answer,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black,
              height: 1.5,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}