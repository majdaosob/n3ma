import 'package:flutter/material.dart';
import 'package:n3ma/pages/location_tracking.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:n3ma/pages/food_logs_screen.dart';
import 'package:n3ma/pages/profile_screen.dart';
import 'package:n3ma/pages/donate_spoiled_food_screen.dart';
import 'package:n3ma/pages/used_oil_donation_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
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
      body: Center(
  child: SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250, // Set the desired width for the button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodLogsScreen()));
            },
            child: Text('Food Inventory'),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 250, // Set the desired width for the button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LocationTrackingPage()));
            },
            child: Text('Donate Food'),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 250, // Set the desired width for the button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DonateSpoiledFoodScreen()));
            },
            child: Text('Donate Spoiled Food'),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 250, // Set the desired width for the button
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UsedOilDonationScreen()));
            },
            child: Text('Donate Used Oil'),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          width: 250, // Set the desired width for the button
          child: ElevatedButton(
            onPressed: () {
              // Navigate to Community Market screen
            },
            child: Text('Community Market'),
          ),
        ),
      ],
    ),
  ),
),
bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        surfaceTintColor: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()));
              },
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
}
