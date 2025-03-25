import 'package:flutter/material.dart';
import 'package:for_ever_young/cubit/cubit.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';

Widget myDivider() => Padding(
    padding: const EdgeInsets.all(0.0),
    child: SizedBox(height: 0.1,)
);

final List<String> categories = [
  "Follow-Up", "Injectables", "Skin Rejuvenation", "Laser Hair Removal",
  "Body Contouring", "Facials & Peels", "Wellness", "Consultation",
  "Spa Services", "Bloodwork", "Weight Loss"
];

List<Map<String, dynamic>> getServices(String category) {
  return [
    {
      'name': '$category - Service 1',
      'duration': 45,
      'description': 'This is a description for $category service 1.',
    },
    {
      'name': '$category - Service 2',
      'duration': 60,
      'description': 'This is a description for $category service 2.',
    },
  ];
}


Widget defaultLoginField({
  required TextEditingController controller,
  required String hintText,
  required IconData prefixIcon,
  required TextInputType inputType,
  required String? Function(String?)? validator,
  bool isPassword = false,
  ValueNotifier<bool>? isPasswordVisible, // Notifier for password visibility
  VoidCallback? onTap,
}) {
  return ValueListenableBuilder<bool>(
    valueListenable: isPasswordVisible ?? ValueNotifier(false),
    builder: (context, isVisible, child) {
      return TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword ? !isVisible : false,
        validator: validator,
        style: TextStyle(fontSize: 17), // Adjust the font size
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(prefixIcon, color: Colors.grey, size: 25),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: secondaryColor, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          // Show/Hide password icon
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              isPasswordVisible?.value = !isVisible; // Toggle visibility
            },
          )
              : null,
        ),
        onTap: onTap,
      );
    },
  );
}

Widget defaultFormField({
  required BuildContext context,  // Pass the context here
  required TextEditingController? controller,
  required TextInputType? type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  void Function()? onTap,
  bool isPassword = false,
  required Function? validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable = true,
}) {
  final isDarkMode = ForEverYoungCubit.get(context).isDark;
  Color borderColor = isDarkMode ? Colors.white : Colors.black;
  Color labelColor = isDarkMode ? Colors.white : Colors.black;
  Color textColor = isDarkMode ? Colors.white : Colors.black;

  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    onFieldSubmitted: onSubmit,
    onTap: onTap,
    onChanged: onChange,
    enabled: isClickable,
    validator: (val) {
      validate;
      return null;
    },
    style: TextStyle(color: textColor), // Set the input text color based on the theme
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: labelColor), // Set the label text color based on the theme
      prefixIcon: Icon(prefix, color: borderColor), // Set the color of the prefix icon based on the theme
      suffixIcon: suffix != null
          ? Icon(suffix, color: borderColor) // Set the color of the suffix icon based on the theme
          : null,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor), // Set border color based on the theme
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor), // Set focused border color based on the theme
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: borderColor), // Set enabled border color based on the theme
      ),
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.white,
  required VoidCallback function,
  required String text,
  required bool isUpperCase,
}) => Container(
  width: width,
  height: 37.0,
  color: background,
  child: MaterialButton(
    onPressed: function,
    color: buttonColor,
    child: Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ),
);


Widget defaultSearchField({
  required BuildContext context, // Added context parameter
  required TextEditingController controller,
  required String hintText,
  double fontSize = 17,
  VoidCallback? onTap,
}) {
  return SizedBox(
    width: double.infinity, // Ensures full width
    height: MediaQuery.of(context).size.height * 0.06, // Responsive height
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 25),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
      ),
      style: TextStyle(fontSize: fontSize),
      onTap: onTap,
    ),
  );
}

Widget loginFormField({
  required TextEditingController controller,
  required String hintText,
  required TextInputType keyboardType,
  required IconData prefixIcon,
  bool isPassword = false,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: isPassword,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(prefixIcon, color: Colors.grey, size: 22),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14, color: Colors.grey), // Adjusted hint text size
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
    ),
    validator: validator,
  );
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
        (route){
      return true;
    }
);

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) => TextButton(
  onPressed: function,
  child: Text(text.toUpperCase()),
);