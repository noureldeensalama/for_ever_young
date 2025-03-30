import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:local_auth/local_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentsLoginScreen extends StatefulWidget {
  const AppointmentsLoginScreen({super.key});

  @override
  _AppointmentsLoginScreenState createState() => _AppointmentsLoginScreenState();
}

class _AppointmentsLoginScreenState extends State<AppointmentsLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isLoggingIn = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _buildNoticeScreen();
    _checkForSavedCredentials();
  }

  void _buildNoticeScreen() {
    // Code for building the notice screen
    // This function should return a widget to display the notice
  }

  Future<void> _checkForSavedCredentials() async {
    try {
      String? savedUsername = await _secureStorage.read(key: 'username');
      String? savedPassword = await _secureStorage.read(key: 'password');
      String? firstLoginDone = await _secureStorage.read(key: 'first_login_done');
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;

      // First-time login: Require manual credentials
      if (firstLoginDone == null) {
        _usernameController.text = savedUsername ?? '';
        _passwordController.text = savedPassword ?? '';
        return; // Exit to prevent Face ID attempt
      }

      // Subsequent logins: Use Face ID if available
      if (savedUsername != null && savedPassword != null && canCheckBiometrics) {
        bool didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access your account',
          options: const AuthenticationOptions(
            biometricOnly: true,
            useErrorDialogs: true,
            stickyAuth: true,
          ),
        );

        if (didAuthenticate) {
          _navigateToWebView();
        }
      } else {
        _usernameController.text = savedUsername ?? '';
        _passwordController.text = savedPassword ?? '';
      }
    } catch (e) {
      debugPrint("Error in biometric authentication: $e");
    }
  }

  Future<void> _login() async {
    setState(() => _isLoggingIn = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate login request

    await _secureStorage.write(key: 'username', value: _usernameController.text);
    await _secureStorage.write(key: 'password', value: _passwordController.text);
    await _secureStorage.write(key: 'first_login_done', value: "true"); // Set login flag

    setState(() => _isLoggingIn = false);
    _navigateToWebView();
  }

  void _navigateToWebView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AppointmentsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/logo.png',
                    height: MediaQuery.of(context).size.height * 0.12,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Email Address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.grey),
                      prefixIcon: Icon(Icons.email_outlined, color: Theme.of(context).colorScheme.secondary, size: 27,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: buttonColor, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: _obscurePassword,
                    style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.015, color: Colors.grey),
                      prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).colorScheme.secondary),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: buttonColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: buttonColor, width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoggingIn ? null : _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                      ),
                      child: _isLoggingIn
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text("Login", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        )
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late WebViewController _controller;
  final String url = "https://web2.myaestheticspro.com/portal/index.cfm?05CAA878344543800DCCE4E5C183FD59";
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _showWebView = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    setState(() {
      _hasError = false; // Reset error state on reload
    });
    try {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (url) async {
            try {
              String? savedUsername = await _secureStorage.read(key: 'username');
              String? savedPassword = await _secureStorage.read(key: 'password');

              if (savedUsername != null && savedPassword != null) {
                await Future.delayed(const Duration(milliseconds: 500)); // Faster execution

                await _controller.runJavaScript('''
                setTimeout(() => {
                  document.getElementById("username").value = "$savedUsername";
                  document.getElementById("password").value = "$savedPassword";
                  document.getElementById("togglePassword").click(); // Reveal password

                  document.getElementById("username").dispatchEvent(new Event('input', { bubbles: true }));
                  document.getElementById("password").dispatchEvent(new Event('input', { bubbles: true }));

                  setTimeout(() => {
                    let loginBtn = document.getElementById("login_btn");
                    loginBtn.click();
                    loginBtn.dispatchEvent(new Event('click', { bubbles: true }));
                  }, 300);
                }, 300);
                ''');

                if (url == "https://web2.myaestheticspro.com/portal/app/") {
                  setState(() {
                    _showWebView = true;
                  });
                }
              }
            } catch (e) {
              debugPrint("Error injecting credentials: $e");
            }
          },
          onWebResourceError: (error) {
            setState(() {
              _hasError = true;
            });
            debugPrint("WebView Error: ${error.description}");
          },
        ))
        ..loadRequest(Uri.parse(url));
    } catch (e) {
      debugPrint("Error initializing WebView: $e");
    }
  }

  Future<void> _logout() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
    await _secureStorage.delete(key: 'first_login_done'); // Ensure Face ID is not used next time

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AppointmentsLoginScreen()),
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

  @override
  Widget build(BuildContext context) {
    if (!_showWebView && !_hasError) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Appointments"),
        ),
        body: _buildNoticeScreen(), // Show notice screen first
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _controller.reload();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: _hasError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, color: Colors.red, size: 80),
            const SizedBox(height: 10),
            const Text(
              "No internet or network issue",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => _hasError = false);
                    _initializeWebView();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor, // Reload button color
                  ),
                  child: const Text("Reload",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, // Open in Browser button color
                  ),
                  child: const Text("Open in Browser",
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
              ],
            ),
          ],
        ),
      )
          : !_showWebView
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              "Logging in...",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _controller.reload(),
              child: WebViewWidget(controller: _controller),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Logging in...",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}