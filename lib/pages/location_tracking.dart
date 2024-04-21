import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationTrackingPage extends StatefulWidget {
  const LocationTrackingPage({Key? key}) : super(key: key);

  @override
  State<LocationTrackingPage> createState() => LocationTrackingPageState();
}

class LocationTrackingPageState extends State<LocationTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng foodbank1 = LatLng(25.2623487, 55.3476292);
  static const LatLng foodbank2 = LatLng(24.9995782, 55.0402816);
  static const LatLng foodbank3 = LatLng(25.2569278,55.3051587);

  LocationData? currentLocation; 

void getCurrentLocation() async {
  Location location = Location();
  try {
    LocationData locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
  } catch (e) {
    print('Error getting location: $e');
    setState(() {
      currentLocation = null;
    });
  }
}

  @override
  void initState(){
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Food banks near you",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null 
      ? const Center(child: Text("Loading"))
      : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!), 
          zoom: 14.5),
          markers: {
             Marker(
              markerId: const MarkerId("currentLocation"),
              position: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!),
              ),
            const Marker(
              markerId: MarkerId("foodbank1"),
              position: foodbank1,
              ),
            const Marker(
              markerId: MarkerId("foodbank2"),
              position: foodbank2,
              ),
            const Marker(
              markerId: MarkerId("foodbank3"),
              position: foodbank3,
              ),
          }
          ),
      );
  }
}
