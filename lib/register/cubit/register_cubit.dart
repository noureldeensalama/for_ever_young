// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:http/http.dart' as http;
// import 'package:for_ever_young/register/cubit/states.dart';
//
// class ForEverYoungRegisterCubit extends Cubit<ForEverYoungRegisterStates> {
//   ForEverYoungRegisterCubit() : super(ForEverYoungRegisterInitialState());
//
//   static ForEverYoungRegisterCubit get(context) => BlocProvider.of(context);
//
//   void userRegister({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required String password,
//     required String phone,
//     required String dob,
//     // required String postalCode,
//     // required String bestTimeToCall,
//     // required List<String> services,
//     // required String specialNotes,
//   }) async {
//     emit(ForEverYoungRegisterLoadingState());
//
//     final Uri url = Uri.parse('https://www.aestheticspro.com/webforms/api/act_insertleadgen.cfm');
//
//     // Ensure phone number is long enough to extract area code and exchange
//     String areaCode = phone.length >= 3 ? phone.substring(0, 3) : "";
//     String exchange = phone.length >= 6 ? phone.substring(3, 6) : "";
//     String lineNumber = phone.length > 6 ? phone.substring(6) : "";
//
//     final Map<String, String> body = {
//       'Lead_Fname': firstName,
//       'Lead_Lname': lastName,
//       'Lead_Email': email,
//       'Lead_Password': password, // Added password field
//       'Lead_DOB': dob, // Added Date of Birth (DOB) field
//       'Phone': '3', // Assuming mobile phone
//       'PhoneFormat': '1',
//       'lead_homephoneAC': areaCode,
//       'lead_homephoneEX': exchange,
//       'lead_homephone': lineNumber,
//       // 'Lead_Postal': postalCode,
//       // 'BestTimeToCall': bestTimeToCall,
//       // 'services': services.join(','), // Convert list to comma-separated string
//       // 'specialnotes': specialNotes,
//       'Camp_ID': '1',
//       'Formsub': '',
//       'lsloc': '1B12720990BF651DF8DDF0BD67F98A16',
//       'Custom1': '',
//       'Custom2': '',
//       'Custom3': '',
//     };
//
//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         emit(ForEverYoungRegisterSuccessState());
//       } else {
//         emit(ForEverYoungRegisterErrorState("Failed to register: ${response.body}"));
//       }
//     } catch (error) {
//       emit(ForEverYoungRegisterErrorState(error.toString()));
//     }
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