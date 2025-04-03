import 'package:flutter/material.dart';
import '../../services/dnd_services.dart'; // Import your DnD services

class ClassDetailsScreen extends StatefulWidget {
  final String className;

  const ClassDetailsScreen({super.key, required this.className});

  @override
  _ClassDetailsScreenState createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  bool _isLoading = true; // Track loading state
  String? _description; // Store the fetched description
  String? _errorMessage; // Store any error messages

  @override
  void initState() {
    super.initState();
    _fetchClassDescription(); // Fetch the class description when the screen loads
  }

  Future<void> _fetchClassDescription() async {
    try {
      final classNameFormatted = widget.className.toLowerCase();
      final description = await DndServices.getClassDescription(
        classNameFormatted,
      );
      setState(() {
        _description = description;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error fetching class description.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.className,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white, // Ensure contrast with the AppBar background
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(),
                ) // Show a loading spinner
                : _errorMessage != null
                ? Center(
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Class name styled as a headline
                      Text(
                        widget.className,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Class description
                      Text(
                        _description ?? 'No description available.',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5, // Improve readability with line height
                        ),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
