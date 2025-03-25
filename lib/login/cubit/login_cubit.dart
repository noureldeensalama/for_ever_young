// import 'package:cookie_jar/cookie_jar.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:for_ever_young/login/cubit/states.dart';
// import 'package:for_ever_young/models/user_model.dart';
// import 'dart:convert';
// import 'package:html/parser.dart' as htmlParser;
//
// class ForEverYoungLoginCubit extends Cubit<ForEverYoungLoginStates> {
//   ForEverYoungLoginCubit() : super(ForEverYoungLoginInitialState());
//
//   static ForEverYoungLoginCubit get(context) => BlocProvider.of(context);
//
//   final Dio dio = Dio(); // Maintain a single Dio instance
//   final CookieJar cookieJar = CookieJar(); // Persistent cookie storage
//   UserModel? userModel;
//
//
//   Future<void> loginAndFetchData({required String email, required String password}) async {
//     emit(ForEverYoungLoginLoadingState());
//
//     try {
//       // Step 1: Log in and capture cookies
//       final loginResponse = await dio.post(
//         'https://web2.myaestheticspro.com/portal/cfc/cpfunctions.cfc?method=authenticate&ReturnFormat=json',
//         data: {'email': email, 'password': password},
//         options: Options(headers: {'Content-Type': 'application/json'}),
//       );
//
//       if (loginResponse.statusCode == 200) {
//         print('✅ Login successful!');
//
//         // Print stored cookies
//         final cookies = await cookieJar.loadForRequest(Uri.parse('https://web2.myaestheticspro.com/portal/app/'));
//         print('🔹 Cookies after login: $cookies');
//
//         // Fetch user panel data with authentication
//         await fetchPanelData();
//       } else {
//         print('❌ Login failed. Status code: ${loginResponse.statusCode}');
//         emit(ForEverYoungLoginErrorState("Login failed"));
//       }
//     } catch (e) {
//       print('❌ Login Error: $e');
//       emit(ForEverYoungLoginErrorState(e.toString()));
//     }
//   }
//
//   Future<void> fetchPanelData() async {
//     try {
//       // Ensure we use the same Dio instance (with cookies)
//       final panelResponse = await dio.get(
//         'https://web2.myaestheticspro.com/portal/cfc/cpfunctions.cfc',
//         queryParameters: {'method': 'getPanelData', 'ReturnFormat': 'json'},
//       );
//
//       print('🔹 Raw Panel Response: ${panelResponse.data}');
//
//       if (panelResponse.statusCode == 200) {
//         dynamic responseData = panelResponse.data;
//
//         if (responseData is String) {
//           if (responseData.contains("{ts '")) {
//             responseData = fixColdFusionTimestamp(responseData);
//             print('✅ Fixed ColdFusion Timestamp: $responseData');
//           }
//
//           if (responseData.contains('<html')) {
//             final jsonData = extractDataFromHtml(responseData);
//             print('✅ Extracted User Data: $jsonData');
//             userModel = UserModel.fromJson(jsonData);
//           }
//         } else if (responseData is Map<String, dynamic>) {
//           print('✅ JSON Response: ${jsonEncode(responseData)}');
//           userModel = UserModel.fromJson(responseData);
//         } else {
//           print('❌ Unexpected Response Format: $responseData');
//         }
//
//         if (userModel != null) {
//           print("✅ User Logged In: ${userModel!.name}");
//           emit(ForEverYoungLoginSuccessState(userModel!));
//         } else {
//           emit(ForEverYoungLoginErrorState("User data not found"));
//         }
//       } else {
//         print('❌ Panel request failed. Status code: ${panelResponse.statusCode}');
//         emit(ForEverYoungLoginErrorState("Failed to fetch panel data"));
//       }
//     } catch (e) {
//       print('❌ Error fetching panel data: $e');
//       emit(ForEverYoungLoginErrorState(e.toString()));
//     }
//   }
//
//   String fixColdFusionTimestamp(String data) {
//     return data.replaceAllMapped(
//       RegExp(r"\{ts '(.+?)'\}"),
//           (match) => '"${match.group(1)}"',
//     );
//   }
//
//   Map<String, dynamic> extractDataFromHtml(String html) {
//     final document = htmlParser.parse(html);
//     final userName = document.querySelector('.user-name')?.text ?? 'Unknown';
//     final userEmail = document.querySelector('.user-email')?.text ?? 'Unknown';
//
//     return {
//       'name': userName,
//       'email': userEmail,
//     };
//   }
//
//   IconData suffix = Icons.visibility_outlined;
//   bool isPassword = true;
//
//   void changePasswordVisibility() {
//     isPassword = !isPassword;
//     suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(ForEverYoungChangePasswordVisibilityState());
//   }
// }