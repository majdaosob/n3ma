import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:n3ma/pages/dashboard.dart';
import 'package:n3ma/pages/welcome/welcome_screen.dart';
import 'package:n3ma/pages/location_tracking.dart';
import 'package:n3ma/pages/food_logs_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                );
              },
              icon: const Icon(Icons.home),
              iconSize: 30,
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationTrackingPage()),
                );
              },
              icon: const Icon(Icons.location_on_sharp),
              iconSize: 30,
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodLogsScreen()),
                );
              },
              icon: const Icon(Icons.inventory),
              iconSize: 30,
              color: Colors.black,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
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

 Widget bodyLayout() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "Username",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Spacer(),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ExpansionTile(
                  title: Text(
                    'Tips for Reducing Food Waste',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListTile(
                      title: Text('1. Plan your meals: Create a weekly meal plan and grocery list to avoid buying more food than you need.'),
                    ),
                    ListTile(
                      title: Text('2. Practice portion control: Serve smaller portions and encourage family members to take only what they can eat.'),
                    ),
                    ListTile(
                      title: Text('3. Store leftovers properly: Use airtight containers or resealable bags to store leftovers in the refrigerator or freezer.'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'Tips for Shopping Smart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListTile(
                      title: Text('1. Make a list: Prepare a shopping list before heading to the grocery store and stick to it to avoid impulse purchases.'),
                    ),
                    ListTile(
                      title: Text('2. Avoid overbuying: Be mindful of bulk discounts and special offers, as they may encourage you to buy more than you need.'),
                    ),
                    ListTile(
                      title: Text('3.  Read labels: Check product labels for information on shelf life, storage instructions, and portion sizes to minimize food waste.'),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(
                    'Tips for Food Storage',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListTile(
                      title: Text('1. Rotate items: Practice FIFO (first in, first out) rotation to ensure that older food items are consumed before newer ones.'),
                    ),
                    ListTile(
                      title: Text('2. Use proper containers: Invest in high-quality, airtight containers for storing dry goods, leftovers, and bulk purchases to extend shelf life.'),
                    ),
                    ListTile(
                      title: Text('3.  Freeze perishable items: Preserve excess fruits, vegetables, meats, and baked goods by freezing them in portion-sized containers or freezer bags.'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 20),
          ElevatedButton(
            onPressed: () {
              // Salsabil
            },
            child: const Text(
              "Environmental Dashboard",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WelcomeScreen()),
              );
            },
            child: const Text(
              "Sign out",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}
}
