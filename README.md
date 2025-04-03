# DnD Mobile App

This is a Flutter-based mobile application designed to provide a smooth user experience with a loading screen that transitions to the home screen.

## Features

- **Loading Screen**: Displays a loading indicator and a message while simulating a delay (e.g., fetching user data).
- **Navigation**: Automatically transitions from the loading screen to the home screen after a delay.

## Screens

### Loading Screen

The `LoadingScreen` is the initial screen of the app. It shows a `CircularProgressIndicator` and a "Loading..." message. After a 2-second delay, it navigates to the `HomeScreen`.

#### Code Example

```dart
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
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
```
