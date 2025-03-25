import 'package:flutter/material.dart';
import 'package:for_ever_young/layout/shop_screen/gift_cards_screen/anniversary_giftcard_screen/anniversary_giftcard_screen.dart';
import 'package:for_ever_young/layout/shop_screen/gift_cards_screen/birthday_giftcard_screen/birthday_giftcard_screen.dart';
import 'package:for_ever_young/layout/shop_screen/gift_cards_screen/congrats_giftcard_screen/congrats_giftcard_screen.dart';
import 'package:for_ever_young/layout/shop_screen/gift_cards_screen/thankyou_giftcard_screen/thankyou_giftcard_screen.dart';

class GiftCardScreen extends StatelessWidget {
  const GiftCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gift Cards')),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildGiftCardItem(
            context,
            title: 'Thank You',
            imagePath: 'images/shop_screen_photos/giftcards_photos/thankyou.png',
          ),
          SizedBox(height: 10),
          buildGiftCardItem(
            context,
            title: 'Congratulations',
            imagePath: 'images/shop_screen_photos/giftcards_photos/congrats.png',
          ),
          SizedBox(height: 10),
          buildGiftCardItem(
            context,
            title: 'Birthday',
            imagePath: 'images/shop_screen_photos/giftcards_photos/birthday.png',
          ),
          SizedBox(height: 10),
          buildGiftCardItem(
            context,
            title: 'Anniversary',
            imagePath: 'images/shop_screen_photos/giftcards_photos/anniversary.png',
          ),
        ],
      ),
    );
  }

  Widget buildGiftCardItem(BuildContext context, {required String title, required String imagePath}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
        ),
        SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GiftCardDetailScreen(title)),
          ),
          child: Row(
            children: [
              SizedBox(width: 5),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  height: 140, // Reduced height
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }}

class GiftCardDetailScreen extends StatelessWidget {
  final String title;
  const GiftCardDetailScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (title) {
      case 'Thank You':
        screen = ThankYouGiftcardScreen();
        break;
      case 'Congratulations':
        screen = CongratulationsGiftcardScreen();
        break;
      case 'Birthday':
        screen = birthdayGiftcardScreen();
        break;
      case 'Anniversary':
        screen = anniversaryGiftcardScreen();
        break;
      default:
        screen = DefaultGiftCardScreen(title);
    }

    return screen;
  }
}

class DefaultGiftCardScreen extends StatelessWidget {
  final String title;
  const DefaultGiftCardScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title Gift Card')),
      body: Center(child: Text('Details for $title Gift Card', style: TextStyle(fontSize: 20))),
    );
  }
}
