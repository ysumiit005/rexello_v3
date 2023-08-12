import 'dart:async';
import 'package:flutter/material.dart';

import '../view_by_screen/view_by_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final ImageProvider imageProvider = const AssetImage('assets/images/rexello_logo.png');
  bool _uiReady = false;
  @override
  void initState() {
    super.initState();
    // Timer(const Duration(seconds: 2), () {
    //   // After 5 seconds, navigate to the next screen.
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => const ViewByScreen()),
    //   );
    // });
    _buildUI().then((_) {
      setState(() {
        _uiReady = true;
      });
    });
  }

  Future<void> _buildUI() async {
    const ViewByScreen(
      initialTabIndex: 0,
    );

    // Simulate the time it takes to build the UI
    await Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.pushReplacementNamed(context, '/home'));
    // You can add your UI building code here
  }

  @override
  Widget build(BuildContext context) {
    final mobHeight = MediaQuery.of(context).size.height;
    final mobWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: mobHeight,
        width: mobWidth,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            // blank space from top
            //
            SizedBox(
              height: mobHeight * 0.31,
            ),
            //
            // rexello logo
            //
            Image(
              image: imageProvider,
              height: mobHeight * 0.2,
              width: mobWidth * 0.64,
            ),
            //
            // blank space below
            //
            SizedBox(
              height: mobHeight * 0.1,
            ),
            //
            // loading box
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //
                // loader animation
                //
                SizedBox(
                  height: mobHeight * 0.04,
                  width: mobHeight * 0.04,
                  child: const CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                const Text(
                  "Loading... ",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 19,
                    fontWeight: FontWeight.normal, //regular
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
