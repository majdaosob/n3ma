import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:n3ma/models/food_item.dart';
import 'package:n3ma/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class EditManualItemScreen extends StatefulWidget {
  const EditManualItemScreen({super.key});

  @override
  State<EditManualItemScreen> createState() => _EditManualItemScreenState();
}

class _EditManualItemScreenState extends State<EditManualItemScreen> {
  String? name, quantity, selectedCategory;
  DateTime selectedDate = DateTime.now();
  var nameController = TextEditingController();
  var quantityController = TextEditingController();

  late FoodItem item;

  @override
   Widget build(BuildContext context) {

    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    item = arguments[0];
    nameController.text = item.name;
    quantityController.text = item.quantity;

    name = item.name;
    quantity = item.quantity;
    selectedCategory = item.category;
    selectedDate = item.expiry.toDate();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Food Item',
          style: GoogleFonts.montserrat(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        bottomOpacity: 10,
      ),
      body: bodyLayout(), 
    );
  }

  bodyLayout() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: [
          CustomTextField(
            controller: nameController,
            hint: "Food name",
            onChanged: (val) => name = val,
          ),
          Container(height: 6),
          CustomTextField(
            controller: quantityController,
            hint: "Food Quantity",
            type: TextInputType.number,
             onChanged: (val) => quantity = val,
          ),
          SizedBox(height: 6),
          InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(36)),
            ),
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
              items: <String>[
                'Bread',
                'Milk',
                'Cheese',
                'Chicken',
                'Meats',
                'Fruits',
                'Vegetables'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 6),
          InkWell(
            onTap: () => _selectDate(context),
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(36)),
              ),
              child: Text(formattedDate),
            ),
          ),
          Container(height: 20),
          ElevatedButton(
            onPressed: () => addData(),
            child: const Text(
              "Update Item",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void addData() {
    SVProgressHUD.show();
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('food')
        .doc(item.key)
        .update({
      'name': name,
      'quantity': quantity,
      'category': selectedCategory,
      'expiry': selectedDate,
    }).then((value) {
      SVProgressHUD.dismiss();
      print("Data added successfully!");
      Navigator.pushNamedAndRemoveUntil(
          context, '/home', (Route<dynamic> route) => false);
    }).catchError((error) {
      SVProgressHUD.dismiss();
      print("Failed to add data: $error");
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
