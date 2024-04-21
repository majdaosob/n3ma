import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
    // Remove topImage and bottomImage from constructor parameters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Commented out the Positioned widget for the top image
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Image.asset(
            //     topImage,
            //     width: 120,
            //   ),
            // ),
            // Commented out the Positioned widget for the bottom image
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Image.asset(bottomImage, width: 120),
            // ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}