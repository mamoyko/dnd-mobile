import 'package:http/http.dart' as http;

const String version = "2014";
const String apiUrl = 'https://www.dnd5eapi.co/api/$version';

class DndServices {
  static final Map<String, String> dndClassesWithImages = {
    'Barbarian': 'assets/images/characters/Barbarian.JPG',
    'Bard': 'assets/images/characters/Bard.JPG',
    'Cleric': 'assets/images/characters/Cleric.JPG',
    'Druid': 'assets/images/characters/Druid.JPG',
    'Fighter': 'assets/images/characters/Fighter.JPG',
    'Monk': 'assets/images/characters/Monk.JPG',
    'Paladin': 'assets/images/characters/Paladin.JPG',
    'Ranger': 'assets/images/characters/Ranger.JPG',
    'Rogue': 'assets/images/characters/Rogue.JPG',
    'Sorcerer': 'assets/images/characters/Sorcerer.JPG',
    'Warlock': 'assets/images/characters/Warlock.JPG',
    'Wizard': 'assets/images/characters/Wizard.JPG',
  };

  static Future<String> getClassDescription(String className) async {
    final response = await http.get(Uri.parse('$apiUrl/classes/$className'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load class description');
    }
    return response.body;
  }

  // static Future<String> getClassImage(String className) async {
  //   final response = await http.get(Uri.parse('$apiUrl/classes/$className'));
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to load class image');
  //   }
  //   return response.body;
  // }
}
