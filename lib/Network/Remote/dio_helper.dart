// import 'package:dio/dio.dart';
// import 'package:dio_cookie_manager/dio_cookie_manager.dart' as dio_cookie;
// import 'package:cookie_jar/cookie_jar.dart';
//
// class AestheticProAuth {
//   final Dio dio = Dio();
//   final CookieJar cookieJar = CookieJar();
//   String? storedCookies;
//
//   AestheticProAuth() {
//     dio.interceptors.add(dio_cookie.CookieManager(cookieJar)); // Use 'dio_cookie.' to specify package
//   }
//
//   Future<void> login(String username, String password) async {
//     try {
//       Response response = await dio.post(
//         'https://web2.myaestheticspro.com/portal/cfc/cpfunctions.cfc?method=authenticate&ReturnFormat=json',
//         data: {'username': username, 'password': password},
//         options: Options(
//           headers: {
//             'Referer': 'https://web2.myaestheticspro.com/portal/app/',
//             'User-Agent':
//             'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36',
//           },
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         print('✅ Login successful!');
//         var rawCookies = response.headers['set-cookie'];
//         if (rawCookies != null) {
//           String cookies = rawCookies.join('; ');
//           RegExp cookieRegex = RegExp(r'(CFID=[^;]+|CFTOKEN=[^;]+|JSESSIONID=[^;]+)');
//           Iterable<Match> matches = cookieRegex.allMatches(cookies);
//           storedCookies = matches.map((m) => m.group(0)).join('; ');
//
//           print('🔹 Stored Auth Cookies: $storedCookies');
//         }
//       } else {
//         print('❌ Login failed: ${response.statusMessage}');
//       }
//     } catch (e) {
//       print('❌ Error during login: $e');
//     }
//   }
//
//   Future<void> getClientData() async {
//     try {
//       if (storedCookies == null || storedCookies!.isEmpty) {
//         throw Exception('⚠️ User is not authenticated (No cookies found)');
//       }
//
//       Response response = await dio.get(
//         'https://web2.myaestheticspro.com/portal/cfc/cpfunctions.cfc?method=getClientData&ReturnFormat=json',
//         options: Options(
//           headers: {
//             'Cookie': storedCookies!,
//             'Referer': 'https://web2.myaestheticspro.com/portal/app/',
//           },
//         ),
//       );
//
//       print('✅ Client Data: ${response.data}');
//     } catch (e) {
//       print('❌ Error fetching client data: $e');
//     }
//   }
// }
//
