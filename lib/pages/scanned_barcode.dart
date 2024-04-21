import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:n3ma/pages/food_logs_screen.dart';


class ScannedBarcodeScreen extends StatelessWidget {
  final String barcode;

  const ScannedBarcodeScreen({Key? key, required this.barcode})
      : super(key: key);

  Future<Map<String, dynamic>> getData() async {
    var response = await http.get(Uri.https(
        'world.openfoodfacts.org', '/api/v0/product/$barcode.json'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      Map<String, dynamic> data = json.decode(response.body);
      // Extract name and quantity
      String name = data['product']['product_name'];
      String quantity = data['product']['quantity'];
      // Return a map containing the extracted data
      return {'name': name, 'quantity': quantity};
    } else {
      // If the server response is not successful, throw an error
      throw Exception('Failed to load data');
    }
  }

 @override
Widget build(BuildContext context) {
  return FutureBuilder<Map<String, dynamic>>(
    future: getData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // Display a loading indicator while fetching data
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        // Display an error message if data fetching fails
        return Center(child: Text('Error: ${snapshot.error}'));
      } else {
        // Once data is fetched successfully, extract and display relevant information
        String name = snapshot.data!['name'];
        String quantity = snapshot.data!['quantity'];

        return Scaffold(
          appBar: AppBar(
            title: Text('Product Details'),
          ),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: $name',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                Text(
                  'Quantity: $quantity',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FoodLogsScreen()));
                      },
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        addData(name, quantity);
                      },
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    },
  );
}
}

  void addData(String name, String quantity) {
    SVProgressHUD.show();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('food')
        .add({
      'name': name,
      'quantity': quantity,
      'category': 'No category',
      'expiry': 2024-01-01,
    }).then((value) {
      SVProgressHUD.dismiss();
      print("Data added successfully!");
    Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => FoodLogsScreen())); // Navigate to FoodLogsScreen
    }).catchError((error) {
      SVProgressHUD.dismiss();
      print("Failed to add data: $error");
    });
  }