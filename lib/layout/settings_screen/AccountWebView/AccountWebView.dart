import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:for_ever_young/layout/settings_screen/contactUs_screen/contactUs_screen.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/components.dart';
import 'package:local_auth/local_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountLoginScreen extends StatefulWidget {
  const AccountLoginScreen({super.key});

  @override
  _AccountLoginScreenState createState() => _AccountLoginScreenState();
}

class _AccountLoginScreenState extends State<AccountLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isLoggingIn = false;
  bool _obscurePassword = true;
  late WebViewController _webViewController;
  bool _loginSuccess = false;

  @override
  void initState() {
    super.initState();
    _checkForSavedCredentials();
    _initializeWebView();
  }

  void _initializeWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (UrlChange change) {
          if (change.url != null && change.url!.contains('https://web2.myaestheticspro.com/portal/app/')) {
            _loginSuccess = true;
            _navigateToProfileScreen();
          }
        },
      ));
  }

  Future<void> _checkForSavedCredentials() async {
    try {
      String? savedUsername = await _secureStorage.read(key: 'username');
      String? savedPassword = await _secureStorage.read(key: 'password');
      String? firstLoginDone = await _secureStorage.read(key: 'first_login_done');
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;

      if (firstLoginDone == null) {
        _usernameController.text = savedUsername ?? '';
        _passwordController.text = savedPassword ?? '';
        return;
      }

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
          _navigateToProfileScreen();
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
    _loginSuccess = false;

    try {
      // Load the login page
      await _webViewController.loadRequest(Uri.parse('https://web2.myaestheticspro.com/portal/index.cfm?05CAA878344543800DCCE4E5C183FD59'));

      // Wait for page to load
      await Future.delayed(const Duration(seconds: 2));

      // Inject credentials
      await _webViewController.runJavaScript('''
        document.getElementById("username").value = "${_usernameController.text}";
        document.getElementById("password").value = "${_passwordController.text}";
        document.getElementById("login_btn").click();
      ''');

      // Wait for login to complete (5 seconds max)
      await Future.delayed(const Duration(seconds: 5));

      if (!_loginSuccess) {
        // If URL didn't change to success page
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(backgroundColor: Colors.red, content: const Text('Login failed. Please check your credentials', style: TextStyle(fontSize: 30,color: Colors.white),))
          );
        }
      }
    } catch (e) {
      debugPrint("Login error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: Colors.red, content: const Text('Please check your Internet Connection', style: TextStyle(fontSize: 30,color: Colors.white),))
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoggingIn = false);
      }
    }

    // Only save credentials if login was successful
    if (_loginSuccess) {
      await _secureStorage.write(key: 'username', value: _usernameController.text);
      await _secureStorage.write(key: 'password', value: _passwordController.text);
      await _secureStorage.write(key: 'first_login_done', value: "true");
    }
  }

  void _navigateToProfileScreen() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                    contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Make Row take only needed space
                    children: [
                      const Text(
                        'Problems with log in?',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          navigateTo(context, ContactUsScreen());
                        },
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            color: buttonColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late WebViewController _webViewController;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  bool _isLoading = true;
  bool _hasError = false;

  // Profile data extracted from WebView
  String name = 'Loading...';
  String address = 'Loading...';
  String phone = 'Loading...';
  String balance = '\$0.00';
  String invoiceDate = 'Loading...';
  String email = 'Loading...';
  String gender = 'Loading...';
  String birthdate = 'Loading...';
  String age = 'Loading...';
  String maritalStatus = 'Loading...';
  String ethnicity = 'Loading...';
  String service = 'Loading...';
  String remaining = '0';
  String cancellations = '0';
  String noShows = '0';
  String money = '0';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    try {
      String? savedUsername = await _secureStorage.read(key: 'username');
      String? savedPassword = await _secureStorage.read(key: 'password');

      _webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(NavigationDelegate(
          onPageFinished: (url) async {
            if (savedUsername != null && savedPassword != null) {
              // Inject credentials and login
              await _webViewController.runJavaScript('''
                document.getElementById("username").value = "$savedUsername";
                document.getElementById("password").value = "$savedPassword";
                document.getElementById("login_btn").click();
              ''');

              // Wait for login to complete
              await Future.delayed(const Duration(seconds: 2));

              // Extract profile data
              await _extractProfileData();
            }
          },
          onWebResourceError: (error) {
            setState(() {
              _hasError = true;
              _isLoading = false;
            });
          },
        ))
        ..loadRequest(Uri.parse("https://web2.myaestheticspro.com/portal/index.cfm?05CAA878344543800DCCE4E5C183FD59"));
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  Future<void> _extractProfileData() async {
    try {
      // First, wait for the page to fully load
      await Future.delayed(const Duration(seconds: 3));

      // Test if we can execute simple JavaScript first
      final testResult = await _webViewController.runJavaScriptReturningResult('1+1');
      debugPrint('JavaScript test result: $testResult');

      // Extract data in smaller chunks
      final name = await _extractSingleField('.profl_cnt h2');
      final address = await _extractSingleField('.profl_cnt ul li:first-child', clean: true);
      final phone = await _extractSingleField('.profl_cnt ul li:nth-child(2) a');
      final money = await _extractSingleField('.money');

      debugPrint('Basic info extracted: $name, $address, $phone');

      // Extract balance information
      final balanceData = await _extractBalanceInfo();

      // Extract other details
      final email = await _extractSingleField('.content .main:nth-child(2) .col-8 p');
      final gender = await _extractSingleField('.content .main:nth-child(3) .col-8.col-lg-3 p');
      final birthdate = await _extractSingleField('.content .main:nth-child(4) .col-8.col-lg-3 p');
      final age = await _extractSingleField('.content .main:nth-child(4) .col-8.col-lg-3 p');

      setState(() {
        this.name = name ?? 'N/A';
        this.address = address ?? 'N/A';
        this.phone = phone ?? 'N/A';
        this.birthdate = birthdate ?? 'N/A';
        this.age = age ?? 'N/A';
        this.money = money ?? 'N/A';
        this.invoiceDate = balanceData['invoiceDate'] ?? 'N/A';
        this.email = email ?? 'N/A';
        this.gender = gender ?? 'N/A';
        _isLoading = false;
      });

    } catch (e) {
      debugPrint('Error extracting profile data: $e');
      setState(() {
        _isLoading = false;
      });

      // Try to get the page HTML for debugging
      try {
        final html = await _webViewController.runJavaScriptReturningResult('document.documentElement.outerHTML');
        debugPrint('Page HTML (first 500 chars): ${html.toString().substring(0, 500)}');
      } catch (e) {
        debugPrint('Could not retrieve page HTML: $e');
      }
    }
  }

  Future<String?> _extractSingleField(String selector, {bool clean = false}) async {
    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
      (function() {
        var el = document.querySelector('$selector');
        if (!el) return null;
        var text = el.innerText;
        ${clean ? "text = text.replace(/\\n/g, '').trim();" : ""}
        return text;
      })();
    ''');
      return result?.toString();
    } catch (e) {
      debugPrint('Error extracting $selector: $e');
      return null;
    }
  }

  Future<Map<String, String>> _extractBalanceInfo() async {
    try {
      final result = await _webViewController.runJavaScriptReturningResult('''
      (function() {
        var moneyEl = document.querySelector('.money_box .money');
        var balanceEl = document.querySelector('.money_box .balance');
        
        var balance = moneyEl ? moneyEl.innerText.replace(/\n/g, '').replace(/\$/g, '').trim() : '0.00';
        var invoiceDate = balanceEl ? 
          (balanceEl.innerText.split('Invoice Balance:')[1] || '').split('<br>')[0].trim() : '';
          
        return {
          balance: balance,
          invoiceDate: invoiceDate
        };
      })();
    ''');

      if (result is Map) {
        return {
          'balance': result['balance']?.toString() ?? '0.00',
          'invoiceDate': result['invoiceDate']?.toString() ?? 'N/A'
        };
      }
      return {'balance': '0.00', 'invoiceDate': 'N/A'};
    } catch (e) {
      debugPrint('Error extracting balance info: $e');
      return {'balance': '0.00', 'invoiceDate': 'N/A'};
    }
  }

  Future<void> _logout() async {
    await _secureStorage.delete(key: 'username');
    await _secureStorage.delete(key: 'password');
    await _secureStorage.delete(key: 'first_login_done');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AccountLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Account"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _extractProfileData();
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
                    setState(() {
                      _hasError = false;
                      _isLoading = true;
                    });
                    _initializeWebView();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                  ),
                  child: const Text("Reload",
                    style: TextStyle(
                      color: Colors.white,
                    ),),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    const url = "https://web2.myaestheticspro.com/portal/index.cfm?05CAA878344543800DCCE4E5C183FD59";
                    if (await canLaunchUrl(Uri.parse(url))) {
                      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
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
          : _isLoading
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              "Loading profile...",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Section
              const Text(
                'My information',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Profile Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      image: const DecorationImage(
                        image: AssetImage('images/nouser.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 13,),
                        //Name
                        Text(
                          name,
                          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3),
                        //Location
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 4),
                            Text(
                                address,
                              style: TextStyle(
                                fontSize: 12
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Balance Info
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Balance:',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                            Row(
                              children: [
                                const SizedBox(width: 4),
                                Text(money, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
              const SizedBox(height: 24),

              // Client Details Card
              Card(
                color: Colors.grey[100],
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Client Details',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // Phone Numbers
                      _buildDetailRow(
                        icon: Icon(FluentIcons.phone_16_regular,size: 30),
                        label: 'Phone:',
                        values: [
                          _buildDetailItem(label: '', value: phone),
                        ],
                      ),
                      const Divider(),

                      // Email
                      _buildDetailRow(
                        icon: Icon(FluentIcons.mail_16_regular,size: 30),
                        label: 'Email:',
                        values: [
                          _buildDetailItem(value: email)
                        ],
                      ),
                      const Divider(),

                      // Gender
                      _buildDetailRow(
                        icon: Icon(Icons.wc_rounded,size: 30),
                        label: 'Gender:',
                        values: [
                          _buildDetailItem(label: 'Gender:', value: gender),
                        ],
                      ),
                      const Divider(),

                      // Birthdate
                      _buildDetailRow(
                        icon: Icon(FluentIcons.food_cake_12_regular,size: 30),
                        label: 'Birthdate:',
                        values: [
                          _buildDetailItem(value: birthdate),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              //Access full features
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Make Row take only needed space
                  children: [
                    const Text(
                      'To access your full account, please use our website.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final Uri url = Uri.parse('https://web2.myaestheticspro.com/portal/index.cfm?05CAA878344543800DCCE4E5C183FD59');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication, // This opens Safari or the default browser
                          );
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Text(
                        'Press here',
                        style: TextStyle(
                          color: buttonColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required String label,
    Icon? icon,
    required List<Widget> values,
  }) {
    return Container(
      height: 60,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  icon,
                  const SizedBox(width: 5),
                ],
                Text(label, style: const TextStyle(fontSize: 23)),
                const SizedBox(width: 12),
                ...values,
              ],
            );
          } else {
            // Desktop layout
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150, // Increased slightly to make space for icon
                  child: Row(
                    children: [
                      if (icon != null) ...[
                        icon,
                        const SizedBox(width: 6),
                      ],
                      Text(label, style: TextStyle(fontSize: 15, color: buttonColor)),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (var value in values) ...[
                        value,
                        if (value != values.last) const SizedBox(width: 16),
                      ],
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
  Widget _buildDetailItem({String? label, required String value}) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimize the space used by the column
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}