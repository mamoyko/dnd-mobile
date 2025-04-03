import 'package:flutter/material.dart';
import './auth/login_screen.dart';
import './character/create_character.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Simulate a login check (Replace with real authentication logic)
  bool _isUserLoggedIn() {
    return true; // Assume the user is logged in
  }

  @override
  Widget build(BuildContext context) {
    return _isUserLoggedIn()
        ? Scaffold(
          appBar: AppBar(title: const Text("Home")),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Create Character Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateCharacter(),
                  ),
                );
              },
              child: const Text("Create Character"),
            ),
          ),
        )
        : const LoginScreen(); // Show login page if not logged in
  }
}
