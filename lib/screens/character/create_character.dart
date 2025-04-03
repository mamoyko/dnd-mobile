import 'package:flutter/material.dart';
import '../../services/dnd_services.dart';
import '../../widgets/character/class_short_description_dialog.dart';

class CreateCharacter extends StatefulWidget {
  const CreateCharacter({super.key});

  @override
  State<CreateCharacter> createState() => _CreateCharacterState();
}

class _CreateCharacterState extends State<CreateCharacter> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, String> dndClassesWithImages =
        DndServices.dndClassesWithImages;

    return Scaffold(
      appBar: AppBar(title: Text('Character Creation')),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dndClassesWithImages.length,
            itemBuilder: (context, index) {
              final className = dndClassesWithImages.keys.elementAt(index);
              final classImage = dndClassesWithImages[className]!;
              final classNameFormatted = className.toLowerCase();
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });

                  String description;
                  bool shouldShowBottomSheet = true;

                  try {
                    description = await DndServices.getClassDescription(
                      classNameFormatted,
                    );
                  } catch (e) {
                    description = 'Error fetching class description.';
                  } finally {
                    if (!mounted) {
                      shouldShowBottomSheet = false;
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }

                  // Ensure the widget is still mounted before using BuildContext
                  if (shouldShowBottomSheet && mounted) {
                    if (context.mounted) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.0),
                          ),
                        ),
                        builder:
                            (context) => ClassDescriptionBottomSheet(
                              className: className,
                              description: description,
                            ),
                      );
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(classImage, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Text(
                          className,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: CreateCharacter()));
}
