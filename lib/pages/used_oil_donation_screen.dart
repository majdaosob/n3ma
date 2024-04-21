import 'dart:async';

import 'package:flutter/material.dart';
import 'package:n3ma/pages/food_logs_screen.dart';
import 'package:n3ma/pages/location_tracking.dart';
import 'package:n3ma/pages/profile_screen.dart';
import 'package:n3ma/widgets/custom_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class UsedOilDonationScreen extends StatefulWidget {
  const UsedOilDonationScreen({super.key});

  @override
  State<UsedOilDonationScreen> createState() => _UsedOilDonationScreenState();
}

class _UsedOilDonationScreenState extends State<UsedOilDonationScreen> {
  String typeOfOil = "Vegetable Oil";
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(25.276987, 55.296249),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donate Used Oil',
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
        bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
              iconSize: 30,
              color:  Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationTrackingPage()));
              },
              icon: const Icon(Icons.location_on_sharp),
              iconSize: 30,
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodLogsScreen()));
              },
              icon: const Icon(Icons.inventory),
              iconSize: 30,
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              icon: const Icon(Icons.person),
              iconSize: 30,
              color: Colors.black,
            ),
          ],
        ),
      ),
      );
  }

  bodyLayout() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Enter oil quantity",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Container(height: 4),
          const CustomTextField(hint: "5 litres"),
          Container(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Type of oil",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Container(height: 4),
          InputDecorator(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(36)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: typeOfOil,
                items: <String>['Vegetable Oil'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  typeOfOil = val!;
                  setState(() {});
                },
              ),
            ),
          ),
          Container(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "Biofuel companies near you",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w700),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(34),
            child: Stack(
              children: [
                SizedBox(
                  height: 260,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
