import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:n3ma/pages/dashboard.dart';
import 'package:n3ma/pages/location_tracking.dart';
import 'package:n3ma/pages/profile_screen.dart';
import 'package:n3ma/pages/food_logs_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DonateSpoiledFoodScreen extends StatefulWidget {
  const DonateSpoiledFoodScreen({super.key});

  @override
  State<DonateSpoiledFoodScreen> createState() =>
      _DonateSpoiledFoodScreenState();
}

class _DonateSpoiledFoodScreenState extends State<DonateSpoiledFoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donate Spoiled Food',
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

  bodyLayout() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Guidelines on donating spoiled food:",
            style: TextStyle(
                fontSize: 24, color: Colors.green, fontWeight: FontWeight.w700),
          ),
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " - Separate spoiled food from other waste",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  " - Remove any packaging materials",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  " - Ensure donated food is free from containment",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  " - Acceptable items include fruits, vegetables, bread etc",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Container(height: 20),
              ],
            ),
          ),
          const Text(
            "Composing facilities",
            style: TextStyle(
                fontSize: 24, color: Colors.green, fontWeight: FontWeight.w700),
          ),
          Container(height: 10),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey.shade100
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tadweer",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                ),
                Container(height: 4),
                Text("Warsan 2",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),),
                Text("Dubai",
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),),
                Container(height: 14),
                Center(
                  child: SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () async {
                        const url = 'https://maps.app.goo.gl/qdx8gapNMLvs2hEx5';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: const Text("Visit"),
                    ),
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
