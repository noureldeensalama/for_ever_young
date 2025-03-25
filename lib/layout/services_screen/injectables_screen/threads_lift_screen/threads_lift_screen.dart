import 'package:flutter/material.dart';

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThreadsLiftScreen extends StatefulWidget {
  const ThreadsLiftScreen({super.key});

  @override
  _ThreadsLiftScreenState createState() => _ThreadsLiftScreenState();
}

class _ThreadsLiftScreenState extends State<ThreadsLiftScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasInternet = true;
  bool _showWaitText = false;
  Timer? _waitTimer;

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _showWaitText = false;
            });

            // Start a timer for 5 seconds to show "Please wait..."
            _waitTimer?.cancel();
            _waitTimer = Timer(const Duration(seconds: 3), () {
              if (_isLoading) {
                setState(() {
                  _showWaitText = true;
                });
              }
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
              _showWaitText = false;
            });

            // Cancel the timer if the page loads within 5 seconds
            _waitTimer?.cancel();
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _hasInternet = false;
            });
          },
        ),
      );
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _hasInternet = false;
      });
    } else {
      setState(() {
        _hasInternet = true;
      });
      _controller.loadRequest(Uri.parse("https://4everyoungstl.com/specials/threads-lift/"));
    }
  }


  @override
  void dispose() {
    _waitTimer?.cancel(); // Cancel timer when widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo_banner.png',
          height: 60, // Adjust size as needed
        ),
      ),
      body: SafeArea(
        child: _hasInternet
            ? Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Expanded(
                child: WebViewWidget(controller: _controller),
              ),
            ),
            if (_isLoading)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_showWaitText) // Show "Please wait..." after 5 seconds
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
        )
            : Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off, size: 80, color: Colors.red),
              const SizedBox(height: 10),
              const Text(
                "No internet connection",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _checkInternetConnection,
                child: Text(
                  "Retry",
                  style: TextStyle(fontSize: 20, color: buttonColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}