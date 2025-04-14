import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationRedirectScreen extends StatelessWidget {
  final String mapsUrl = 'https://maps.app.goo.gl/1XHEqH6BicFDkvMu9';

  const LocationRedirectScreen({super.key});

  void _redirectToMaps(BuildContext context) async {
    final uri = Uri.parse(mapsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open Maps.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => _redirectToMaps(context),
          icon: const Icon(Icons.map),
          label: const Text("Open in Maps"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}