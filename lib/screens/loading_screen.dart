import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dart:async';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState(); // Made the state class public
}

class LoadingScreenState extends State<LoadingScreen> {
  // Removed the underscore to make it public
  @override
  void initState() {
    super.initState();

    // Simulate a delay (e.g., fetching user data)
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Loading...", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
