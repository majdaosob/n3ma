import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:n3ma/models/food_item.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:n3ma/pages/dashboard.dart';
import 'package:n3ma/pages/location_tracking.dart';
import 'package:n3ma/pages/profile_screen.dart';

class FoodLogsScreen extends StatefulWidget {
  const FoodLogsScreen({super.key});

  @override
  State<FoodLogsScreen> createState() => _FoodLogsScreenState();
}

class _FoodLogsScreenState extends State<FoodLogsScreen> {
  var models = <FoodItem>[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Food Inventory',
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
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.pushNamed(context, '/add_log_item'),
          label: const Text("Add Log"),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.white,
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

  bodyLayout() {
    return models.isNotEmpty
        ? ListView.builder(
            itemCount: models.length,
            itemBuilder: (_, index) {
              var item = models[index];
              return Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 6),
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 3.0,
                      )
                    ]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            '/edit_log_item',
                            arguments: [item],
                          ),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => showAlertDialog(item),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Quantity: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.quantity,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Category: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          item.category ?? 'No category',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Expiry Date: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          DateFormat('EEE dd,yyyy')
                              .format(item.expiry.toDate()),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          )
        : Container();
  }

  showAlertDialog(FoodItem item) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Delete"),
      onPressed: () {
        Navigator.pop(context);

        SVProgressHUD.show();
        User? user = FirebaseAuth.instance.currentUser;
        FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .collection('food')
            .doc(item.key)
            .delete();

        getData();
        SVProgressHUD.dismiss();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Wait"),
      content: const Text("Are you sure you want to delete this food item"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void getData() {
    models = [];
    User? user = FirebaseAuth.instance.currentUser;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('food')
        .get()
        .then((QuerySnapshot querySnapshot) {
      print(querySnapshot.size);
      for (var doc in querySnapshot.docs) {
        var item = FoodItem.fromJson(doc.data());
        item.key = doc.id;
        models.add(item);
      }
      setState(() {});
    }).catchError((error) {
      print("Failed to fetch data: $error");
    });
  }
}
