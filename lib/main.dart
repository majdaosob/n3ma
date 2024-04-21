import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:n3ma/pages/app_behavour.dart';
import 'package:n3ma/pages/edit_manual_item_screen.dart';
import 'package:n3ma/pages/screen_one.dart';
import 'package:device_preview/device_preview.dart';
import 'package:n3ma/pages/dashboard.dart';
import 'package:n3ma/pages/add_manual_item_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final bool isDevicePreviewEnabled = true; // or any condition to enable/disable DevicePreview

  runApp(isDevicePreviewEnabled
      ? DevicePreview(
          enabled: true,
          tools: const [
            ...DevicePreview.defaultTools,
          ],
          builder: (context) => MyApp(), // Wrap your app
        )
      : const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: {
        '/dashboard': (context) => const Dashboard(),
        '/add_log_item':  (context) => const AddManualItemScreen(),
        '/edit_log_item': (context) => const EditManualItemScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(150,195,93,1)),
        useMaterial3: true,
      ),
      scrollBehavior: AppScrollBehavior(),
      home: const ScreenOne(),
    );
  }
}
