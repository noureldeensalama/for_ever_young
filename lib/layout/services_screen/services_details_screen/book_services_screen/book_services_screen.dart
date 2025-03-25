import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async'; // Import for Timer

class BookServicesScreen extends StatefulWidget {
  const BookServicesScreen({super.key});

  @override
  _BookServicesScreenState createState() => _BookServicesScreenState();
}

class _BookServicesScreenState extends State<BookServicesScreen> {
  late final WebViewController _controller;
  bool _isLoading = true; // Track loading state
  bool _showWaitText = false; // Control "Please wait..." text visibility
  Timer? _waitTimer; // Timer for "Please wait..." text

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('Loading: $progress%');
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true; // Set loading to true when page starts loading
              _showWaitText = false; // Hide "Please wait..." initially
            });

            // Start a timer for 3 seconds to show "Please wait..."
            _waitTimer?.cancel(); // Cancel any existing timer
            _waitTimer = Timer(const Duration(seconds: 3), () {
              if (_isLoading) {
                setState(() {
                  _showWaitText = true; // Show "Please wait..." after 3 seconds
                });
              }
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false; // Set loading to false when page finishes
              _showWaitText = false; // Hide "Please wait..." text
            });

            // Cancel the timer if the page loads within 3 seconds
            _waitTimer?.cancel();
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Error: ${error.description}');
            setState(() {
              _isLoading = false; // Stop loading on error
              _showWaitText = false; // Hide "Please wait..." text
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://web2.myaestheticspro.com/BN/index.cfm?05CAA878344543800DCCE4E5C183FD59'));
  }

  @override
  void dispose() {
    _waitTimer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
          if (_isLoading) // Show loading indicator if page is loading
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(), // Loading spinner
                  if (_showWaitText) // Show "Please wait..." after 3 seconds
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "Please wait...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}