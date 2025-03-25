// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:for_ever_young/layout/for_ever_young_layout.dart';
// import 'package:for_ever_young/register/cubit/register_cubit.dart';
// import 'package:for_ever_young/register/cubit/states.dart';
// import 'package:for_ever_young/network/local/cache_helper.dart';
// import 'package:for_ever_young/shared/colors_and_themes/color.dart';
// import 'package:for_ever_young/shared/components.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
//
// class RegisterScreen extends StatefulWidget {
//
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final formKey = GlobalKey<FormState>();
//
//   final TextEditingController firstNameController = TextEditingController();
//
//   final TextEditingController lastNameController = TextEditingController();
//
//   final TextEditingController dobController = TextEditingController();
//
//   final TextEditingController emailController = TextEditingController();
//
//   final TextEditingController passwordController = TextEditingController();
//
//   final TextEditingController phoneController = TextEditingController();
//
//   final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
//
//   String countryCode = '+1';
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => ForEverYoungRegisterCubit(),
//       child: BlocConsumer<ForEverYoungRegisterCubit, ForEverYoungRegisterStates>(
//         listener: (context, state) {
//           if (state is ForEverYoungCreateUserSuccessState) {
//             CacheHelper.saveData(key: 'uID', value: state.uID).then((value) {
//               navigateAndFinish(context, ForEverYoungLayout());
//             });
//           } else if (state is ForEverYoungRegisterErrorState) {
//           }
//         },
//         builder: (context, state) {
//           double screenWidth = MediaQuery.of(context).size.width;
//           return Scaffold(
//             appBar: AppBar(),
//             body: Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: screenWidth * 0.15),
//                       Image.asset('images/logo.png'),
//                       const SizedBox(height: 30.0),
//
//                       /// First Name
//                       defaultLoginField(
//                         controller: firstNameController,
//                         hintText: 'First Name',
//                         prefixIcon: Icons.person,
//                         inputType: TextInputType.name,
//                         validator: (value) =>
//                         value!.isEmpty ? 'Please enter your first name' : null,
//                       ),
//                       const SizedBox(height: 20.0),
//
//                       /// Last Name
//                       defaultLoginField(
//                         controller: lastNameController,
//                         hintText: 'Last Name',
//                         prefixIcon: Icons.person_outline,
//                         inputType: TextInputType.name,
//                         validator: (value) =>
//                         value!.isEmpty ? 'Please enter your last name' : null,
//                       ),
//                       const SizedBox(height: 20.0),
//
//                       /// Date of Birth
//                       TextFormField(
//                         controller: dobController,
//                         decoration: InputDecoration(
//                           labelText: 'Date of Birth',
//                           labelStyle: TextStyle(fontSize: 14, color: Colors.grey.shade600),
//                           prefixIcon: Padding(
//                             padding: EdgeInsets.only(left: 10, right: 5), // Adjust padding
//                             child: Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600), // Smaller icon
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                         ),
//                         style: TextStyle(fontSize: 14),
//                         readOnly: true,
//                         onTap: () async {
//                           DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime(2005, 1, 1),
//                             firstDate: DateTime(1900),
//                             lastDate: DateTime.now(),
//                             builder: (context, child) {
//                               return Theme(
//                                 data: Theme.of(context).copyWith(
//                                   textTheme: TextTheme(
//                                     bodyLarge: TextStyle(fontSize: 14), // Smaller for year/month
//                                     bodyMedium: TextStyle(fontSize: 13), // Smaller for days
//                                     labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w500), // Header text
//                                   ),
//                                 ),
//                                 child: child!,
//                               );
//                             },
//                           );
//                           if (pickedDate != null) {
//                             dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
//                           }
//                         },
//                         validator: (value) => value!.isEmpty ? 'Please select your date of birth' : null,
//                       ),
//                       const SizedBox(height: 20.0),
//
//                       /// Email
//                       defaultLoginField(
//                         controller: emailController,
//                         hintText: 'Email Address',
//                         prefixIcon: Icons.email_outlined,
//                         inputType: TextInputType.emailAddress,
//                         validator: (value) =>
//                         value!.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)
//                             ? 'Please enter a valid Email Address'
//                             : null,
//                       ),
//                       const SizedBox(height: 20.0),
//
//                       /// Password
//                       defaultLoginField(
//                         controller: passwordController,
//                         hintText: 'Password',
//                         prefixIcon: Icons.lock_outline,
//                         inputType: TextInputType.text,
//                         validator: (value) => value!.length < 6
//                             ? 'Password must be at least 6 characters'
//                             : null,
//                         isPassword: true,
//                         isPasswordVisible: isPasswordVisible,
//                       ),
//                       const SizedBox(height: 20.0),
//
//                       /// Phone Number
//                       IntlPhoneField(
//                         controller: phoneController,
//                         decoration: InputDecoration(
//                           labelText: 'Phone Number',
//                           labelStyle: TextStyle(fontSize: 14), // Match DOB field
//                           prefixIcon: Padding(
//                             padding: EdgeInsets.only(left: 10, right: 5), // Match DOB field padding
//                             child: Icon(Icons.phone, size: 16, color: Colors.grey.shade600), // Smaller icon like DOB field
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade400), // Match DOB field border
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade400),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 12), // Match DOB field height
//                         ),
//                         initialCountryCode: 'US',
//                         onChanged: (phone) {
//                           countryCode = phone.countryCode;
//                         },
//                         validator: (value) => value == null || value.number.isEmpty
//                             ? 'Please enter your phone number'
//                             : null,
//                         style: TextStyle(fontSize: 14), // Match DOB field font size
//                         dropdownTextStyle: TextStyle(fontSize: 13), // Slightly smaller dropdown text
//                         dropdownIcon: Icon(Icons.arrow_drop_down, size: 16), // Match smaller icon size
//                         dropdownDecoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         flagsButtonPadding: EdgeInsets.symmetric(horizontal: 8), // Adjust flag spacing
//                       ),
//                       const SizedBox(height: 20.0),
//
//                       /// Register Button
//                       SizedBox(
//                         width: screenWidth * 0.9,
//                         child: ConditionalBuilder(
//                           condition: state is! ForEverYoungRegisterLoadingState,
//                           fallback: (context) => const Center(child: CircularProgressIndicator()),
//                           builder: (context) => ElevatedButton(
//                             onPressed: () {
//                               if (formKey.currentState!.validate()) {
//                                 ForEverYoungRegisterCubit.get(context).userRegister(
//                                   firstName: firstNameController.text,
//                                   lastName: lastNameController.text,
//                                   dob: dobController.text,
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                   phone: "$countryCode${phoneController.text}",
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: secondaryColor,
//                               padding: const EdgeInsets.symmetric(vertical: 15),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text('REGISTER', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }