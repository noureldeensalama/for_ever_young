import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/components.dart';

class MembershipsScreen extends StatefulWidget {
  const MembershipsScreen({super.key});

  @override
  _MembershipsScreenState createState() => _MembershipsScreenState();
}

class _MembershipsScreenState extends State<MembershipsScreen> {
  TextEditingController searchController = TextEditingController();
  String? selectedMembership;
  bool isLoading = false; // Track loading state

  List<Map<String, String>> memberships = [
    {
      "name": "Basic Membership",
      "price": "\$79.00",
      "description": "Affordable plans with essential services."
    },
    {
      "name": "Restore Membership",
      "price": "\$129.00",
      "description": "Enjoy customized treatments and exclusive discounts."
    },
    {
      "name": "Elite Membership",
      "price": "\$199.00",
      "description": "Priority access, premium discounts, and more benefits."
    },
  ];

  List<Map<String, String>> filteredMemberships = [];

  @override
  void initState() {
    super.initState();
    filteredMemberships = memberships;
    searchController.addListener(filterMemberships);
  }

  void filterMemberships() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredMemberships = memberships.where((membership) {
        return membership["name"]!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> saveToApi() async {
    if (selectedMembership == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a membership first!")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var response = await Dio().post(
        "https://your-api.com/memberships", // Replace with your actual API URL
        data: {
          "membership": selectedMembership,
          "timestamp": DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Membership saved: $selectedMembership")),
        );
      } else {
        throw Exception("Failed to save membership");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving membership: ${e.toString()}")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Memberships", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SELECT A MEMBERSHIP",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.03),
            defaultSearchField(
              controller: searchController,
              hintText: 'Search Memberships',
              onTap: () {}, context: context,
            ),
            SizedBox(height: screenWidth * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMemberships.length,
                itemBuilder: (context, index) {
                  return _buildMembershipCard(filteredMemberships[index]);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : saveToApi,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, screenWidth * 0.12),
                backgroundColor: secondaryColor,
              ),
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                "Confirm Selection",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipCard(Map<String, String> membership) {
    bool isSelected = membership["name"] == selectedMembership;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMembership = membership["name"];
        });
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: isSelected ? secondaryColor : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      membership["name"]!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isSelected ? secondaryColor : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      membership["description"]!,
                      style: TextStyle(fontSize: 14, color: lightTextColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    membership["price"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? secondaryColor : Colors.black,
                    ),
                  ),
                  Text("per Month", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Radio(
                    value: membership["name"]!,
                    groupValue: selectedMembership,
                    activeColor: secondaryColor,
                    onChanged: (val) {
                      setState(() {
                        selectedMembership = val;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}