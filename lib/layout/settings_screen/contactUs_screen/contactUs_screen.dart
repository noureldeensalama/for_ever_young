import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  void initState() {
    super.initState();
    _sendEmail();
  }

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: '4everyoungoasis@gmail.com', // Change this to the actual team email
      queryParameters: {
        'subject': 'Support Request',
        'body': 'Hello 4Ever Young Team, I need help with...',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred while redirecting to your email, please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ClipRRect(
          borderRadius: BorderRadius.circular(13), // Adjust for more or less rounding
          child: Image.asset('images/logo_banner.png', height: 50,),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.support_agent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Redirecting to email...", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}