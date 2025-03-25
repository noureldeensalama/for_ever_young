import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  bool _showNotice = true;
  bool _isConnected = true;
  late final WebViewController _controller;
  final String url = "https://web2.myaestheticspro.com/portal/?07D3D1AE7D2B071417A53D7D3E50DAE84E10DFDF7DA40A43ADD5024F89E75B76FBC66F7FCA968DDF12B85466368C5E81";

  @override
  void initState() {
    super.initState();
    _checkInternetConnection();
    _controller = WebViewController()..loadRequest(Uri.parse(url));
    _delayedLoad();
  }

  Future<void> _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = (result != ConnectivityResult.none);
    });

    // Reload WebView if connection is back
    if (_isConnected) {
      _controller.loadRequest(Uri.parse(url));
    }
  }

  void _delayedLoad() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _showNotice = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('images/logo_banner.png', height: 60),
      ),
      body: _showNotice
          ? _buildNoticeScreen()
          : (_isConnected ? WebViewWidget(controller: _controller) : _buildNoInternetScreen()),
    );
  }

  Widget _buildNoticeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.info_outline, size: 50, color: Colors.blue),
          const SizedBox(height: 16),
          const Text(
            "To access appointments, you must use our software.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
          const CircularProgressIndicator(color: Colors.blue),
        ],
      ),
    );
  }

  Widget _buildNoInternetScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          const Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Please check your network and try again.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _checkInternetConnection,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}