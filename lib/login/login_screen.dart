// // import 'package:flutter/material.dart';
// // import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// // import 'package:for_ever_young/Network/Local/cache_helper.dart';
// // import 'package:for_ever_young/layout/for_ever_young_layout.dart';
// // import 'package:for_ever_young/shared/colors_and_themes/color.dart';
// //
// // class LoginScreen extends StatefulWidget {
// //   @override
// //   _LoginScreenState createState() => _LoginScreenState();
// // }
// //
// // class _LoginScreenState extends State<LoginScreen> {
// //   InAppWebViewController? webViewController;
// //   CookieManager cookieManager = CookieManager.instance();
// //   bool isLoading = true; // Track page loading state
// //   bool isLoggedIn = false; // To track login status
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(),
// //       body: Stack(
// //         children: [
// //           InAppWebView(
// //             initialUrlRequest: URLRequest(
// //               url: WebUri("https://web2.myaestheticspro.com/portal/?07D3D1AE7D2B071417A53D7D3E50DAE84E10DFDF7DA40A43ADD5024F89E75B76FBC66F7FCA968DDF12B85466368C5E81"),
// //             ),
// //             initialSettings: InAppWebViewSettings(
// //               cacheEnabled: true,
// //               javaScriptEnabled: true,
// //               domStorageEnabled: true,
// //               supportZoom: false,
// //               transparentBackground: true,
// //             ),
// //             onWebViewCreated: (controller) {
// //               webViewController = controller;
// //             },
// //               onLoadStop: (controller, url) async {
// //                 setState(() => isLoading = false); // Hide loader
// //
// //                 if (url != null) {
// //                   print("🔍 Current URL: ${url.toString()}");
// //
// //                   // Save cookies after login
// //                   List<Cookie> cookies = await cookieManager.getCookies(url: url!);
// //                   for (var cookie in cookies) {
// //                     print("✅ Saved Cookie: ${cookie.name} = ${cookie.value}");
// //
// //                     // Save cookies locally using CacheHelper
// //                     await CacheHelper.saveData(key: cookie.name, value: cookie.value);
// //                   }
// //                 }
// //
// //                 // 🚀 Detect if the user is logged in and navigate
// //                 if (!isLoggedIn && url.toString().contains("portal")) {
// //                   print("🔄 Login successful! Saving cookies...");
// //
// //                   setState(() {
// //                     isLoggedIn = true;
// //                   });
// //
// //                   await CacheHelper.saveData(key: 'isLoggedIn', value: true);
// //                   await webViewController?.stopLoading();
// //
// //                   if (mounted) {
// //                     Navigator.pushReplacement(
// //                       context,
// //                       MaterialPageRoute(builder: (context) => ForEverYoungLayout()),
// //                     );
// //                   }
// //                 }
// //               }
// //               ),
// //
// //           // Show loading spinner while the page is loading
// //           if (isLoading)
// //             Center(
// //               child: CircularProgressIndicator(
// //                 color: buttonColor,
// //               ),
// //             ),
// //         ],
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:for_ever_young/Network/Remote/dio_helper.dart';
// import 'package:for_ever_young/layout/for_ever_young_layout.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final AestheticProAuth auth = AestheticProAuth();
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isLoading = false;
//
//   Future<void> _login() async {
//     setState(() => isLoading = true);
//     await auth.login(usernameController.text, passwordController.text);
//     setState(() => isLoading = false);
//
//     if (auth.storedCookies != null && auth.storedCookies!.isNotEmpty) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ForEverYoungLayout(), // Correct
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
//             TextField(controller: passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: isLoading ? null : _login,
//               child: isLoading
//                   ? CircularProgressIndicator(color: Colors.white)
//                   : Text("Login"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }