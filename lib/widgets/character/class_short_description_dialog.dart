import 'dart:convert';
import 'package:flutter/material.dart';
import '../../screens/character/class_details.dart';

class ClassDescriptionBottomSheet extends StatefulWidget {
  final String className;
  final String description;

  const ClassDescriptionBottomSheet({
    super.key,
    required this.className,
    required this.description,
  });

  @override
  State<ClassDescriptionBottomSheet> createState() =>
      _ClassDescriptionBottomSheetState();
}

class _ClassDescriptionBottomSheetState
    extends State<ClassDescriptionBottomSheet> {
  String? _expandedTile; // Tracks the currently expanded tile

  @override
  Widget build(BuildContext context) {
    // Parse the description if it's JSON
    Map<String, dynamic>? jsonResponse;
    try {
      jsonResponse = jsonDecode(widget.description);
    } catch (e) {
      jsonResponse = null; // If parsing fails, treat it as plain text
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.className,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 16),
            if (jsonResponse != null) ...[
              if (jsonResponse['hit_die'] != null)
                ListTile(
                  title: Text(
                    'Hit Die',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${jsonResponse['hit_die']}'),
                ),
              if (jsonResponse['hit_die'] != null) Divider(),

              if (jsonResponse['proficiency_choices'] != null)
                ExpansionTile(
                  title: Text(
                    'Proficiency Choices',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: _expandedTile == 'proficiency_choices',
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      _expandedTile = isExpanded ? 'proficiency_choices' : null;
                    });
                  },
                  children:
                      jsonResponse['proficiency_choices']
                          .map<Widget>(
                            (choice) => ListTile(title: Text(choice['desc'])),
                          )
                          .toList(),
                ),
              if (jsonResponse['proficiencies'] != null) Divider(),

              if (jsonResponse['proficiencies'] != null)
                ExpansionTile(
                  title: Text(
                    'Proficiencies',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: _expandedTile == 'proficiencies',
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      _expandedTile = isExpanded ? 'proficiencies' : null;
                    });
                  },
                  children:
                      jsonResponse['proficiencies']
                          .map<Widget>(
                            (proficiency) =>
                                ListTile(title: Text(proficiency['name'])),
                          )
                          .toList(),
                ),
              if (jsonResponse['saving_throws'] != null) Divider(),

              if (jsonResponse['saving_throws'] != null)
                ExpansionTile(
                  title: Text(
                    'Saving Throws',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  initiallyExpanded: _expandedTile == 'saving_throws',
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      _expandedTile = isExpanded ? 'saving_throws' : null;
                    });
                  },
                  children:
                      jsonResponse['saving_throws']
                          .map<Widget>(
                            (savingThrow) =>
                                ListTile(title: Text(savingThrow['name'])),
                          )
                          .toList(),
                ),
            ] else
              Text(widget.description), // Fallback for plain text
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed:
                      () => Navigator.of(context).pop(), // Close the sheet
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Navigate to the ClassDetails screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ClassDetailsScreen(className: widget.className),
                      ),
                    );
                  },
                  child: Text('Select'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
