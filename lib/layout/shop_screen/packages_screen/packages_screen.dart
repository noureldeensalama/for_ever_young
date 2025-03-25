import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:for_ever_young/shared/colors_and_themes/color.dart';
import 'package:for_ever_young/shared/components.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  _PackagesScreenState createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  TextEditingController searchController = TextEditingController();
  String? selectedPackage;
  List<Map<String, dynamic>> packages = [];
  List<Map<String, dynamic>> filteredPackages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchPackages();
    searchController.addListener(() {
      filterPackages();
    });
  }

  Future<void> fetchPackages() async {
    try {
      var response = await Dio().get("https://your-api.com/packages");
      if (response.statusCode == 200) {
        setState(() {
          packages = List<Map<String, dynamic>>.from(response.data);
          filteredPackages = packages;
        });
      } else {
        throw Exception("Failed to load packages");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching packages: ${e.toString()}")),
      );
    }
  }

  void filterPackages() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredPackages = packages.where((package) {
        return package["name"].toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> saveToApi() async {
    if (selectedPackage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select a package first!")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var response = await Dio().post(
        "https://your-api.com/selected-packages",
        data: {
          "package": selectedPackage,
          "timestamp": DateTime.now().toIso8601String(),
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Package saved: $selectedPackage")),
        );
      } else {
        throw Exception("Failed to save package");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving package: ${e.toString()}")),
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
        title: Text("Packages", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SELECT A PACKAGE",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenWidth * 0.03),
            defaultSearchField(
              controller: searchController,
              hintText: 'Search Packages',
              onTap: () {}, context: context,
            ),
            SizedBox(height: screenWidth * 0.05),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPackages.length,
                itemBuilder: (context, index) {
                  return _buildPackageCard(filteredPackages[index]);
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

  Widget _buildPackageCard(Map<String, dynamic> package) {
    bool isSelected = package["name"] == selectedPackage;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPackage = package["name"];
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
                      package["name"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isSelected ? secondaryColor : Colors.black,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      package["description"],
                      style: TextStyle(fontSize: 14, color: lightTextColor),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    package["price"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? secondaryColor : Colors.black,
                    ),
                  ),
                  Text("per Month", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Radio(
                    value: package["name"],
                    groupValue: selectedPackage,
                    activeColor: secondaryColor,
                    onChanged: (val) {
                      setState(() {
                        selectedPackage = val as String?;
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
