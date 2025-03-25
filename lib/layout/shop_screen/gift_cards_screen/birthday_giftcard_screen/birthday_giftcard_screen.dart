import 'package:flutter/material.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';

class birthdayGiftcardScreen extends StatefulWidget {
  const birthdayGiftcardScreen({super.key});

  @override
  _birthdayGiftcardScreenState createState() => _birthdayGiftcardScreenState();
}

class _birthdayGiftcardScreenState extends State<birthdayGiftcardScreen> {
  String _selectedAmount = "Select Amount";
  String _selectedQuantity = "1";
  String _selectedDeliveryDate = "Now";
  DateTime? _pickedDate;
  final TextEditingController _recipientNameController = TextEditingController();
  final TextEditingController _recipientEmailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            textTheme: TextTheme(
              bodyLarge: TextStyle(fontSize: 14), // Adjust the font size here
              bodyMedium: TextStyle(fontSize: 12),
              labelLarge: TextStyle(fontSize: 14),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _pickedDate = picked;
        _selectedDeliveryDate = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  bool _validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email);
  }

  void _saveData() {
    if (_recipientEmailController.text.isNotEmpty &&
        !_validateEmail(_recipientEmailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email address")),
      );
      return;
    }

    print("Gift Amount: $_selectedAmount");
    print("Quantity: $_selectedQuantity");
    print("Recipient Name: ${_recipientNameController.text}");
    print("Recipient Email: ${_recipientEmailController.text}");
    print("Message: ${_messageController.text}");
    print("Delivery Date: $_selectedDeliveryDate");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo_banner.png',
          height: screenWidth * 0.15,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Happy Birthday",
                style: TextStyle(
                  fontSize: screenWidth * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Center(
                child: Image.asset(
                  'images/shop_screen_photos/giftcards_photos/birthday.png',
                  height: screenWidth * 0.4,
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gift Amount",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.035, // Slightly smaller font size
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  SizedBox(
                    height: screenWidth * 0.12, // Reducing the height of the TextField
                    child: TextField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: screenWidth * 0.035), // Adjust input text size
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: screenWidth * 0.02, horizontal: screenWidth * 0.03),
                        hintText: "Enter amount",
                        hintStyle: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey), // Smaller hint text
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedAmount = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenWidth * 0.03),
              _buildDropdown(
                "Quantity",
                ["1", "2", "3", "4", "5"],
                screenWidth,
                _selectedQuantity,
                    (value) => setState(() => _selectedQuantity = value!),
              ),
              SizedBox(height: screenWidth * 0.03),
              _buildTextField("Recipient Name", _recipientNameController, screenWidth),
              SizedBox(height: screenWidth * 0.03),
              _buildTextField("Recipient Email", _recipientEmailController, screenWidth, hint: "Enter email"),
              SizedBox(height: screenWidth * 0.03),
              _buildTextField("Message", _messageController, screenWidth, hint: "Type your message here"),
              SizedBox(height: screenWidth * 0.03),
              _buildDropdown(
                "Delivery Date",
                ["Now", "Tomorrow", if (_pickedDate != null) _selectedDeliveryDate, "Pick a date"],
                screenWidth,
                ["Now", "Tomorrow", _selectedDeliveryDate].contains(_selectedDeliveryDate)
                    ? _selectedDeliveryDate
                    : "Now", // Ensuring valid selection
                    (value) {
                  if (value == "Pick a date") {
                    _selectDate(context);
                  } else {
                    setState(() => _selectedDeliveryDate = value!);
                  }
                },
              ),
              SizedBox(height: screenWidth * 0.05),
              ElevatedButton(
                onPressed: _saveData,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, screenWidth * 0.12),
                  backgroundColor: secondaryColor,
                ),
                child: Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, double screenWidth, String selectedValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade400, width: 1.5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedValue,
              onChanged: onChanged,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade600, size: screenWidth * 0.06),
              items: items.toSet().map((item) { // Ensuring no duplicate items
                return DropdownMenuItem(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: screenWidth * 0.038,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, double screenWidth, {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
          ),
        ),
        SizedBox(height: screenWidth * 0.01),
        TextField(
          controller: controller,
          style: TextStyle(fontSize: screenWidth * 0.035),
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}